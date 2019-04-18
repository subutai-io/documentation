---
title: 'Using the E2E Plugin'
visible: true
taxonomy:
    category:
        - docs
---

### What is the E2E Browser Plugin?

Subutai uses PGP key pairs to identify all entities, including users like
cloud owners and Peer administrators. The default administrator account
on the new Peer needs to be associated with the global identity of the
peer owner to share or rent resources to others. The E2E plugin was created to ease the task of managing your PGP key pairs. It is mandatory to access the [Management Console](../../working-with-subutai/using-peerOS/management-console) if you plan to have your own [Peer](../../glossary#Peer), and it is also needed to perform some sensitive operations in the [Subutai Bazaar](https://bazaar.subutai.io). 

#### Manually managing PGP keys

Advanced users who know how to manage their own keys can use their preferred
tools to do so. That is only recommended to those who are PGP savvy, understand PKI and know how to secure their keys. Even people expert in PGP will be
annoyed having to deal manually with frequent challenge and
response authorization operations.

This is why we created the browser plugins. The Subutai E2E browser plugins are an alternative to take care of users' PGP keys from end to end. It is installed in your browser and allows you to either upload an existing key, or generate a new pair if you don't have one, directly from the browser window.

### How to install the E2E Plugin

To install the E2E browser plugin, simply go to your browser's store, look for the Subutai E2E plugin and install it. You can also use the links below:

   * [Firefox](https://addons.mozilla.org/en-US/firefox/addon/subutai-e2e-plugin/)
   * [Chrome](https://chrome.google.com/webstore/detail/subutai-e2e-plugin/ffddnlbamkjlbngpekmdpnoccckapcnh)
   * For other supported browsers, go to [https://github.com/subutai-io/browser-plugins/releases](https://github.com/subutai-io/browser-plugins/releases). From a particular browser's page, you may search for instructions on installing plugins or extensions.

### <a name="create-wallet"> </a> Create your Wallet/PGP keys

1. Go to the E2E plugin options page by clicking its icon in your browser
1. Click the "+ Create" button on the top right corner
1. Insert your email address and desired password, then click "Create"
1. Your [GoodWill](../../working-with-subutai/goodwill) wallet and keys are now created. _Do not forget to [back them up](#backup)!_


### <a name="backup"> </a> IMPORTANT: Back up your keys/wallet

!! Note: this is mandatory! If you don't have a backup and something happens to your computer, you will not be able to recover the contents of your wallet!

1. Click the "Export" button on your key
1. Choose a file name (the default is ok) and insert a password
1. Save the file somewhere safe, and make sure you have at least one copy of this file in places other than this computer

### <a name="associate-wallet"> </a> Associate your wallet with your account in Subutai Bazaar


1. Log in to the [Subutai Bazaar](https://bazaar.subutai.io)
1. On the top right corner of Bazaar, click your username, then open the "Settings" menu item
1. To the right of the "PGP key fingerprint", click the "Change button"
1. The E2E plugin will ask for your password, and insert the proper values automatically
1. Click "Save" and you're done

