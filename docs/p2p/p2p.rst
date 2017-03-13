Subutai P2P
======================================================

Overview
--------------------

Subutai P2P is a tool used to build private mesh networks. 

Usage
--------------------

Building from source
^^^^^^^^^^^^

p2p can be built simple by running `make` command under GNU/Linux. On other platform you can use `go build` command. Make sure p2p dependencies installed first by running::

    go get

By default, running `make` command on Linux will produce binaries for Windows and MacOS as well. If you don't need them, simple run::

    make linux

However, simply running `go build` will work too. 

.. note:: If you're building p2p with `go build` command, running `p2p version` will not display proper version, which is always based on latest tag

Running
^^^^^^^^^^^^

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
