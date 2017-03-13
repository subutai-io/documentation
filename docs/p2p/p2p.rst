Subutai P2P
======================================================

Overview
--------------------

Subutai P2P is a tool used to build private mesh networks. 

Usage
--------------------

Building from source
^^^^^^^^^^^^

p2p can be built simple by running ``make`` command under GNU/Linux. On other platform you can use `go build` command. Make sure p2p dependencies installed first by running::

    go get

By default, running `make` command on Linux will produce binaries for Windows and MacOS as well. If you don't need them, simple run::

    make linux

However, simply running `go build` will work too. 

.. note:: If you're building p2p with `go build` command, running `p2p version` will not display proper version, which is always based on latest tag

Running
^^^^^^^

.. note:: MacOS and Windows Operating Systems require additional software. For MacOS a `TUN/TAP <http://tuntaposx.sourceforge.net/>`_ driver should be installed. On Windows, `TAP-Windows NDIS-6 <https://openvpn.net/index.php/open-source/downloads.html>`_ from OpenVPN suite should be installed.

p2p application is divided to two parts: daemon and client. Daemon is a special mode, which should be started as root::

    p2p daemon

It is better to start daemon in background. Daemon creates a local RPC server which waits for incoming commands from p2p client. Client is a control application that accepts command-line arguments, parses them and sends to a daemon. To get detailed help about p2p or any specific command you can use::

    # Show general help
    p2p help
    # Show detailed information about daemon subcommand
    p2p help daemon

The bare minimum to start a p2p instance is to run p2p client with the following arguments::

    p2p start -ip 10.10.10.1 -hash myhash

This will start a p2p instance with hash *myhash*. Other network participants should provide the same hash in order to establish a network connection with your computer. The IP address provided as -ip argument will be used for a new TUN/TAP network interface. 

.. note:: In order to run on MacOS user should create additional configuration file named **config.yaml** with the following contents: ``iptool: ifconfig``. This is required because MacOS doesn't have ``ip`` tool like Linux does.

You can provide additional arguments during network start if you want to customize your network. 

Here is a list of supported arguments::

    -dev <NAME> will create TAP-interface with provided name
    -dht <HOST:PORT> will use specified DHT server
    -fwd flag will force p2p to disable discovery of nearby hosts and will use proxy to pass traffic. This will make your connection much slower in a case when proxy is overloaded.
    -mac <HW_ADDR> - created TAP-interface will have provided hardware address
    -port <PORT> - p2p will listen to this port for incoming connections
    -ports <MIN-MAX> - p2p will use specified range of ports for communication
    -ttl <KEYTIME> - specified AES-key will be used before specified timestamp. Note, that this is not Time-To-Live!

To stop p2p connection you should use ``p2p stop -hash <HASH>`` command with a hash of network you wish to stop. If you have multiple networks you want to stop - you should run this command multiple times for each hash. This will also remove network entry from save file and network will not be restored after daemon restart.

Modifying network behaviour
"""""""""""""""""""""""""""

You can use set command to modify particular network. You should specify hash of target network by providing hash argument. For example, if you want to set log level for network test-hash you should run the following command: ``p2p -set -hash test-hash -log DEBUG``. Available log levels is *TRACE*, *DEBUG, *INFO, *WARNING, *ERROR*

Also, set can be used to update crypto-key (for example, you may want to add some new AES-key, that will be used after current key become obsolete)::
    p2p set -hash test-hash -key MYNEWAESKEY -ttl TIMESTAMP 
    
Command above will add provided key to a queue of keys.

Getting information about network
"""""""""""""""""""""""""""""""""

There is a set of commands available, that can be used to know status of p2p networks.

p2p show displays overall information about network or about particular network/peer::

    p2p show will display information about active networks: TAP Interface MAC address, IP of TAP interface and hash
    p2p show -hash <HASH> will display information about specified network in a form of table with information about peers: Peer ID, IP, Endpoint IP and MAC address
    p2p show -check <IP> will display integration status with particular peer. Also it will return zero exit code if peer was integrated into network (it is known to our p2p client) or non-zero exit code if it's not

p2p status is another useful command that display status of all peers know to p2p client with parser-friendly information structure. Much like ``p2p show -hash <HASH>``, but with some additional details, like latest error from peer communication

``p2p debug`` also will show information about known peers as well as some internal information, that might be useful to p2p developers. If you run into any troubles - execute p2p debug and send it to developers as well as p2p version command output
