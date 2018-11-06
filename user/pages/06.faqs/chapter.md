	---
title: 'FAQs'
taxonomy:
    category:
        - docs
child_type: docs
toc:
  headinglevel: 3
---

# Frequently Asked Questions

[TOC]

### 1. General questions

#### What is Subutai Peer OS?

Subutai is a next generation peer-to-peer (P2P) cloud computing and
Internet of Thing platform. Subutai peers collaborate and share
resources to create secure virtual environments tying together the
shared network and machine resources across peers.

Subutai consists of:

-  Agent - used on each Resource host to expose (reveal) its resources
   to Console and Bazaar.
-  Console - Subutai Console application exposes (reveals) Peer
   functionality to register it with Bazaar.
-  LXC - Linux containers used as basic building blocks for Subutai
   environments.
-  P2P - our own peer-to-peer cloud used for intra-environment
   connectivity between containers.
-  Control Center - a convenient desktop application for working with
   Bazaar and Peer.
-  E2E plugin - a browser plugin for easily making PGP-based
   authentication and encryption work with a Peer.
-  Bazaar - a central marketplace where users can buy, sell, or utilize
   peers or other resources.

#### Does Subutai have anything to do with cloud storage such as iCloud or Google Cloud?

**Short answer**: No for iCloud, kind of for Google Cloud.

This is not a well formed question. Google Cloud is not a cloud storage
solution, it is much more than that as a full
Infrastructure-as-a-Service (IaaS) cloud solution. Subutai is also a
IaaS cloud that allows you to install an entire virtual data center
using it with applications and their parts: i.e. a LAMP or RoR stack for
example. The difference is that Google Cloud only lets you use their
servers and infrastructure for hosting your applications. Your apps run
on Google’s data centers and hardware, not your or your preferred peers
in your preferred locations. Subutai gives you this and can even run in
Google’s Cloud if that’s what you want.

iCloud is Apple’s wanna be cloud. It’s very close to a storage solution
that allows you to store Apple application data on it. However, it has
some applications running on it too. It is like a little SaaS on top of
a cloud storage solution specifically for Apple’s Mac OS and iOS
platforms.

#### Is Subutai only for individual home users? Do you have an enterprise edition for businesses?


Subutai leverages the power of peer economics to enable individual and
business users to both buy and sell cloud services. There is no
“enterprise” edition of Subutai: the products serve both individuals and
businesses. It is easy enough for non-technical professionals, and
feature-rich enough for IT professionals and commercial use.

#### Can Subutai be used as part of a larger system such as OpenStack?

Sure. Subutai runs on anything that has resources. OpenStack is a
virtualization and IaaS cloud management solution used mostly for
private clouds on premises. Subutai can run on the virtual machines that
OpenStack manages.

#### How does Subutai protect me from cyber attacks or viruses?


Subutai offers several layers of isolation between your computer and
containers it rents out to tenants using your hardware. The host machine
is protected from the containers of tenants. Those containers can be
infected with malicious software, but they don’t have a chance to jump
out of that sandbox. We do various other things to also make sure root
in a container never maps to a privileged user in the host running them.

We’re working on additional enhancements both in hardware and in
software to improve security. One of them is the use of Trusted Platform
Modules (TPM) and Hardware Security Modules (HSM) if available. The
Subutai Blockchain Router for example has a TPM that it uses to secure
boot the router to make sure no critical software running on it has been
compromised. We’re also doing research into a hardware Dynamic
Information Flow Tracking system that introspects each operation the
router’s CPU takes using debugging interfaces with other real time
processors and the FPGA. We’re also very proud to have implemented a
hardware based variant of the Aho-Corasick pattern matching algorithm to
use fuzzy hashing to locate viruses in streams coming in and going out
of the router.

#### How is Subutai different from Golem or SONM?


There seems to be some similar blockchain projects, however Subutai
stands alone with regard to its function, architectural robustness and
ecosystem readiness.

Subutai stands up an adaptive infrastructure cloud across peer resources
using sophisticated algorithms for edge resource provisioning on
containers to create a virtual cloud environment. These other solutions
are not true cloud systems. Golem for example just deals with
computation, chopping down a task into many smaller tasks, then feeding
it to many systems for parallel computation, and reassembling the
results. Golem is like Amazon Lambda, while Subutai is like EC2. Golem
only goes so far, only working on certain kinds of problems. It is not a
IaaS cloud implementation like Subutai. Likewise neither is SONM.

More importantly, unlike other products that are at the very early
stages of product development, Subutai is a mature, functioning platform
(software products at v6.0; hardware at v2.0), and is already being
deployed by a community of users.

#### Can I use Subutai on its own? Do I need to use the Bazaar?


Yes, you can use the Subutai PeerOS independently. Users are free to
choose to utilize one, some, or all Subutai products. You do not need to
join the Bazaar or use the Router in order to benefit.

#### Is GoodWill a blockchain based currency, or is it handed out by the Bazaar?

GoodWill is the token currency used in the Subutai Bazaar. It is a
lightweight digital asset token used in the exchange and purchase of
peer resources and other services. It is not blockchain based, and
cannot be exchanged for value outside the Subutai platform.

#### What is KHAN?


KHAN™ is an Ethereum Blockchain-based reserve currency token that is the
default and ubiquitous currency across the Subutai Platform. KHAN’s
reserve currency used across ISPs is similar to USD across countries; as
a utility token (vs. security token), KHAN can be reliably used without
restriction worldwide independently of the Subutai platform.

#### Who is behind Subutai?


