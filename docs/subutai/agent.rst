Subutai Agent
=============

Overview
--------

The **Subutai Social Agent** performs low level operations on **Resource Hosts**.

It communicates with a **Management Server**, and executes the required commands to control LXC containers.

Initialization
^^^^^^^^^^^^^^

The first step of Subutai Agent initialization involves reading its config file to load its required parameters.

After starting, the Subutai Agent generates the required GPG-keys and SSL-certificates. If keys have already been generated the Agent reuses them.

When all parameters have been configured, it connects to the Management Server.

After initialization the Agent service starts goroutines for:

* Collecting system performance metrics and store them in a time-series database - InfluxDB;
* Monitoring connections to the Management Server, and reconnecting the Agent if required;
* Processing alert events to send notifications to the Management Server;
* Checking SSH-tunnels and recreating fresh ones if existing connections break;
* Sending heartbeats to the Management Server;

After all background services start initialization completes. All these goroutines continue working independently in the background.

Connection to Subutai Management Server
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The primary aim of the Subutai Agent is to interact with the Management Server.

Before getting requests from the Management Server the Agent should be connected to it. After sending a connection request the Resource Host must be approved by an administrator of the peer from the Management Server's Web UI.

After initialization, the Subutai Agent checks to see if the Management Server is available. After this step the Agent tries to verify if this Resource Host has already been approved and is ready to perform work:

1. If the Management Server is reachable and the Resource Host is already approved - the Agent starts normal operations;
2. If the Management Server is reachable and the Resource Host is not approved - the Agent sends a connection request to be approved;

The connection request to the Management Server is JSON with following fields:

* ID;
* Hostname;
* Public GPG-key;
* Public SSL-cert;
* Secret;
* List of network interfaces;
* Host architecture;
* List of LXC containers;

The Agent keeps periodically sending connection requests until the Management server accept one with a required HTTP status. When the request is accepted, the Agent still keeps checking until the RH is approved.

If any of steps fail the Subutai Agent will continue retrying until it gets a successful response.

The connection step requires approval for security reasons to prevent the addition of forbidden hosts to peer. The connection request exchanges GPG-keys between the Subutai Agent and the Management Server.

After approving the Resource Host all interconnections between the Management Server and the Subutai Agent will be secured by a bi-directionally authenticated SSL connection.

The Subutai Agent tracks the connection state to the Management Server and reinitializes it if required.

Heartbeat
^^^^^^^^^

When the Subutai Agent has initialized and is connected to the Management Server it starts sending heartbeats periodically.

Every 30 seconds the Subutai Agent checks if any new information can be transferred to the Management Server.

Every heartbeat is a JSON message with following fields:

* ID;
* Type;
* Hostname;
* Architecture;
* Instance type;
* List of containers;
* List of network interfaces;
* List of active alerts;

The Subutai Agent sends a full heartbeat after each reconnect to Management Server. After this, it sends heartbeats only with changes ignoring duplicates. On the Subutai Agent process exiting it sends additional force heartbeat to update Management Server.

In addition to checking for changes on every heartbeat (every 30 seconds), the Subutai Agent preemptively issues a new heartbeat after any action requested by the Management Server. For example, if the Management Server sends a command to clone a container, the Agent will send its heartbeat immediately instead of waiting for the next scheduled time to send the changes immediately.

Since requests from the Management Server can be processed in parallel we use additional throttling techniques to reduce load: if the previous heartbeat was sent less then 5 seconds ago and an action is taken, instead of sending a new heartbeat immediately we delay it for 5 seconds. This tactic keeps load from heartbeat operations low to be able to respond to Management Server requests quickly.

The Subutai Agent repeats sending heartbeat to the Management Server until get accept status.

We are planning to add sending incremental changes in the heartbeat to prevent sending full heartbeat every time.

Request/Response
^^^^^^^^^^^^^^^^

The Subutai Agent listens on a port **7070** to respond to commands.

The Management Server uses this HTTP service send commands to the Agent. The following endpoints are used:

* ``/trigger`` - to force the Agent to get a list of new commands;
* ``/ping`` - to check if the Agent is alive;
* ``/heartbeat`` - to force sending heartbeat before the next scheduled time.

