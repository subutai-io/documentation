---
title: 'User Menu'
visible: true
taxonomy:
    category:
        - docs
---

[TOC]


### Settings

When the user clicks on their name in the Top Menu, a pop-up menu shows up. In this menu in the right top corner there is a button that looks like a gear.

After clicking this button, the user can see their account settings:

- User name
- E-mail, used while signing up.
- Country of location.
- User guides (hints). Here the user can switch off or switch on the menu hints. Disable if they annoy you.
- Reset user guides. Here you you can reset all completed user guides (if you do that,you will see all user guides again).
- Change password. You need to know your old password to create a new one.
- PGP fingerprint (Pretty Good Privacy) is a special sort of encryption. PGP increases the security of communications between the user’s machine and servers. You can change it if you need at any time. PGP key is generated automatically. To start using it, please install the Subutai [E2E extension](../../software-components).
- You can also delete your account, if you don’t need it anymore. Be careful: this operation is permanent.


### Billing

The Billing page displays your payments, transactions and rewards. You may check your transaction history using the calendar. Pressing “View” button will show you detailed informations about each operation.

### My peers

This page shows the Peers you use. You can view your own Peers, Peers that you have added to your Favorites list, shared Peers, cloud Peers that you own, operation history of your Peers and Peers’ logs.

### Domains

You can point domain names to your environments and containers. For now the only available option are subdomains of ‘envs.subut.ai’, but in the future that will be expanded. You may add your own subdomain by clicking “Add new” and checking the availability of your desired subdomain. After the environment is created, you need to set up a container port mapping. See more detailed information on “How to create and use environment” page.

### Products

On this section you can add your own products like templates, applications, operating systems, plugins etc.

To start uploading your product, click on “Add product”. In the popup menu you need to input: name of your product, category, type of product, dependencies (some products can depend on other products), price and version, description. Here you can also upload images of your product’s logo.


### SSH key management

Here the user can easily manage their SSH keys - add, view, delete and edit keys. SSH keys are very important to access environments and containers on Subutai.

To add an existing key, press click the green Add button and copy/paste the key you have in the pop-up field. Then press add and your key will be successfully added to the Bazaar!

### My Blueprints

This section allows you to add your GitHub projects to the Subutai Bazaar Apps section. You can for instance create your own Blueprint in GitHub, then authorize it on the Subutai Bazaar and upload it. After that, you will be able to build Environments based on your Blueprint. You can also publish your blueprint in the Apps section to make it available to other users.

### Application settings

You can add user variables for your Blueprint in this menu. For instance, you can add your Environment’s name and then, when someone builds an Environment with the Blueprint, this variable will be automatically added. This option is useful, because you don’t need to specify all the variables before creating and environment (e.g. pre-configure its name).

### CDN

Subutai CDN is a server where you can store your templates and also use other templates to create own environment and host sites or other sorts of applications.

You can download or upload templates there. Please note that you need to have the E2E plugin and PGP key installed and setup to use the Subutai CDN.

Press the authorize button and wait until your key is added. NOTE: the CDN token expires within one hour. After that, you will need to perform an authorization again.

### Organizations

You can create your own organization, invite its members, and share resources with them. Here you also can synchronize your organization with a GitHub repository, create cloud Peers and contribute your organization’s resources.

### Friends

Friends page allows you to befriend users of Subutai Bazaar. There you can see 3 menus:

- My Friends
- Friend Requests
- My friend Requests

If you want to add a user as your friend, go to the user’s page, pick the user you want and click “add friend” on the left side menu.

### Invitations & Coupons

1. Invitations. It is possible to invite new users by email to join the Bazaar. Once you send an invitation by email, the user will receive a link and be directed to the Bazaar’s registration page. Note that this link expires within 1 hour. When the user is registered, both of you receive an award in GoodWill.
1. Coupons. We often partner up with different organizations to offer particular coupon codes. You can take the code, go to User Profile > Coupon and enter the coupon code in this field. For this we will award you some GoodWill.

### Cloud accounts

You can add your accounts from service providers in cloud accounts section. You need to perform the following steps: specify which cloud provider you use, provide your account key and secret key (no one will have access to your secret key that will be used in Subutai Bazaar).