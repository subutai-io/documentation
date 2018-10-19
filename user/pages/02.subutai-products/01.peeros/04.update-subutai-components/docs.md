---
title: 'Update Subutai Components'
visible: true
taxonomy:
    category:
        - docs
---

In order to prevent damages to your system and the whole Subutai ecosystem, please keep your software always up to date. The following instructions will help you update all components of Subutai Platform.

## Regular updates in your Peer/s

*    To update the Subutai Console, login to your peer’s console, go to > the “System” menu and press “Updates”, then press “Check” button. > If your system doesn’t require an update, you will see this > message - “Your system is already up-to-date”, and if it needs to > be updated, you’ll see this message - “Update is available”.
*     To update your Resource Host through the CLI (command-line interface) terminal, open the CLI on your machine, connect to your peer with SSH (please don’t forget that you need to have established and protected your connection and SSH key setup for this). Once you have connected to the peer, execute the following command: ‘sudo subutai update rh’ . After some moments, your system will be updated. When it’s up-to-date, you will see the following message: “No update is available”.
*    To update your Resource Host management, please use the following command: ‘sudo subutai update management’
*    To update packages inside your peer (if it’s required), please execute the following command: ‘sudo apt-get dist-upgrade’

## Companion software updates

In order to keep using the Subutai platform, you need to make sure the companion software is up-to-date. Check its own [documentation](../../companion-software) to learn more about it.