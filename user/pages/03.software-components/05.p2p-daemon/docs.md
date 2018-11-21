---
title: 'P2P Daemon'
visible: true
taxonomy:
    category:
        - docs
---

In order to connect containers on different hosts we have created the Subutai P2P Daemon. P2P establishes connections between different machines and creates virtual network interfaces on each of them, allowing any kind of application to pass traffic through such interfaces.

Subutai P2P is a full-mesh virtual private network application. It supports AES encryption of all traffic between peers.

## Why do I need P2P?

As Subutai is a distributed, P2P cloud environment, every connection needs to go through the P2P mesh. For Subutai users to contact their environments and resources within them - for example, to SSH into a container or initiate a remote desktop session - a P2P connection is required. 

## How to use the P2P Daemon

The [Subutai Control Center](../control-center) manages P2P connections automatically with each environment, so the user doesn't need to use Subutai P2P Daemon directly. Please refere to its documentation if you are using a desktop environment.

## Headless connection

Alternatively, if you want to establish a connection with your environment from a headless machine you can do the following:

1. Download and Install the [Subutai P2P Package](https://subutai.io/getting-started.html#P2P) from the website
2. Make sure that P2P daemon is running by executing `p2p debug` command in a terminal
3. Log in to Bazaar and visit https://bazaar.subutai.io/rest/v1/client/environments
4. Run your P2P connection by replacing data in <> from the page above: 


```
p2p start -hash <environment_hash> -key <environment_key>
```

It may take up to 30 seconds for the connection to be established, and you can always check how it goes by using the `p2p status` command. 

From now on, if you want to SSH into one of your containers you need to do the following:

1. On this page https://bazaar.subutai.io/rest/v1/client/environments locate <environment_containers> section and find a container of your interest. 
2. Use the following command to connect to it: `ssh root@<rh_ip> -p<port_number>`

! Note that `<port_number>` couldn't be found in the scheme above and you need to calculate it yourself. The formula is simple: `10000+<last_octet>`, which is the last octet of `<container_ip>`. For example, if your container IP is `172.16.143.103` - your port will be `10103` = `10000+103`. 

If the P2P connection was successfully established, and you have calculated the right port number, you will see a standard SSH welcome message. If you were not able to log in due to authentication problems, you need to add your SSH key to the respective container in [Subutai Bazaar](https://bazaar.subutai.io): Environments -> YOUR ENV -> SSH Keys -> Add SSH Key.

Finally, when you want to stop that P2P connection, just execute the following command:

```
p2p stop -hash <environment_hash>
```

## Troubleshooting


Establishing a network connection can be hard sometimes because of many different factors that can affect the whole process. Especially when we talk about peer to peer connections. Subutai P2P was designed in way taht it will try to recover automatically from any problems, but if that does not happen please report the problem by visiting the [P2P Daemon issue tracker on GitHub}(https://github.com/subutai-io/p2p/issues/new) 

The usual way to solve many common problems is to restart the p2p service both on your peer and your client machine. If that doesn't help please check that your Internet connection is working properly, and Bazaar (https://bazaar.subutai.io) is reachable in your browser. 

If you can't open the Bazaar website, but the rest of Internet works fine that means that the problem is on our side. In that case, please, [contact us on Slack](https://slack.subutai.io/) and our team will be happy to help.