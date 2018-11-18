---
title: 'Using Vagrant with Virtualbox'
visible: true
taxonomy:
    category:
        - docs
---

# Basic setup using Vagrant with VirtualBox
The easiest and quickest way to get a Subutai Peer running on any platform is to use Vagrant with VirtualBox. This guide shows you how to set up Vagrant for Subutai and create a peer based on Debian 9.x.

### Prerequisites

Download the latest [Vagrant 2.0.1](https://www.vagrantup.com/downloads.html) and [VirtualBox 5.1.0](https://www.virtualbox.org/wiki/Downloads) or higher from their respective websites.    

!!!!! Don't use package managers to install these software: package manager versions are usually out of date. 

***

With the prerequisite software installed, you can proceed to the steps below:

1. Create the Vagrantfile with the subutai/stretch box (Debian-based)   

`$ vagrant init --minimal subutai/stretch`

2. Install the subutai and vbguest vagrant plugins   

`$ vagrant plugin install vagrant-subutai`   
`$ vagrant plugin install vagrant-vbguest`   

3. Create and start running the Subutai peer   

`$ vagrant up`

During processing, if asked for the bridge interface you want to use, the first option provided by Vagrant is usually the right one. This is the network interface that is actively used to connect to the Internet.

In case you encounter an error during installation, see [Common errors encountered when using Vagrant plugins](../maintain-vagrant-plugins#common-errors).

!!!! Congratulations! You have a peer!

At the end of processing, you should see the following message indicating that the peer has been successfully created:

```
default:
default: SUCCESS: Your peer is up. Welcome to the Horde!
default: ----------------------------------------------
default:
default: Next steps ...
default: Make sure Subutai's E2E Extension/Plugin is installed in your browser
default: Search for 'Subutai' in your browser's extension/plugin store to find 
it and install.
default:
default: Console URL: https://172.16.1.121:8443
default: Default u/p: 'admin' / 'secret'
default:
default: Vagrant ssh and change the default 'subutai'/'ubuntai' user password!
default: If you forget the url, just take a look in .vagrant/generated.yml
``` 

### What's Next?

After your peer has been created, you can log into its Management Console to perform updates and maintenance tasks. To access the Console: 

- From the output above, you can see the IP based URL (your host IP address and port number) of the Console, which you can enter on a browser's address bar:   
`Console URL: https://172.16.1.121:8443`
- Below the URL are the login credentials:   
`Default u/p: 'admin' / 'secret'`
