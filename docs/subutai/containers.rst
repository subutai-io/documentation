Subutai Containers
==================

Introduction
^^^^^^^^^^^^

Container is a main component of whole Subutai architecture; based on Linux containers, Subutai have several own wrapper layers built around LXC which will be described in this article.

Here are a few words which better to be described before we start:

* **Resource Host, RH** - host with installed Subutai snap package (package includes Agent, LXC, OVS, BTRFS, etc.) which can run containers
* **Management** - Java application deployed inside Subutai container which main purpose is to control Resource host, Peer, Environment, etc. Single Management container can control multiple Resource hosts. Management has web-interface which is accessible on ``https://<Resource Host IP>:8338``
* **Peer** - logical unit which necessarily includes one Management container and at least one Resource host connected to this Management. All Resource hosts in the same LAN automatically connects to Management if it exists in this network and forms Peer. Each new Resource host connected to Management (except Resource Host, where Management located itself) should be manually approved in Management Web UI.
* **Environment** - logical structure formed by a set of common characteristics, such as single environment ID, P2P swarm and VLAN. Environment can be distributed to multiple resource hosts in single peer as well as to multiple peers and all containers inside this environment will have direct network access to each other; doesn't matter how "far" they are actually located.

Filesystem
^^^^^^^^^^

Subutai container uses Btrfs copy-on-write filesystem as backend because of such abilities as creating snapshots, subvolumes, flexible quota mechanism, etc. Snapshoting is a base feature for Subutai templates and backups, it allows us to have containers with almost zero size on disk and create tens of continers copy in a seconds. Subvolumes provides more flexibility and reliability in user data storing - each container has its own separate partition and, moreover, each container's main mountpoints are separated into subvolumes. Finally, quota mechanism provides us a way to comfortably tune allowed size for each of those subvolumes. All these functions and mechanism leads Subutai to reliable and effecient way of resource sharing and data management.

To start using Subutai with all described advantages, host should have at least one free volume available for Btrfs filesystem deployment. Subutai installation package contains ``btrfsinit`` script intended to provide an automated volume formatting, mounting and systemd unit preparation::

    btrfsinit /dev/sdd 

After this Btrfs backend is ready to deploy Subutai containers. Each container has four separate subvolume:

* rootfs
* home
* var
* opt

This structure provides more reliability in case of corruption of one of container's subvolume. Besides, each subvolume quota may be configured separately which gives more opportunity for disc usage optimization. 

Network
^^^^^^^

Subutai Network is a big topic and it deserves a separate page

Templates
^^^^^^^^^

Template is one of the basic element of Subutai architecture around which other functions are built. 
Name "template" clearly enough describes the role of this element - any product, 
doesn't matter how complex it is, may be presented as Subutai template file 
which can be quickly distributed and deployed within minutes on any Subutai 
host all over the Earth.

Template installation possible through Subutai CLI and executes with a single 
command - :ref:`subutai-agent-import`. 
All other underlying operations, consistency and security checks, hierarchy 
preparation will be performed automatically and as a result, after a few 
minutes (or seconds, depends on Internet connection bandwidth) template will 
be deployed in system. After message about successful finish, template is 
ready to be cloned (see :ref:`subutai-agent-clone`): ``subutai clone ceph c1``.

New Subutai template can be built on top of existing one; they will be called child and parent accordingly. This hierarchy allows anyone easily create its own template without doubts about properly configured base system. Besides, it gives big advantage in disc space usage: deployment of 10 containers with Hadoop requires only one root template, whereas 10 running instances will be just copy-on-write "clones" of this template.

Currently, Subutai has three root templates ("master" - Ubuntu 14.04, 
"ubuntu16" - Ubuntu 16.04 and "debian" - Debian 16.04) and many different 
commonly used products based on those parents.

Technically, template is just "locked-down" container which cannot be started; 
its filesystem is in read-only mode. Any container can be converted to 
template using :ref:`subutai-agent-promote` command and, vise-versa, 
:ref:`subutai-agent-demote` turns template into container.

Promoted container can be exported to template single archive which may be 
distributed to other hosts and then imported by putting file into 
``/mnt/lib/lxc/tmpdir`` or by publishing it to global Template Repository.

Template archive is consists of following content:

* Btrfs "deltas" is a set of binary files which are just difference between parent and child filesystems, result of btrfs send command.
* Configuration file with standard LXC and additional Subutai values related to network configuration, pre-start hooks, custom mountpoint, etc.
* "Packages" file which includes list of additionally installed debs comparing with parent's system. This information may be useful if user want to know how certain template was prepared.

Export command (see :ref:`subutai-agent-export`) is purposed to build such 
template archive. Custom template can be easily prepared in three steps:

* Create new container using certain parent template, for example: ``subutai clone openjre8 j1``
* Attach to new, ``lxc-attach j1`` and make required changes
* Quit container and run ``subutai export j1``.

That's it, template archive will be ready in a moment.

Security
^^^^^^^^



Subutai containers, Agent and other related processes run under root user privileges, however, this won't give more possibilities to take over host system even if attacker somehow manage to escape compromised container. All containers in system runs with shifted uids and gids which means that uid 0 (root) in the container is actually non-existent user with zero privileges in host system. Each Subutai container has its own dedicated range of uids and gids so unauthorized access between different containers even in the same environment is still not possible. Container's uids and gids ranges are set in configuration file with key "lxc.id_map".

