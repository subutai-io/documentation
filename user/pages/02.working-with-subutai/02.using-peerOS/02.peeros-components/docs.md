---
title: Get to Know the PeerOS Components
visible: true
menu: PeerOS Components
taxonomy:
    category:
        - docs
---

Here are the integrated components behind the Subutai PeerOS:

<div class="scrollTable" markdown="1">

|Component|Description|
|--------------|-------------------------------------------|
|Debian package|Used to install PeerOS into resource hosts.|
|LXC (Linux Containers)|We use <a href="https://linuxcontainers.org/lxc/introduction/"> Linux containers </a> as basic building blocks for Subutai environments.|
|P2P Daemon|For intra-environment connectivity between containers, we use our homegrown [P2P Cloud](https://github.com/subutai-io/p2p).|
|Subutai Agent|We use <a href="https://github.com/subutai-io/agent"> Subutai Agent </a> on each resource host to expose its resources to the Console and Bazaar.|
|Management Console|The [Subutai Management Console](../../../software-components/management-console) of the Management Software is an application that exposes peer functionality and allows it to be registered with Bazaar.|

</div>