When the Management Server triggers the Agent to pull new commands, the Agent can get one or several commands from the queue if present. Received commands may be executed in parallel without waiting others before them to finish.

When a single command is executed, the Agent collects stdout and stderr outputs, the exit code of the command and sends it back to Management Server in the response.

Command execution
^^^^^^^^^^^^^^^^^

The Management Server can set a time limit for command execution. The command will be interrupted when the time limit is reached.

The command could be sent in ``daemon`` mode. In this case the command will be never be interrupted.

Commands can be executed on the Resource Host or on any of its containers.

Alerts
^^^^^^

The Subutai Agent continuously collects information about the system and containers.

Following information is collected for monitoring:

* CPU load;
* RAM usage;
* Disk usage.

The Subutai Agent collects the latest data in memory to optimize performance for generating alerts. Only containers with set thresholds will be processed by the alert system.

If any available alert information will be sent to the Management Server within the next heartbeat. Alerts of exceeding thresholds will keep being delivered while above the limit.

Restore container state
^^^^^^^^^^^^^^^^^^^^^^^

When new containers are cloned and started, each container stores its state in the special file. The Subutai Agent reads this state periodically to restore the container to its intended state if different.

So if a container was started, after system restart the Subutai Agent will start all containers that were active. Stopped containers will be kept in the stopped state.

A special protection mechanism is used to restore system to its intended state. If a container is broken, the Subutai Agent tries to restore its state 5 times with some delay. If not successful, the container is marked as broken and future restore operations are abandoned the broken container.

Agent Commands
--------------

.. _subutai-agent-attach:

attach
^^^^^^

``attach [options] <container name>`` - attach to container

Options::

    --clear, -c     attach with clear environment 
    --x86, -x       use x86 personality
    --regular, -r   connect as regular user

Example::

    subutai attach container1

Description:

Allows user to use container's TTY. ``<container name>`` - should be available 
running Subutai container, otherwise command will return error message and 
non-zero exit code. This command is **not fully implemented**, please use 
lxc-attach <container name> command instead.

.. _subutai-agent-backup:

backup
^^^^^^

``backup [options] <container name>`` - backup Subutai container

Options::

    --full, -f  make full backup  
    --stop, -s  stop container at the time of backup

Example:

``subutai backup container1``

Description:

Subutai backup takes a snapshots of each container's volume and stores it in the ``/mnt/backups/container_name/datetime/`` directory.

A full backup creates a delta-file of each BTRFS subvolume. An incremental backup (default) creates a delta-file with the difference of changes between the current and last snapshots.

All deltas are compressed to archives in ``/mnt/backups/`` directory (``container_datetime.tar.gz`` or ``container_datetime_Full.tar.gz`` for full backup).

A changelog file can be found next to backups archive (container_datetime_changelog.txt or container_datetime_Full_changelog.txt) which contains a list of changes made between two backups.

.. _subutai-agent-batch:

batch
^^^^^^^^

``batch -json <json command>`` - batch commands execution

Example::

    subutai batch -json \ 
        '[{"action": "clone", "args": ["master", "container1"]}, {"action": "clone", "args": ["master", "container2"]}]'

Description:

The batch binding provides a mechanism to perform several Subutai commands in the container in batch, passed in a single JSON message. Initially, the purpose of this command was internal for SS <-> Agent communication, yet it may be invoked manually from the CLI. The response from a batch command returns a JSON array with each element representing the results (response) from each command (request) in the batch: the positions of responses correlate with the request position in the array:

requesting localhost system information and IP address::

    subutai batch -json \
        '[{"action": "info", "args": ["system", "localhost"]}, {"action": "info", "args": ["ipaddr"]}]'

first element in response array is system information, second - IP address::

    [{
        "output": "{
        "host":"localhost",  
        "CPU":{
            "model":" Intel(R) Core(TM) i7-4510U CPU @ 2.00GHz",  
            "coreCount":2,  
            "idle":97.79661016949153,  
            "frequency":" 1995.380"  
        },
        "Disk":{  
            "total":107374182400,  
            "used":4024963072
        },  
        "RAM":{  
            "free":118759424,  
            "total":2098094080  
        }}",  
        "exitcode": "0"
        }, {  
            "output": "192.168.0.101",  
            "exitcode": "0"  
    }]



