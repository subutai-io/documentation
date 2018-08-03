---
title: 'E2E Plugin'
visible: true
---

E2E Plugin¶

Subutai uses PGP key pairs to identify all entities including users like cloud owners and Peer administrators. The default administrator account on the new Peer needs to be associated with the global identity of the peer owner to share or rent resources to others.
Manually managing PGP keys¶

Users who know how to manage their own keys can use their preferred tools to do so. Various platform specific PGP tools like GPG on Linux can be used on a command line interface or user GUI to create and use PGP keys. That can be a major hassle, especially for those that are not PGP savvy. Worse yet, it can actually be detrimental for those who don’t understand PKI or how to secure their keys. Even PGP pros will be annoyed when having to deal manually with frequent challenge and response authorization operations.

This is why we created browser plugins. Additionally we’re working on FIDO (World’s Largest Ecosystem for Standards-Based, interoperable authentication) and hardware key fob integration to always improve security. The Subutai E2E browser plugins have these benefits while still leaving the manual approach open.

As mentioned, the Subutai E2E Browser Plugin / Extension should be installed in the browser with either an existing key or a newly generated PGP key before logging into the management console. The plugin will generate a new key pair for you if you don’t already have one. You can easily import and export keys into the plugin.
Getting started¶

Before you start using our E2E plugin, please NOTE that for now, we support Chrome, Safari and Edge browsers. To install plugin on Chrome, please go to *this link*.

Then add E2E plugin to your browser. Then, you need to generate a new PGP key for your user account. Please push “generate” button in upper right part of your plugin management menu and insert your email (you’re using on Subutai Bazaar) in popup field.

Then push generate button and voila! Your key is now successfully generated.

The next step you need to perform is - go to your user profile on Subutai Bazaar, press user settings button and push “upload” button.

Then your newly generated key will be automatically uploaded. After that, press the “save” button and this is it. If you have more than one key in your E2E plugin, it will suggest you to choose key from the key list. Also you can assign a password to your key for improved security.