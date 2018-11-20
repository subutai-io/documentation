---
title: 'Manage Peers'
visible: true
taxonomy:
    category:
        - docs
---

Once you have installed PeerOS and created peers, you can access them through a CLI terminal, the Management Console, or Control Center. With secure access to your peers, you can perform the following tasks:

* [Access and manage peers through the Management Console](#Access-and-manage-peers)
* [Manage peers using the Subutai Control Center](#Manage-peers-using-Control-Center)
* [Register peers with Bazaar](#Register-peers-with-Bazaar)
* [Update resource hosts and other components](#Update-resource-hosts)

#### <a name="Access-and-manage-peers"></a> Access and manage peers through the Management Console 
During peer creation, the modules of the Management software and its Console are installed and set up. At the end of peer creation, the default Console credentials are displayed: Console IP address or URL, login ID, and password. Use the IP address and port number to access from a browser. After your initial login, you are prompted to assign a password of your choice. For detailed instructions, see [How to access the Management Console](../../../software-components/management-console/console-access).

Here are some peer admin tasks that you can perform on the Management Console:
* Register peers with Bazaar
* Verify the current state or health of your peers
* Create and monitor environments and containers on your peers
* Modify resource host parameters

For instructions on how to perform these tasks, see [Management Console](../software-components/management-console).

#### <a name="Manage-peers-using-Control-Center"></a> Manage peers using the Subutai Control Center 
Compared with the Subutai Console, the Control Center application provides you with tools that you can install and access from your desktop. You can create and manage peers, as well as maintain environments and their containers. Get more information about the Control Center [here](../../../software-components/control-center). 

#### <a name="Register-peers-with-Bazaar"></a> Register peers with Bazaar
Peer registration can be done with the REST API request:

`POST /rest/v1/bazaar/register`

The table below lists the required parameters to complete your registration. To learn more about this REST API, see [Register Peer with Bazaar](https://github.com/subutai-io/peer-os/wiki/Register-Peer--with--Bazaar).

Users who need the convenience of a user interface can use the Subutai Console or the Control Center. Regardless of your choice, you need to provide the following information:

| Registration data (via form) | Parameter (via REST API) | Description |
|-------|-------|-------|
| Email | `email` | Email address for the Bazaar account |
| Password | `password` | Bazaar account password |
| Peer name | `peerName` | Unique name given to the peer |
| Peer scope | `peerScope` | Scope of peer use or exposure: `private`, `public`, or `shared` |

#### <a name="Update-resource-hosts"></a> Update resource hosts and other components 
Other maintenance tasks within PeerOS include performing updates to resource hosts, management software, and components. You can use these commands on a CLI terminal with SSH access to the peer:

* Update resource host   
  `subutai update rh`
* Update management host   
  `subutai update management`
* Update packages within your peer   
  `apt-get dist-upgrade`

If you have the Control Center installed, you can perform updates from the Updates tab under Menu > Settings. Check for available updates and then perform them one at a time. For detailed instructions, see [Control Center Updates](../../../software-components/control-center/install-update-components).