.. _subutai-agent-clone:

clone
^^^^^

``clone [options] <template> <container>`` - clone Subutai container

Options::

    --ipaddr, -i "<IPv4>/<mask> <vlan tag>"             set container IP address and VLAN
    --env, -e <string id>                               set environment id for container
    --token, -t <string token>                          token to verify with MH

Examples::

    subutai clone master container1
    subutai clone -i "192.168.0.200/24 10" zabbix z1

Description:

The clone command creates new ``<container>`` from a Subutai ``<template>``. 
If the specified template argument is not deployed in system, Subutai first tries to import it, and if import succeeds, it then continues to clone from the imported template image. By default, clone will use the NAT-ed network interface with IP address received from the Subutai DHCP server, but this behavior can be changed with command options described below.

If ``-i`` option is defined, separate bridge interface will be created in 
specified VLAN and new container will receive static IP address.

Option ``-e`` writes the environment ID string inside new container. 
Option ``-t`` is intended to check the origin of new container creation 
request during environment build. This is one of the security checks which 
makes sure that each container creation request is authorized by registered user.

The clone options are not intended for manual use: unless you're confident 
about what you're doing. Use default clone format without additional options 
to create Subutai containers.

.. _subutai-agent-cleanup:

cleanup
^^^^^^^^

``cleanup <vlan tag>`` - completely destroys a Subutai environment along with all assets associated with it

Example:

``subutai cleanup 101``

Description:

The cleanup command takes the environment's VLAN tag as its only argument. It performs a number of operations on the system to remove all resources associated with the environment and its tag components: containers, network interfaces, proxy service configurations, environment statistics, etc.

.. _subutai-agent-config:

config
^^^^^^^^

``subutai config <container> [options]`` - edit container config

Options::

    --operation, -o <add|del>   operation
    --key, -k <string key>  configuration key
    --value, -v <string value>  configuration value

Example:

``subutai config container1 -o add -k "user.key" -v "user.value"``

Description:

Config binding allows read and write container's configuration file through command line.

.. _subutai-agent-daemon:

daemon
^^^^^^^^

``subutai daemon`` - starts the Subutai agent

Description:

The daemon command starts the Subutai agent process. On startup the daemon immediately attempts to establish a connection with the SS Management Service on the peer.

.. _subutai-agent-demote:

demote
^^^^^^^^

``demote [options] <template>`` - demote a Subutai template

Options::

    --ipaddr, -i "<IPv4>/<mask>"       IP address
    --vlan, -v <string id>             VLAN tag

Examples::

    subutai demote master
    subutai demote -i "10.10.0.100/24" openjre8

Description:

A Subutai template is a "locked down" container only to be used for cloning purposes. It cannot be started, and its file system cannot be modified: it's read-only. Normal operational containers are promoted into templates, but sometimes you might want to demote them back to regular containers. This is what the demote sub command does: it reverts a template without children back into a normal container.

Demoted container will use NAT network interface and dynamic IP address if opposite options are not specified.

.. _subutai-agent-destroy:

destroy
^^^^^^^^

``destroy <instance> [options]`` - destroys a Subutai container or template

Options::

    --vlan, -v  destroy environment by VLAN tag

Examples::

    subutai destroy container1
    subutai destroy 101 -v

Description:

Simply removes every resource associated with a Subutai container or template: data, network, configs, etc.

The destroy command always runs each step in "force" mode to provide reliable deletion results; even if some instance components were already removed, the destroy command will continue to perform all operations once again while ignoring possible underlying errors: i.e. missing configuration files.
Flag ``-v`` tells to the command to consider passed argument as environment VLAN tag and destroy all related components, such as containers, network interfaces, gateways, proxy configurations, etc.

.. _subutai-agent-export:

export
^^^^^^^^

``export [options] <container>`` - exports a Subutai container

Options::

    --version, -v <string version>  template version
    --size, -s <string size>        template preferred size ("tiny", "small", "medium", "large", "huge")
    --token, -t <token>             sets the user token for uploading template to Kurjun server
    --private, -p                   flag sets the private option for template on Kurjun server

