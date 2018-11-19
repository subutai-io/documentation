---
title: 'Use the Account Tools'
visible: true
taxonomy:
    category:
        - docs
---

[TOC]

The User menu is located in the right sidebar of [Subutai Bazaar](https://bazaar.subutai.io). To activate it, click your name on the [Top menu](../top-menu). Please refer below to the functionalities the User menu ofers.


### Settings

User settings will allow you to see and sometimes edit the following personal information:

- Name
- Username
- The Email address you used for sign-up
- Your avatar
- Your country
- User guides (hints). Switch off or switch on the menu hints.
- Reset user guides. Here you you can reset all completed user guides (if you do that,you will see all user guides again).
- Change password. You will need your old password to create a new one.
- PGP fingerprint (Pretty Good Privacy) is a special sort of encryption. PGP increases the security of communications between the user’s machine and servers. You can change it if you need at any time. The PGP key can be generated automatically by the Subutai [E2E extension](../../software-components), if you have it installed in your browser.
- You can also delete your account, if you don’t need it anymore. Be careful: this operation is permanent.


### Billing

The Billing page displays your Journal of Transactions, Environment payment reports and Rewards. You may check your transaction history using the calendar. The “View” button will show you detailed information about each operation.

### My peers

This page shows the Peers you use. You can view your own Peers; Peers that you have added to your Favorites list; Shared Peers; Cloud Peers that you own; operation history of your Peers and Peers’ logs.

### Domains

Here you can map domain names to your environments and containers. To add domains to your list, click "Add new". There will be two options for you to choose:

- **Bazaar sub-domain** allows you to create free subdomains of `.envs.subut.ai`. Type your desired subdomain, click the green button to check whether it is available and click save.
- **User managed domain** lets you use domain names or subdomains you already own. Please note you need to have access to a registrar where your domain was created in order to configure it. First, type your domain name or subdomain. You will see that the example below will be changed to reflect the CNAME record you will need to add to your registrar's DNS settings.

Either way, from now on when you run a [Blueprint](../blueprints) or access an [Environment's](../bazaar-tools/environments) `Container Port Mapping` tab, this subdomain will be available to use.

### Products

This page lists your accepted Blueprints. You can edit their name, category, version, price (in GoodWill), description and logo.

### SSH key management

Here you can easily manage your SSH keys - add, view, delete and edit keys. SSH keys are very important to gain terminal access to Environments and Containers on Subutai.

To add your key, click the green Add button and paste your key in the appropriate field. Click add and your key will be successfully added to the Bazaar!

### My Blueprints

This section allows you to add your GitHub projects to the Subutai Bazaar Apps section. You can for instance create your own Blueprint in GitHub, then authorize it on the Subutai Bazaar and upload it. After that, you will be able to build Environments based on your Blueprint. You can also publish your blueprint to make it available to other Bazaar users.

### Application settings

Here you can add the default variables to use in Blueprints. For instance, you can add your Environment’s name and then, when you build an Environment with the Blueprint, this variable will be automatically added. This option is useful for repetitive builds, as you can specify beforehand all the variables before creating new environments.

### CDN

Subutai CDN is a server where you can store your templates and also use find other users' templates to create your own Environments.

You can upload and download your Subutai Templates (as tar.gz files), or any other RAW file. There is also a tab called "REST Token Management" to generate Bazaar tokens via REST.

Please note that you need to have the E2E plugin and PGP key installed and configured in order to use the Subutai CDN. Press the authorize button and wait until your key is added. NOTE: the CDN token expires within one hour. After that, you will need to perform an authorization again.

### Organizations

You can create your own organization and invite its members. Then you can add GitHub repositories, create cloud Peers and contribute resources that will be made available to its members.

### Friends

Friends page allows you to befriend users of Subutai Bazaar. There are 3 tabs:

- My Friends - your list of approved friends.
- Friend Requests - other users who are asking to become your friends.
- My friend Requests - the users you have asked to add to your list of friends.

If you want to add a user as your friend, go to the user’s page, pick the user you want and click “add friend” on the left side menu.

### Invitations & Coupons

- Invitations. It is possible to invite new users by email to join the Bazaar. Once you send an invitation by email, the user will receive a link and be directed to the Bazaar’s registration page. Note that this link expires in one hour. Once the user is registered, both of you receive an reward in GoodWill.
- Coupons. We often partner up with different organizations to offer particular coupon codes. You can use the code as an User Profile Coupon. This will bring you a reward in GoodWill as well.

### Cloud accounts

You can add your accounts from third-party service providers in the cloud accounts section. To do that, choose which cloud provider you use, provide your account key and secret key (rest assured that your key is stored safely and can not be seen by anyone).
