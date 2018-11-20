---
title: 'FAQs'
taxonomy:
    category:
        - docs
child_type: docs
---

# Frequently Asked Questions

Here are answers to frequently asked questions about Subutai, the open source project and the platform.

## **General Questions**
* _[What is Subutai PeerOS?](#What-is-Subutai-PeerOS)_   
* _[Does Subutai have anything to do with cloud storage such as iCloud or Google Cloud?](#Does-Subutai-have-anything-to-do-with-cloud-storage)_   
* _[Is Subutai only for individual home users? Do you have an enterprise edition for businesses?](#Is-Subutai-only-for-individual-home-users)_   
* _[Can Subutai be used as part of a larger system such as OpenStack?](#Can-Subutai-be-used-as-part-of-a-larger-system)_    
* _[How does Subutai protect me from cyberattacks or viruses?](#How-does-Subutai-protect-me)_     
* _[How is Subutai different from Golem or SONM?](#How-is-Subutai-different-from-Golem-or-SONM)_    
* _[Can I use Subutai on its own? Do I need to use Bazaar?](#Can-I-use-Subutai-on-its-own)_     
* _[Is GoodWill a blockchain based currency, or is it handed out by Bazaar?](#Is-GoodWill-a-blockchain-based-currency)_    
* _[What is KHAN?](#What-is-KHAN)_   
* _[Who is behind Subutai?](#Who-is-behind-Subutai)_


##### <a name="What-is-Subutai-PeerOS"></a>_What is Subutai PeerOS?_
Subutai is a next generation peer-to-peer (P2P) cloud computing and Internet of Things platform. Subutai peers collaborate and share resources to create secure virtual environments, tying together the shared network and machine resources across peers. Subutai’s cloud software stack is mature (v7.0), easy-to-deploy, proven, and can be immediately applied across countless application areas, both commercially and privately.

To learn more, see [Subutai PeerOS](https://subutai.io/peer-os.html).

##### <a name="Does-Subutai-have-anything-to-do-with-cloud-storage"></a>_Does Subutai have anything to do with cloud storage such as iCloud or Google Cloud?_
Short answer: No, for iCloud. Kind of, for Google Cloud.

Google Cloud is not a cloud storage solution, rather it is much more than that as a full Infrastructure-as-a-Service (IaaS) cloud solution. Subutai is also an IaaS cloud solution that allows you to install an entire virtual data center using it with applications and their parts: i.e., a LAMP or RoR stack for example. The difference is that Google Cloud only lets you use their servers and infrastructure for hosting your applications. Currently, your apps may run from Google’s data centers and hardware, not your or your preferred peers in your preferred locations. Subutai gives you this, but it can even run in Google’s Cloud, if that’s what you want.

iCloud is Apple’s wannabe cloud. It’s very close to a storage solution where you can store Apple application data. However, it has some applications running on it too. It is like a small SaaS on top of a cloud storage solution specifically for Apple’s macOS and iOS platforms.

##### <a name="Is-Subutai-only-for-individual-home-users"></a>_Is Subutai only for individual home users? Do you have an enterprise edition for businesses?_
Subutai leverages the power of peer economics to enable individual and business users to both buy and sell cloud services. There is no “enterprise” edition of Subutai: the products serve both individuals and businesses. It is easy enough for non-technical professionals, and feature-rich enough for IT professionals and commercial use.

##### <a name="Can-Subutai-be-used-as-part-of-a-larger-system"></a>_Can Subutai be used as part of a larger system such as OpenStack?_
Sure. Subutai runs on anything that has resources. OpenStack is a virtualization and IaaS cloud management solution used mostly for private clouds on premises. Subutai can run on the virtual machines that OpenStack manages.

##### <a name="How-does-Subutai-protect-me"></a>_How does Subutai protect me from cyberattacks or viruses?_
Subutai offers several layers of isolation between your computer and containers it rents out to tenants who use your hardware. Your host machine is protected from the containers of your tenants. Those containers could be infected with malicious software, but they won’t have a chance to jump out of that sandbox. We do various other things to also make sure the root in a container never maps to a privileged user in the host running them.

We’re working on additional enhancements both in hardware and in software to improve security.   
- For one is the use of Trusted Platform Modules (TPM), and Hardware Security Modules (HSM) if available. The Subutai Blockchain Router has a TPM that it uses to secure boot the router to make sure no critical software running on it has been compromised.
- We’re also doing research into a hardware Dynamic Information Flow Tracking system that introspects each operation the router’s CPU takes using debugging interfaces with other real time processors and the FPGA.
- We’re very proud to have implemented a hardware based variant of the Aho-Corasick pattern matching algorithm to use fuzzy hashing to locate viruses in streams coming in and going out of the router.

##### <a name="How-is-Subutai-different-from-Golem-or-SONM"></a>_How is Subutai different from Golem or SONM?_
There seems to be some similar blockchain projects, however, Subutai stands alone with regard to its function, architectural robustness, and ecosystem readiness.

Subutai stands out as an adaptive infrastructure cloud across peer resources using sophisticated algorithms for edge resource provisioning on containers to create a virtual cloud environment. These other solutions are not true cloud systems. Golem only deals with computation, chopping down a task into many smaller tasks to feed them to many systems for parallel computation, and then reassembling the results. Golem is like Amazon Lambda, while Subutai is like EC2. Golem only goes so far, only working on certain kinds of problems. It is not an IaaS cloud implementation like Subutai. Likewise, neither is SONM.

More importantly, unlike other products that are at the very early stages of product development, Subutai is a mature, functioning platform, and is already being deployed by a community of users.

##### <a name="Can-I-use-Subutai-on-its-own"></a>_Can I use Subutai on its own? Do I need to use Bazaar?_
Yes, you can use the Subutai PeerOS independently. Users are free to choose to utilize one, some, or all Subutai products. You do not need to join the Bazaar or use the Blockchain Router in order to benefit from the PeerOS features.

##### <a name="Is-GoodWill-a-blockchain-based-currency"></a>_Is GoodWill a blockchain based currency, or is it handed out by Bazaar?_
[GoodWill](https://subutai.io/goodwill.html) is the token currency used in Subutai Bazaar. It is a lightweight digital asset token used in the exchange and purchase of peer resources and other services. It is not blockchain based, and cannot be exchanged for value outside the Subutai platform. 

##### <a name="What-is-KHAN"></a>_What is KHAN?_
[KHAN™](https://subutai.io/khan.html) is an Ethereum blockchain-based reserve currency token that is the default and ubiquitous currency across the Subutai Platform. KHAN’s reserve currency used across ISPs is similar to USD across countries; as a utility token (vs. security token), KHAN can be reliably used without restriction worldwide, independently of the Subutai platform.

##### <a name="Who-is-behind-Subutai"></a>_Who is behind Subutai?_
Subutai is a product of OptDyn, Inc., a five year old company with a multinational, globally-distributed team. OptDyn leadership includes Open Source trailblazers:   
- Founder and CEO Alex Karasulu    
Original author of the Apache Directory Server, the foundation of IBM’s Rational Directory Server and Websphere Application Server; founder of Safehaus, whose Open Source low-resource mobile OTP algorithms have been adopted by Google Authenticator; developed software products that power solutions by Atlassian, Cisco, and Polycom; and
- Founder and Director of Marketing & Media Sally Khudairi    
Apache Software Foundation VP Marketing & Publicity; former W3C Head of Communications; launched Creative Commons

To better know our leaders and advisors, click [here](https://optdyn.com/about).

## **Technical Questions**

#### PeerOS and Console
* _[How do I update a peer?](#How-do-I-update-a-peer)_    
* _[How to export Karaf Logs from the Subutai Console?](#How-to-export-Karaf-Logs)_    

#### Bazaar
* _[The info icon beside my peer is telling me about a pending update. How do I perform the update?](#The-info-icon-beside-my-peer)_
* _[If I want to write an application that runs on Subutai, am I going to need more GoodWill?](#If-I-want-to-write-an-application)_    
* _[The template is something you can make a container out of when building an environment, correct?](#The-template-is-something)_    
* _[I got error “Proxy required but not found" when trying to create a new port under Container Port Mapping, to access my environment. What do I do?](#I-got-error-Proxy-required-but-not-found)_   
* _[Is a template the same thing as a "product" as listed on the Hub? And, are those the same things that are available in the "Bazaar"?](#Is-a-template-the-same-thing-as-a-product)_   
* _[Is the "Dynamic Match" tab inside an environment a feature that allows you to move your containers around as needed for replication, failover, etc.?](#Is-the-Dynamic-Match-tab)_
* _[Is there any equivalent of a Docker-compose file? a template for multiple containers deployed together?](#Is-there-any-equivalent-of-a-Docker-compose-file)_   
* _[I have some GoodWill, but I can't figure out how to start a container on any peers.](#I-have-some-GoodWill)_
* _[How do I rent a peer?](#How-do-I-rent-a-peer)_    

#### Control Center and P2P
* _[I’m not clear about using the Subutai Control Center and Subutai P2P. Do I have to use them both?](#not-clear-about-using-the-Subutai-Control-Center)_   
* _[How do I SSH into containers from the Control Center?](#How-do-I-SSH-into-containers)_   
* _[Does Subutai work on mobile CPU architecture as Raspberry Pi?](#Does-Subutai-work-on-mobile-CPU-architecture)_

#### PeerOS and Console

##### <a name="How-do-I-update-a-peer"></a>_How do I update a peer?_
You can update peers through the following ways:   
* From the peer’s Management Console
Log in to the Console, and then from the System menu, select Updates. On the Updates page, click Check. If there is no available update, you will see the message, “Your system is already up-to-date”, and if an update is available, you will see the message, “Update is available.” Click Update to start it.

* From a CLI terminal
From a terminal, you can perform updates for resource hosts, management host, and P2P daemon. On your open CLI terminal, connect to the peer via SSH. Then, execute any of the following commands:
  * Resource host update
  * Resource host management update
  * Update packages inside a peer

#### <a name="How-to-export-Karaf-Logs"></a>_How to export Karaf Logs from the Subutai Console?_
From the Subutai Console, go to System > Advanced > Logs. On the Logs page, click **Export**. 

#### Bazaar

##### <a name="The-info-icon-beside-my-peer"></a>_The info icon beside my peer is telling me about a pending update. How do I perform the update?_
There are several ways to update a peer: via CLI, the Management Console, or the Control Center. For instructions, see [How do I update a peer?](#How-do-I-update-a-peer)

Once the update has been completed, the info  icon changes color from red or orange to green. When you click the icon, the message “Need to update soon” is no longer displayed.

💡 You may also notice the same icon when updates are available for the Management Host and P2P. These components can be updated in the same manner.

##### <a name="If-I-want-to-write-an-application"></a>_If I want to write an application that runs on Subutai, am I going to need more GoodWill?_
No GoodWill needed in this case. You may write Subutai plugins and applications as much as you want, and then publish them in Bazaar’s Products section. This will enable others to search and use them. In fact, if you want to develop and contribute Blueprints in particular, you might earn GoodWill by publishing them in Bazaar where others can freely use them. To know more about this exciting program, see [Blueprint Hackathon](https://github.com/subutai-blueprints/hackathon/). 

##### <a name="The-template-is-something"></a>_The template is something you can make a container out of when building an environment, correct?_
Yes, we have templates and they can be hierarchical just like Docker images. In fact we can convert Docker images into our templates. So we can use a template when creating a container. We can then change that container and publish it again as a different template. So we can technically make containers using templates and make templates using containers.

##### <a name="Is-a-template-the-same-thing-as-a-product"></a>_Is a template the same thing as a "product" as listed on the Hub? And, are those the same things that are available in the "Bazaar"?_
“Hub” is the former name of “Bazaar”. A template is one type of product that is offered in Bazaar. Really, the ideas are just coming together and they keep growing. We want people to make GoodWill with anything that benefits others through the apps in Bazaar. So yes, a template, a blueprint, a plugin, or any other artifact that benefits others is a viable product whether free, exchanged with GoodWill, or anything else. We leave it up to the people, those in the ecosystem and within the collaborative consumption economy to decide.

##### <a name="I-got-error-Proxy-required-but-not-found"></a>_I got error “Proxy required but not found" when trying to create a new port under Container Port Mapping, to access my environment. What do I do?_
This error about proxy says there are no proxy peers available, which can be used as reverse proxy for domain & port mapping that you’ve created. Proxies are needed when your peer is behind a NAT and you want external users from the Internet to access services, like a web server. A server accessible from the open Internet can forward traffic to your peer’s services by tunneling through the P2P protocol. In this case the peer proxies your services. When no such peers are available you cannot expose services from your peer to the open Internet.

##### <a name="Is-the-Dynamic-Match-tab"></a>_Is the "Dynamic Match" tab inside an environment a feature that allows you to move your containers around as needed for replication, failover, etc.?_
Sort of. The Dynamic Match tab specifies governance rules for a cloud owner to control which peers are selected to authorize swarming and participating in the environment by contributing resources.

Peers that satisfy these governance rules or criteria are authorized to join the swarm. Then, as load changes, the environment can shift resources based on load and cost.

With the complexity of such criteria and behavior required, this functionality is still under construction and is disabled. The statistics gathered around network tomography need to be improved to do this orchestration optimally. There’s some Big Data infrastructure we have for this, but there’s a lot of work that still needs to be done. 

##### <a name="Is-there-any-equivalent-of-a-Docker-compose-file"></a>_Is there any equivalent of a Docker-compose file? a template for multiple containers deployed together?_
Yes there is, and we call that a Blueprint. It can specify the containers to use for an entire stack. It can specify simple clustering requirements too. 

##### <a name="I-have-some-GoodWill"></a>_I have some GoodWill, but I can't figure out how to start a container on any peers._
To start a container, you need to create an environment on the peer (whether your own peer or a rented one). To build an environment, select Environments from the Tools menu of Bazaar. When building an environment, you can specify the size, which template to use, and other container configurations. 

##### <a name="How-do-I-rent-a-peer"></a>_How do I rent a peer?_
First, you have to add the peer to your Favorites list. To do this in Bazaar, from the Tools menu, go to Peers. Select the “Paid” peer of your choice by clicking Add to Favorites.

Second, you need to create an environment on the peer. Building an environment signals the start of your peer usage, specifically, after you have successfully built the environment. To check your rent charges, select Billing from the Account menu or click your Balance at the top right corner of the page. 

#### Control Center and P2P

##### <a name="not-clear-about-using-the-Subutai-Control-Center"></a>_I’m not clear about using the Subutai Control Center and Subutai P2P. Do I have to use them both?_
With the Control Center, you can easily access and manage peers and environments, as well as perform SSH into containers, all from your desktop. If you want your peers to join the swarm and to enable communications via SSH or remote desktop, install the P2P daemon, which you can do within the Control Center.

##### <a name="How-do-I-SSH-into-containers"></a>_How do I SSH into containers from the Control Center?_
Performing an SSH into containers requires an SSH key to the environment. You can assign SSH keys from the SSH-keys management screen of the Control Center. Once you have assigned the keys, you can go to the Environments screen where you can select the container you want to access. Detailed instructions for deploying SSH keys and accessing containers are available in the [Access and Manage Environments](../../software-components/control-center/access-manage-envs).

##### <a name="Does-Subutai-work-on-mobile-CPU-architecture"></a>_Does Subutai work on mobile CPU architecture as Raspberry Pi?_
Yes. Future releases will have ARM client and even peer support. To get updated with the latest releases and upcoming features, connect with us at any of our social channels:
<p align="left">
 * <a href="https://twitter.com/Subutai_KHAN"> Twitter</a>
 * <a href="https://www.reddit.com/r/SubutaiKHAN/"> Reddit</a>
 * <a href="https://www.linkedin.com/company/subutai-social-cloud/"> LinkedIn</a>
 * <a href="https://www.facebook.com/SubutaiKHAN/"> Facebook</a> 
 * <a href="https://t.me/SubutaiKHAN">Telegram</a>
 * <a href="https://slack.subutai.io">Slack</a>
</p>


<!--
[TOC]
## 1. General questions
#### What is Subutai Peer OS?
Subutai is a next generation peer-to-peer (P2P) cloud computing and Internet of Things platform. Subutai peers collaborate and share resources to create secure virtual environments, tying together the shared network and machine resources across peers. Subutai’s cloud software stack is mature (v7.0), easy-to-deploy, proven, and can be immediately applied across countless application areas, both commercially and privately.
To learn more, see [Subutai PeerOS](https://subutai.io/peer-os.html).
#### Does Subutai have anything to do with cloud storage such as iCloud or Google Cloud?
**Short answer**: No for iCloud, kind of for Google Cloud.
Google Cloud is not a cloud storage solution, rather it is much more than that as a full Infrastructure-as-a-Service (IaaS) cloud solution. Subutai is also an IaaS cloud solution that allows you to install an entire virtual data center using it with applications and their parts: i.e., a LAMP or RoR stack for example. The difference is that Google Cloud only lets you use their servers and infrastructure for hosting your applications. Currently, your apps may run from Google’s data centers and hardware, not your or your preferred peers in your preferred locations. Subutai gives you this, but it can even run in Google’s Cloud, if that’s what you want.
iCloud is Apple’s wannabe cloud. It’s very close to a storage solution where you can store Apple application data. However, it has some applications running on it too. It is like a small SaaS on top of a cloud storage solution specifically for Apple’s macOS and iOS platforms.
#### Is Subutai only for individual home users? Do you have an enterprise edition for businesses?
Subutai leverages the power of peer economics to enable individual and business users to both buy and sell cloud services. There is no “enterprise” edition of Subutai: the products serve both individuals and businesses. It is easy enough for non-technical professionals, and feature-rich enough for IT professionals and commercial use.
#### Can Subutai be used as part of a larger system such as OpenStack?
Sure. Subutai runs on anything that has resources. OpenStack is a virtualization and IaaS cloud management solution used mostly for private clouds on premises. Subutai can run on the virtual machines that OpenStack manages.
#### How does Subutai protect me from cyber attacks or viruses?
Subutai offers several layers of isolation between your computer and containers it rents out to tenants who use your hardware. Your host machine is protected from the containers of your tenants. Those containers could be infected with malicious software, but they won’t have a chance to jump out of that sandbox. We do various other things to also make sure the root in a container never maps to a privileged user in the host running them.
We’re working on additional enhancements both in hardware and in software to improve security. 
* For one is the use of Trusted Platform Modules (TPM), and Hardware Security Modules (HSM) if available. The Subutai Blockchain Router has a TPM that it uses to secure boot the router to make sure no critical software running on it has been compromised.
* We’re also doing research into a hardware Dynamic Information Flow Tracking system that introspects each operation the router’s CPU takes using debugging interfaces with other real time processors and the FPGA.
* We’re very proud to have implemented a hardware based variant of the Aho-Corasick pattern matching algorithm to use fuzzy hashing to locate viruses in streams coming in and going out of the router.
#### How is Subutai different from Golem or SONM?
There seems to be some similar blockchain projects, however, Subutai stands alone with regard to its function, architectural robustness, and ecosystem readiness.
Subutai stands out as an adaptive infrastructure cloud across peer resources using sophisticated algorithms for edge resource provisioning on containers to create a virtual cloud environment. These other solutions are not true cloud systems. Golem only deals with computation, chopping down a task into many smaller tasks to feed them to many systems for parallel computation, and then reassembling the results. Golem is like Amazon Lambda, while Subutai is like EC2. Golem only goes so far, only working on certain kinds of problems. It is not an IaaS cloud implementation like Subutai. Likewise, neither is SONM.
More importantly, unlike other products that are at the very early stages of product development, Subutai is a mature, functioning platform, and is already being deployed by a community of users.
#### Can I use Subutai on its own? Do I need to use the Bazaar?
Yes, you can use the Subutai PeerOS independently. Users are free to choose to utilize one, some, or all Subutai products. You do not need to join the Bazaar or use the Blockchain Router in order to benefit from the PeerOS features.
#### Is GoodWill a blockchain based currency, or is it handed out by the Bazaar?
[GoodWill](https://subutai.io/goodwill.html) is the token currency used in Subutai Bazaar. It is a lightweight digital asset token used in the exchange and purchase of peer resources and other services. It is not blockchain based, and cannot be exchanged for value outside the Subutai platform. 
#### What is KHAN?
[KHAN™](https://subutai.io/khan.html) is an Ethereum blockchain-based reserve currency token that is the default and ubiquitous currency across the Subutai Platform. KHAN’s reserve currency used across ISPs is similar to USD across countries; as a utility token (vs. security token), KHAN can be reliably used without restriction worldwide, independently of the Subutai platform.
#### Who is behind Subutai?
Subutai is a product of OptDyn, Inc., a five year old company with a multinational, globally-distributed team. OptDyn leadership includes Open Source trailblazers:
* Founder and CEO Alex Karasulu    
Original author of the Apache Directory Server, the foundation of IBM’s Rational Directory Server and Websphere Application Server; founder of Safehaus, whose Open Source low-resource mobile OTP algorithms have been adopted by Google Authenticator; developed software products that power solutions by Atlassian, Cisco, and Polycom; and
* Founder and Director of Marketing & Media Sally Khudairi    
Apache Software Foundation VP Marketing & Publicity; former W3C Head of Communications; launched Creative Commons
To better know our leaders and advisors, click [here](https://optdyn.com/about).
## 2. Technical questions
### PeerOS and Console
#### How do I update a peer?
You can update peers through the following ways:
* From the peer’s Management Console   
Log in to the Console, and then from the System menu, select Updates. On the Updates page, click **Check**. If there is no available update, you will see the message, “Your system is already up-to-date”, and if an update is available, you will see the message, “Update is available.” Click **Update** to start it. 
* From a CLI terminal   
From a terminal, you can perform updates for resource hosts, management host, and P2P daemon. On your open CLI terminal, connect to the peer via SSH. Then, execute any of the following commands:
   * Resource host update   
     `subutai update rh`
   * Resource host management update   
     `subutai update management`
   * Update packages inside a peer   
     `apt-get dist-upgrade`
#### How to export Karaf Logs from the Subutai Console?
From the Subutai Console, go to System > Advanced > Logs. On the Logs page, click **Export**. 
### Bazaar
#### If I want to write an application that runs on Subutai, am I going to need more GoodWill?
No GoodWill needed in this case. You may write Subutai plugins and applications as much as you want, and then publish them in Bazaar’s Products section. This will enable others to search and use them. In fact, if you want to develop and contribute Blueprints in particular, you might earn GoodWill by publishing them in Bazaar where others can freely use them. To know more about this exciting program, see [Blueprint Hackathon](https://github.com/subutai-blueprints/hackathon/). 
#### The template is something you can make a container out of when building an environment, correct?
Yes, we have templates and they can be hierarchical just like Docker images. In fact we can convert Docker images into our templates. So we can use a template when creating a container. We can then change that container and publish it again as a different template. So we can technically make containers using templates and make templates using containers.
#### Is a template the same thing as a "product" as listed on the Hub? And, are those the same things that are available in the Bazaar"?
“Hub” is the former name of “Bazaar”. A template is one type of product that is offered in Bazaar. Really, the ideas are just coming together and they keep growing. We want people to make GoodWill with anything that benefits others through the apps in Bazaar. So yes, a template, a blueprint, a plugin, or any other artifact that benefits others is a viable product whether free, exchanged with GoodWill, or anything else. We leave it up to the people, those in the ecosystem and within the collaborative consumption economy to decide.
#### I got error “Proxy required but not found" when trying to create a new port under Container Port Mapping, to access my environment. What do I do?
This error about proxy says there are no proxy peers available, which can be used as reverse proxy for domain & port mapping that you’ve created. Proxies are needed when your peer is behind a NAT and you want external users from the Internet to access services, like a web server. A server accessible from the open Internet can forward traffic to your peer’s services by tunneling through the P2P protocol. In this case the peer proxies your services. When no such peers are available you cannot expose services from your peer to the open Internet.
#### Is the "Dynamic Match" tab inside an environment a feature that allows you to move your containers around as needed for replication, failover, etc.?
Sort of. The Dynamic Match tab specifies governance rules for a cloud owner to control which peers are selected to authorize swarming and participating in the environment by contributing resources.
Peers that satisfy these governance rules or criteria are authorized to join the swarm. Then, as load changes, the environment can shift resources based on load and cost.
With the complexity of such criteria and behavior required, this functionality is still under construction and is disabled. The statistics gathered around network tomography need to be improved to do this orchestration optimally. There’s some Bivg Data infrastructure we have for this, but there’s a lot of work that still needs to be done. 
#### Is there any equivalent of a Docker-compose file? a template for multiple containers deployed together?
Yes there is, and we call that a Blueprint. It can specify the containers to use for an entire stack. It can specify simple clustering requirements too. 
#### I have some GoodWill, but I can't figure out how to start a container on any peers.
To start a container, you need to create an environment on the peer (whether your own peer or a rented one). To build an environment, select Environments from the Tools menu of Bazaar. When building an environment, you can specify the size, which template to use, and other container configurations. 
#### How do I rent a peer?
First, you have to add the peer to your Favorites list. To do this in Bazaar, from the Tools menu, go to Peers. Select the “Paid” peer of your choice by clicking Add to Favorites.
Second, you need to create an environment on the peer. Building an environment signals the start of your peer usage, specifically, after you have successfully built the environment. To check your rent charges, select Billing from the Account menu or click your Balance at the top right corner of the page. 
### Control Center and P2P
#### I’m not clear about using the Subutai Control Center and Subutai P2P. Do I have to use them both?
With the Control Center, you can easily access and manage peers and environments, as well as perform SSH into containers, all from your desktop. If you want your peers to join the swarm and to enable communications via SSH or remote desktop, install the P2P daemon, which you can do within the Control Center.
#### How do I SSH into containers from the Control Center?
Performing an SSH into containers requires an SSH key to the environment. You can assign SSH keys from the SSH-keys management screen of the Control Center. Once you have assigned the keys, you can go to the Environments screen where you can select the container you want to access. Detailed instructions for deploying SSH keys and accessing containers are available in the [Access and Manage Environments]().
#### Does Subutai work on mobile CPU architecture as Raspberry Pi?
Yes. Future releases will have ARM client and even peer support. To get updated with the latest releases and upcoming features, connect with us at any of our social channels:
<p align="left">
 * <a href="https://twitter.com/Subutai_KHAN"> Twitter</a>
 * <a href="https://www.reddit.com/r/SubutaiKHAN/"> Reddit</a>
 * <a href="https://www.linkedin.com/company/subutai-social-cloud/"> LinkedIn</a>
 * <a href="https://www.facebook.com/SubutaiKHAN/"> Facebook</a> 
 * <a href="https://t.me/SubutaiKHAN">Telegram</a>
 * <a href="https://slack.subutai.io">Slack</a>
</p>
--!>