Examples::

    subutai export container1
    subutai export -v 1.0.1-beta -s medium container2
    subutai export c1 -t 637b4cb391f0189adfe77ab4b3b4a85730a6f0af13b3751c491b2665d3118770 -p
    subutai export c2 -t 637b4cb391f0189adfe77ab4b3b4a85730a6f0af13b3751c491b2665d3118770

Description:

The export sub command prepares an archive from a template in the ``/mnt/lib/lxc/tmpdir/`` path. This archive can be moved to another Subutai peer and deployed as ready-to-use template or uploaded to Subutai's global template repository to make it widely available for others to use.

Export consist of two steps if the target is a container: container promotion to template (see "promote" command) and packing the template into the archive. If already a template just the packing of the archive takes place.

Configuration values for template metadata parameters can be overridden on export, like the recommended container size when the template is cloned using -s option. The template's version can also specified on export so the import command can use it to request specific versions.

.. _subutai-agent-hostname:

hostname
^^^^^^^^

``hostname <container name> <new name>`` - sets the hostname of a container

``hostname <new RH name>`` - sets the hostname of a RH

Example::

    subutai hostname container1 c1
    
    subutai hostname RH1

Description:

Hostname command changes container or RH configs to apply a new name for the it. Used for internal SS purposes.

.. _subutai-agent-info:

info
^^^^^^^^

``subutai info <options> <hostname>`` - get information about host system

Options::

    ipaddr    shows host external IP address
    system     system common information
    quota    container's resource quota 

Example::

    subutai info system localhost

Description:

The info command's purposed is to display common system information, such as external IP address to access the container host, quotas, its CPU model, RAM size, etc. It's mainly used for internal SS needs.

.. _subutai-agent-import:

import
^^^^^^^^

``import [options] <template>`` - import a Subutai template

Options::

    --torrent                        use BitTorrent for downloading (experimental)
    --version, -v <string version>   template version
    --token, -t <string token>       token to access private templates in global repository

Examples::

    subutai import master
    subutai import -v 4.0.2-dev management

Description:

The import command deploys a Subutai template on a Resource Host. The import algorithm works with both the global template repository and a local directory to provide more flexibility to enable working with published and custom local templates. Official published templates in the global repository have a overriding scope over custom local artifacts if there's any template naming conflict.

If Internet access is lost, or it is not possible to upload custom templates to the repository, the filesystem path ``/mnt/lib/lxc/tmpdir/`` could be used as local repository; the import sub command checks this directory if a requested published template or the global repository is not available.

The import binding handles security checks to confirm the authenticity and integrity of templates. Besides using strict SSL connections for downloads, it verifies the fingerprint and its checksum for each template: an MD5 hash sum signed with author's GPG key. Import executes different integrity and authenticity checks of the template transparent to the user to protect system integrity from all possible risks related to template data transfers over the network.

The template's version may be specified with the ``-v`` option. By default import retrieves the latest available template version from repository.

The repository supports public, group private (shared), and private files. Import without specifying a security token can only access public templates.

``subutai import management`` is a special operation which differs from the import of other templates. Besides the usual template deployment operations, "import management" demotes the template, starts its container, transforms the host network, and forwards a few host ports, etc.

.. _subutai-agent-list:

list
^^^^^^^^

``list [options]`` - lists Subutai instances

Options::

    --container, -c   containers only
    --template, -t    templates only
    --info, -i        detailed container info
    --ancestor, -a    with ancestors
    --parent, -p      with parent

Examples::

    subutai list -i
    subutai list -t -p

Description:

The list command shows a listing of Subutai instances with information such as IP address, parent template, etc.

.. _subutai-agent-metrics:

metrics
^^^^^^^^

``metrics -s <start date> -e <end date> <instance>`` - get instance metrics

Examples::

    subutai metrics localhost -s "2016-10-18 09:00:00" -e "2016-10-18 10:30:00"
    subutai metrics container1 -s "2016-10-12 04:30:00" -e "2016-10-18 22:40:00" 

Description:

