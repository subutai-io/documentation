---
title: 'Using PeerOS'
visible: true
taxonomy:
    category:
        - docs
---

This section contains the instructions for installing and setting up Subutai PeerOS. As beginners or advanced users, you can learn how to create and run your own peers.

* **[The Subutai PeerOS: An Overview](#subutai-peeros)**
* **[Get to Know the PeerOS Components](peeros-components)**
* **[Quick PeerOS Install](peeros-quick-install)**
  * [Basic setup using Vagrant with VirtualBox](peeros-vagrant-virtualbox)
  * [Basic setup using Vagrant with other supported hypervisors](peeros-other-supervisors) 
* **[Advanced PeerOS Install](peeros-advanced-install)**
* **[Manage Peers](manage-peers)**

***

### <a name="peeros"> </a> The Subutai PeerOS: An Overview

#### What is it?

PeerOS is a software bundle that serves as the building block of Subutai’s peer-to-peer (P2P) cloud services. As a free and open source software, it is available to anyone who wants to run peers, within a virtual environment in the cloud, that can be shared or rented out to other users. 

#### How it works
The first thing to do is install PeerOS on each of your bare metal Debian servers or resource hosts. Then, you need to install the Management Software and Console on one of them, to serve as the management host. The Management Console, allows you to manage your distributed, containerized cloud environments. Through the Console, you can register more servers and create container clouds, also called environments. Containers within an environment are connected to one another via an overlay P2P network. Our Control Center application provides you with an easy SSH access to the internals of your environment. Moreover, you can peer your Subutai instance with a remote one, enabling you to use its resources or share your resources with it. Finally, if you want to, you can sell or rent your resources, or pay to use someone else’s resources via Subutai Bazaar, our central site or marketplace.

To learn more, see [Subutai PeerOS](https://subutai.io/peer-os.html).

#### Get started with PeerOS
   
<table>
 <tr rowspan="2" align="center"> 
  <td> 🔻 <br>
   <a href="https://github.com/MarilizaC/doc_v2/wiki/Quick-PeerOS-Install"> Quick Install </a>    
  </td>
  <td> 🔻 <br>
   <a href="https://github.com/MarilizaC/doc_v2/wiki/Advanced-PeerOS-Install"> Advanced Install </a>
  </td>
 </tr>
</table>




