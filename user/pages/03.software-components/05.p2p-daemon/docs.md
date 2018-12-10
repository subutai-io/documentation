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

The [Subutai Control Center](../control-center) manages P2P connections automatically with each environment, so you don't need to use Subutai P2P Daemon directly. Please refer to the above link if you are using a desktop environment.

## Headless connection

Alternatively, if you want to establish a connection with your environment from a headless machine, you can do the following:

1. Download and install the [Subutai P2P Package](https://subutai.io/getting-started.html#P2P).

2. Make sure that P2P daemon is running by executing the `p2p debug` command in a terminal.

3. Log in to Bazaar and go to: https://bazaar.subutai.io/rest/v1/client/environments.

4. Run your P2P connection by replacing data in <> from the page above: 
   ```
   p2p start -hash <environment_hash> -key <environment_key>
   ```

   It may take a few seconds for the connection to be established and you can always check how it goes by using the `p2p status` command. 

From now on, if you want to SSH into one of your containers you need to do the following:

1. On this page, https://bazaar.subutai.io/rest/v1/client/environments, locate the "environment_containers" section and find the container.

2. Use the following command to connect to it: `ssh root@<rh_ip> -p <port_number>`

   💡 Note that `<port_number>` cannot be found in the scheme above: you need to calculate it yourself. The formula is simple: `10000+<last_octet>`, which is the last octet of `<container_ip>`. For example, if your container IP is `172.16.143.103` - your port will be `10103` = `10000+103`. 

If the P2P connection has been successfully established, and you have calculated the right port number, you will see a standard SSH welcome message. If you were not able to log in due to authentication problems, you need to add your SSH key to the respective container in [Subutai Bazaar](https://bazaar.subutai.io): Environments -> your environment -> SSH Keys -> Add SSH Key.

Finally, if you want to stop the P2P connection, execute the following command:
```
p2p stop -hash <environment_hash>
```

## Troubleshooting

Establishing a network connection can be hard sometimes because of many different factors that could affect the whole process. This is especially true when we talk about peer-to-peer connections. Subutai P2P is designed in such a way that it will try to recover automatically from any problems. But if you still run into any issues, please report the problem by visiting the [P2P Daemon issue tracker on GitHub](https://github.com/subutai-io/p2p/issues/new).

The usual way to solve common problems is to restart the P2P service both on your peer and your client machine. If that doesn't help, you may try the following:
* Check that your Internet connection is working properly
* Verify that Bazaar (https://bazaar.subutai.io) is reachable through your browser    
  If you can't open the Bazaar website, but your Internet works fine, we can check the problem from our end. You may [contact us on Slack](https://slack.subutai.io/) and our team will be happy to help.

### Common problems


**P2P stopped to work after OS upgrade**

On Linux, if kernel was upgraded to a newer version reboot is required. On Windows updated might be required too after some updates, but not always.

**On Windows, I see that container is READY in control-center, but when I click SSH I'm getting Connection timeout message**

This may happen if you have OpenVPN software installed (or other software that works with TUNTAP interfaces on your machine). Currently there is no proper workaround for this, except disabling OpenVPN


## Advanced documentation

- [Collecting useful information](https://github.com/subutai-io/p2p/wiki/P2P-collecting-useful-information)
- [Collecting debug information](https://github.com/subutai-io/p2p/wiki/Collecting-debug-information)
- [Cookbook](https://github.com/subutai-io/p2p/wiki/Cookbook)
- [Instance Creation Process](https://github.com/subutai-io/p2p/wiki/Instance-Creation-Process)