The metrics command retrieves monitoring data from a time-series database deployed in the SS Management server for container hosts and Resource Hosts. Statistics are being collected by the Subutai daemon and includes common information like CPU utilization, network load, RAM and disk usage for both containers and hosts. Since the database is located on the SS Management Host, hosts which are not a part of a Subutai peer have no access to this information.

Data aggregation in the time-series database has following configuration:

* last hour statistic is stored "as is"
* last day data aggregates to 1 minute interval
* last week is in 5 minute intervals

After 7 days all statistics is are overwritten by new incoming data.

.. _subutai-agent-p2p:

p2p
^^^^^^^^

``subutai p2p <options> [arguments]`` - P2P network operations

Options::

    --create, -c        create p2p instance (interfaceName hash key ttl localPeepIPAddr portRange)
    --delete, -d        delete p2p instance by swarm hash
    --update, -u        update p2p instance encryption key (hash newkey ttl)
    --list, -l          list of p2p instances
    --peers, -p         list of p2p swarm participants by hash
    --version, -v       print p2p version

Example::

    subutai p2p -c p2p-net1 swarm-12345678-abcd-1234-efgh-123456789012 0123456789qwertyu0123456789zxcvbn 1476870551 10.220.22.1 0-65535

Descriptions:

Subutai's p2p command controls and configures the peer-to-peer network structure: the swarm which includes all hosts with same the same swarm hash and secret key. P2P is a base layer for Subutai environment networking: all containers in same environment are connected to each other via VXLAN tunnels and are accesses as if they were in one LAN. It doesn't matter where the containers are physically located.

.. _subutai-agent-promote:

promote
^^^^^^^^

``promote <container>`` - promote Subutai container to a template

Options::

    --source, -s "<container>"              set source container for promoting. Note: source container will be stopped and started.

Example::

    subutai promote container1

Description:

The promote binding turns a Subutai container into container template which may be cloned with "clone" command. Promote executes several simple steps, such as dropping a container's configuration to default values, dumping the list of installed packages (this step requires the target container to still be running), and setting the container's filesystem to read-only to prevent changes.

.. _subutai-agent-proxy:

proxy
^^^^^^^^

``proxy <add|check|del> <vlan tag> <options>`` - Subutai reverse proxy configuration

Options::

    Add :
    --domain, -d <string domain>        add domain to VLAN
    --host, -h <string IP>              add host to domain on VLAN
    --policy, -p <string policy>        set load balance policy (rr|lb|hash)
    --file, -f <path to .pem file>      pem certificate file
    
    Del:
    --domain, -d                delete domain from VLAN
    --host, -h <string IP>      delete host from domain on VLAN
    
    Check:
    --domain, -d                check domain on VLAN
    --host, -h <string IP>      check hosts in domain on vlan

Examples::

    subutai proxy add 100 -d example.com
    subutai proxy check 100 -d
    subutai proxy add 100 -h 10.10.0.20
    subutai proxy check 100 -h 10.10.0.20
    subutai proxy del 100 -d

Description:

The reverse proxy component in Subutai provides and easy way to assign domain name and forward HTTP(S) traffic to certain environment.

The proxy binding is used to manage Subutai reverse proxies. Each proxy subcommand works with config patterns: adding, removing or checking certain lines, and reloading the proxy daemon if needed, etc.

The reverse proxy functionality supports three common load balancing strategies - round-robin, load based and "sticky" sessions. It can also accept SSL certificates in .pem file format and install it for a domain.

.. _subutai-agent-quota:

quota
^^^^^^^^

``quota [options] <container> <resource> -s <quota>`` - sets resource quotas for Subutai containers

Options::

    --threshold, -t <percent> alert threshold value

Examples::

    subutai quota container1 ram
    subutai quota container1 cpuset -s 0-1
    subutai quota container1 rootfs -s 3 -t 80

Description::

Quota command controls container's quotas and thresholds. Available resources:

* cpu, %
* cpuset, available cores
* ram, Mb
* network, Kbps
* rootfs/home/var/opt, Gb

The threshold value represents a percentage for each resource. Once resource consumption exceeds this threshold it triggers an alert.