Subutai is a product of OptDyn, Inc., a five year old company with a
multinational, globally-distributed team. OptDyn leadership includes
Open Source trailblazers CEO Jon "maddog" Hall (early Linux evangelist,
educator, advisor, Linux Pro Magazine columnist, and Board Chair for the
Linux Professional Institute); Founder and CTO Alex Karasulu (original
author of the Apache Directory Server, the foundation of IBM’s Rational
Directory Server and Websphere Application Server; founder of Safehaus,
whose Open Source low-resource mobile OTP algorithms have been adopted
by Google Authenticator; developed software products that power
solutions by Atlassian, Cisco, and Polycom); and Director of Marketing
and Media Sally Khudairi (Apache Software Foundation VP Marketing &
Publicity; former W3C head of communications; launched Creative
Commons).

### 2. Technical questions


#### How do I update a peer?


To make update in Subutai Console, login to your peer’s console, go to
“System” menu and press “Updates”, then press “Check” button. If your
system doesn’t require update, you will see this message - “Your system
is already up-to-date”, and if it need to be updated, you’ll see this
message - “Update is available”.

To update your RH in CLI terminal, open CLI on your machine, connect to
your peer with SSH (please don’t forget that you need to have
established and protected connection and SSH key setup for this). Once
you have connected to peer, execute the following command: \`sudo
subutai update rh\`. After some moment, your system will be updated, if
it’s up-to-date, you will see the following message: “No update is
available”.

To update your RH management, please use the following command: \`sudo
subutai update management\`

To update packages inside your peer (if it’s required), please execute
the following command: \`sudo apt-get dist-upgrade\`

To update P2P daemon in Tray desktop app, login to your tray app using
Subutai Bazaar (formerly called “Hub”) account, then go to “About” menu
and press “Update P2P” if it requires updates.

#### How to export Karaf Logs from the Subutai Console?


To export Karaf logs: go to Subutai Console -> System -> Advanced ->
Logs -> "Export" button.

#### I got error "proxy required but not found" when trying to create a new port to access my environment inside of container port-mapping.


This error about proxy says that there are no proxy peers available,
which can be used as reverse proxy for domain & port mapping, you
created. Proxies are needed when your peer is behind a NAT and you want
external users from the Internet to access services like a web server. A
server accessible from the open Internet can forward traffic to your
peer’s services by tunneling through the P2P protocol. In this case the
peer proxies your services. When no such peers are available you cannot
expose services from your peer to the open Internet.

#### Is the "Dynamic Match" tab inside an environment a feature that allows you to move your containers around as needed for replication/failover/etc?


Sort of. The Dynamic Match tab specifies governance rules for the cloud
owner to control which peers are selected to authorize for swarming and
participating in the environment by contributing resources.

The peers satisfying these governance rules (criteria) are authorized to
join the swarm. Then as load changes the environment can shift resources
based on load and cost.

All while adhering to these criteria. Some things here are not
implemented well. They need work. Right now we have dynamic management
disabled because of this.

The statistics we gather around network tomography need to be improved
to do this orchestration optimally. There’s some Big Data infrastructure
we have for this but there’s a lot of work that still needs to be done.

#### How the various nodes know about each other once they're spun up. Do you have to ssh into each container and configure tomcat to look for memcached and the data containers, etc?


There are ansible scripts that you can run with the blueprint. This one
is half finished and does not have the hooks. But after initially
creating these containers in an environment the build system fires up
the ansible scripts to go to work and connect things in the
infrastructure with one another.

#### Is there any equivalent of a docker-compose file? A template for multiple containers deployed together?


Yes there is, we call that a Blueprint. It can specify the containers to
use for an entire stack. And specify clustering requirements too but
it’s still very simple.

#### The template is something you can make a container out of when building an environment, correct?


So we have templates and they can be hierarchical just like docker
images. In fact we can convert docker images into our templates. So we
can use a template when creating a container. We can then change that
container and publish it again as a different template. So we can
technically make containers using templates and make templates using
containers.

#### Is a template the same thing as a "product" as listed on the Hub? And are those the same things that are available in the "Bazaar"?


“Hub” is now called “Bazaar”. A template can be a product too. Really
the ideas are just coming together. We want people to make GoodWill with
anything that benefits others through the Apps. So yes, a template, a
blueprint, a plugin, or any other artifact that benefits others is a
viable product whether free, based on goodwill, or anything else. We
leave it up to the people, those in the ecosystem and collaborative
consumption economy to decide.

#### Ok, so I have some GoodWill, but I can't figure out how to start a container on any peers.


To start container, you need to create environment on peer (your own
peer or some other rented peer).

#### How to rent a peer?


First you need to add needed peers to your favorite list from "Peers"
page. Then you need to go "Environments" section and click "Create".

#### It's not clear on how to use Subutai Control Center and Subutai P2P.


Subutai Control Center is the app from which you perform SSH into
container.

#### How to SSH into container?


First you need to add your SSH key to the environment, in \`Manage SSH
keys\` menu in Control Center, then in \`environments\` menu of Control
Center select your container, and terminal window of your container
should open same actions (adding SSH-key into environment and SSHing
into container) can be done from Bazaar itself, but running Control
Center is required to SSH into container.

#### If I want to write an application that runs on Subutai, am I going to need more GoodWill?


No GoodWill needed for that, you may write Subutai plugin and publish it
in Bazaar Products, so other users can use it.

#### Does Subutai work on mobile CPU architecture as Raspberry Pi?


Yes. Future releases will have ARM client and even peer support.
