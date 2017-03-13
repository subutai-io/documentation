Subutai Agent
=============

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