The clone operation, sets no quotas and thresholds for new containers; quotas need to be configured with quota command after a clone operation.

.. _subutai-agent-rename:

rename
^^^^^^^^

``rename <old name> <new name>`` - rename a Subutai container

Example::

    subutai rename container1 c1

Description:

Renames a Subutai container impacting filesystem paths, configuration values, etc.

.. _subutai-agent-restore:

restore
^^^^^^^^

``restore <container> -d <Unix timestamp> -c <new container>`` - restore a Subutai container from a backup

Example::

    subutai restore container1 -d 1476938900 -c container1-restored

Description:

Restores a Subutai container to a snapshot at a specified timestamp if such a backup archive is available.

.. _subutai-agent-start:

start
^^^^^^^^

``start <container>`` - start a Subutai container

Example::

    subutai start container1

Description:

Starts a Subutai container and checks if container state changed to "running" or "starting". If state is not changing for 60 seconds, then the "start" operation is considered to have failed.

.. _subutai-agent-stop:

stop
^^^^^^^^

``stop <container>`` - stop a Subutai container

Example::

    subutai stop container1

Description:

Stops a Subutai container with an additional state check.

.. _subutai-agent-tunnel:

tunnel
^^^^^^^^

``tunnel <add|del|list> [options]`` - SSH tunnel management

Options::

    add <dst IP>:[port] [ttl] [-g]      add ssh tunnel
    del <dst socket>                    delete ssh tunnel
    list                                list alive ssh tunnels 

Examples::

    subutai tunnel add 10.10.0.20
    subutai tunnel add 10.10.0.30:8080 300 -g
    subutai tunnel del 10.10.0.30:8080

Description:

The tunnel feature is based on SSH tunnels and works in combination with Subutai Helpers and serves as an easy solution for bypassing NATs. In Subutai, tunnels are used to access the SS management server's web UI from the Hub, and open direct connection to containers, etc. There are two types of channels - local (default), which is created from destination address to host and global (``-g`` flag), from destination to Subutai Helper node. Tunnels may also be set to be permanent (default) or temporary (``ttl`` in seconds). The default destination port is 22.

Subutai tunnels have a continuous state checking mechanism which keeps opened tunnels alive and closes outdated tunnels to keep the system network connections clean. This mechanism may re-create a tunnel if it was dropped unintentionally (system reboot, network interruption, etc.), but newly created tunnels will have different "entrance" address.

.. _subutai-agent-update:

update
^^^^^^^^

``update <rh|container> [options]`` - update a Subutai container or host

Options::

    --check, -c check if update is available but do not install 

Examples::

    subutai update container1
    subutai update rh -c

Description:

The update operation can be divided into two different types: container updates and Resource Host updates.

Container updates simply perform apt-get ``update`` and ``upgrade`` operations inside target containers without any extra commands. Since SS Management is just another container, the Subutai update command works fine with the management container too.

The second type of update, a Resource Host update, checks the Subutai repository and compares available snap packages with those currently installed in the system and, if a newer version is found, it downloads and installs it. Please note, system security policies requires that such commands should be performed by the superuser manually, otherwise an application's attempt to update itself will be blocked.

.. _subutai-agent-vxlan:

vxlan
^^^^^^^^

``subutai vxlan <options> <arguments>`` - manage VXLAN tunnels

Options::

    --create    , -c value      create VXLAN tunnel
    --delete, -d value      delete VXLAN tunnel
    --list, -l              list VXLAN tunnels
    --remoteip, -r value    VXLAN tunnel remote IP
    --vlan, --vl value      tunnel VLAN
    --vni, -v value         VXLAN tunnel VNI

Example::

    subutai vxlan --create vxlan1 --remoteip 10.220.22.2 --vlan 100 --vni 12345

Description:

Subutai VXLAN is network layer built on top of P2P swarms and intended to be environment communication bridges between physically separate hosts. Each Subutai environment has its own separate VXLAN tunnel so all internal network traffic goes through isolated channels, doesn't matter if environment located on single peer or distributed between multiple peers.

.. image:: https://cloud.githubusercontent.com/assets/13515865/19625492/fc15aee6-993b-11e6-8676-f81490d805b7.png