As default system configuration each new container which is being created by Subutai doesn't have any forwarded network ports (except management Web interface) and, moreover, SSH server is configured not to accept password authentication; public key is the only way to access container's SSH. Subutai provides several ways to users to setup his SSH keys and have an unimpeded direct access to his containers, so by default other options are forbidden.

Monitoring
^^^^^^^^^^

Container (and host system) resources consumption monitoring is based on 
collecting data either by reading certain files from ``/proc`` or ``/sys`` 
system mountpoints or by executing utilities, such as ``df`` or ``btrfs``. 
These operations are executed by Subutai Agent continuously as background task with 10-30 seconds delay and gathered information is sent to Management server where it will be stored in time-series database. Monitoring data stored as array of points for each monitored resource, which are:

* Network: incoming, outgoing
* Disks: total, free
* CPU: user, nice, system, idle, iowait
* Memory: active, buffered, cached, free

Collected information may be retrieved from database using CLI command metrics (see :ref:`subutai-agent-metrics`), but result is not really human-friendly because it is mainly purposed to draw graphs in Management Web UI. For example, below is JSON with monitoring data for single container for period of 5 minutes:

    {"Metrics":[{"Series":[{"name":"lxc_cpu","tags":{"type":"system"},"columns":["time","value"],"values":[[1477237800,0],[1477237860,0],[1477237920,0],[1477237980,0],[1477238040,0],[1477238100,0]]},{"name":"lxc_cpu","tags":{"type":"user"},"columns":["time","value"],"values":[[1477237800,0],[1477237860,0],[1477237920,0],[1477237980,0],[1477238040,0],[1477238100,0]]}],"Messages":null},{"Series":[{"name":"lxc_net","tags":{"iface":"00163ee199a0","type":"in"},"columns":["time","value"],"values":[[1477237800,0],[1477237860,0],[1477237920,0],[1477237980,0],[1477238040,0],[1477238100,0]]},{"name":"lxc_net","tags":{"iface":"00163ee199a0","type":"out"},"columns":["time","value"],"values":[[1477237800,156],[1477237860,208],[1477237920,208],[1477237980,208],[1477238040,208],[1477238100,156]]}],"Messages":null},{"Series":[{"name":"lxc_memory","tags":{"type":"cache"},"columns":["time","value"],"values":[[1477237800,2.64192e+07],[1477237860,2.64192e+07],[1477237920,2.64192e+07],[1477237980,2.64192e+07],[1477238040,2.64192e+07],[1477238100,2.64192e+07]]},{"name":"lxc_memory","tags":{"type":"rss"},"columns":["time","value"],"values":[[1477237800,4.89472e+06],[1477237860,4.89472e+06],[1477237920,4.89472e+06],[1477237980,4.89472e+06],[1477238040,4.89472e+06],[1477238100,4.89472e+06]]}],"Messages":null},{"Series":[{"name":"lxc_disk","tags":{"mount":"home","type":"used"},"columns":["time","value"],"values":[[1477237800,16384],[1477237860,16384],[1477237920,16384],[1477237980,16384],[1477238040,16384],[1477238100,16384]]},{"name":"lxc_disk","tags":{"mount":"opt","type":"used"},"columns":["time","value"],"values":[[1477237800,16384],[1477237860,16384],[1477237920,16384],[1477237980,16384],[1477238040,16384],[1477238100,16384]]},{"name":"lxc_disk","tags":{"mount":"rootfs","type":"used"},"columns":["time","value"],"values":[[1477237800,1.72032e+07],[1477237860,1.72032e+07],[1477237920,1.72032e+07],[1477237980,1.72032e+07],[1477238040,1.72032e+07],[1477238100,1.72032e+07]]},{"name":"lxc_disk","tags":{"mount":"var","type":"used"},"columns":["time","value"],"values":[[1477237800,1.114112e+06],[1477237860,1.114112e+06],[1477237920,1.114112e+06],[1477237980,1.114112e+06],[1477238040,1.114112e+06],[1477238100,1.114112e+06]]}],"Messages":null}]}

To optimize time-series database performance and disc space usage, monitoring data is being aggregated according to following policy:

* information about last hour is not changing and stored as it comes, ie. with intervals 10-30 seconds, depends on SS <-> Agent communication activity
* last day monitoring data is composed of points with average values of 1 minute interval
* last 7 days aggregates to 5 minute intervals
* data older than 7 days is being flushed

Besides monitoring information, Subutai counts allocated resources and compares it with quota, configured for this particular container and type of resource. Next paragraph will describe it. 

Quotas
^^^^^^

Subutai has an option to setup resource quotas for running containers; using standard low-level system mechanisms, CLI command :ref:`subutai-agent-quota` provides a handy way to manage them.
Following resources may be limited by quota mechanism:

* Network quota uses OpenVswitch interface limitation policy to control traffic throughput
* Disk usage limits implemented by setting Btrfs quota parameter for each subvolume
* Cpu and Cpuset uses kernel cgroups mechanism to control CPU time and number of cores which can be used by containers processes
* Ram usage is controlled by LXC library which is based on low-level kernel functions

Besides setting resource quota, Subutai allows setup threshold values; for example, threshold of 80% for CPU usage will trigger the alert in Agent which will be sent to Management server for further alert steps. By default, newly created container doesn't have any quota - it should be configured separately, after clone operation.
Both, quota values and threshold values are saved to container configuration file to allow Agent process read it during check background tasks.

