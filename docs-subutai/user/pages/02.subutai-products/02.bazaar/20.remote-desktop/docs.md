---
title: 'Remote Desktop'
visible: true
taxonomy:
    category:
        - docs
---

This installation guide includes general information about Subutai Remote Desktop and installation scenarios.

### Purpose of Subutai Remote Desktop

Subutai users may have desktop applications running on Subutai containers. For these users, Subutai provides desktop templates and an easy way to access them, once deployed in Environments.

### What is Subutai Remote Desktop

Subutai Remote Desktop enables users to easily get access to desktop applications running on Subutai containers.

### Installation plan

The following is a guide to install the Subutai Remote Desktop. Before starting the installation, please make sure you have a Subutai Bazaar account. In order to run the Remote Desktop, you will also need a Peer running the latest version of Subutai PeerOS. You can do that either *installing* and registering your own Peer, or renting/leasing someone else’s Peer from the *Bazaar*.
Preparing to install components¶

Required Subutai components:

 *   Subutai Peer (*last > version*)
 *   Subutai E2E Plugin (*last > version*)
 *   Subutai Control Center (*last > version*)

Other components required:

  *  X2Go Client (How to install based on your OS:)
   *     Windows and OS X download 
   *     Linux users please follow above x2go wiki link

After installation you don’t need to open or use it, it will be used by Subutai Control Center automatically.

### Installation

 *    Open Subutai Bazaar and create an Environment based in any template with suffix ****-desktop, please use LARGE or HUGE size for this container
 *   After successful Environment creation, add your SSH key in one of these ways:
 *   Subutai Control Center → SSH-keys management → select your key(s) and environment then click Deploy Key(s) button.
 *   Subutai Bazaar → Goto environment details page → SSH Keys tab → click Add SSH
 *   Key button and select your computer public ssh key
 *   After successfully adding your SSH key, go to Subutai Control Center → Environments → select your environment, now you should see environment containers list with SSH and DESKTOP buttons. If > buttons are disabled, please wait until success network connection > and buttons will be automatically enabled.

When buttons are enabled, Click DESKTOP button and wait until X2Go client automatically opens. For Linux users, it may ask for signing to use the SSH key.

The same action can be performed via Subutai Bazaar: Go to Subutai Bazaar environment details page → Containers tab → from list of containers you will see Remote Desktop button on the right side. For this operation you will need Subutai E2E plugin on your browser.

That’s all!

Now you have your own desktop computer in the Cloud :)
