---
title: 'Using Blueprints'
visible: true
taxonomy:
    category:
        - docs
---

### Using Subutai Blueprints

Blueprints generally specify how P2P cloud applications are installed
into [Subutai
Environments](https://github.com/subutai-blueprints/hackathon/wiki/What-is-a-Subutai-Environment%3F). Blueprints can be published by authors on the [Subutai Bazaar](https://bazaar.subutai.io). The Bazaar is a marketplace for Subutai Products and Peers.

There are three ways in which users can trigger the installation of an
application:

1. From the Bazaar when searching for application blueprints
2. From the ``GitHub Projects`` associated with your profile
3. From an environment's ``Applications`` tab: the ``Add Application``
   button

    **NOTE:** If you want to install into an existing environment you
    **MUST** use the third option by navigating to an existing
    environment and adding the application. See `Environment:
    Applications
    Tab <https://github.com/subutai-blueprints/hackathon/wiki/Using-Subutai-Blueprints#environment-applications-tab>`__.

The different ways to install applications using blueprints are
explained in detail within the following sections.

### Bazaar: Application Blueprints

Authors can publish their application blueprints in the Subutai Bazaar. Users can then directly use
these blueprints to create new environments with the blueprint's
application, or add the application to an existing environments. He's a
screenshot of the bazaar:


.. figure:: images/hub_bazaar.png
   :alt: Subutai Bazaar

   Subutai Bazaar

Blueprint authors can "``Publish``" their application blueprints on the
Bazaar to be used for free or for some `Subutai™
GoodWill <https://github.com/subutai-blueprints/hackathon/wiki/What-is-%22GoodWill%22%3F>`__.
All the blueprints are open source so yes this is for sincerely
rewarding good deeds. If you wanted to, you could still fork their
public repository and use the blueprint privately, but why not
contribute back? See the guide on `Writing Subutai
Blueprints <https://github.com/subutai-blueprints/hackathon/wiki/Writing-Subutai-Blueprints>`__
to author and publish your own blueprints. Here's a view of the
MatterMost blueprint view at the Bazaar once it is selected:

.. figure:: images/hub_bazaar_mattermost.png
   :alt: MatterMost View

   MatterMost View

Press the ``Build`` button to start up the wizard to build either a new
environment or install into an existing one.

### The Blueprint Wizard

When you select a blueprint to install an application, a wizard will
guide you through the application installation process. Blueprints can
interact with users through the wizard to get additional information
almost like a traditional installer. Blueprint authors can use custom
variables to parameterize the installation of the p2p cloud application.
Based on values provided from the user, the installation occurs
differently or configures itself differently. Here's a screenshot of the
wizard while installing MatterMost:

.. figure:: images/hub_blueprint_wizard.png
   :alt: Blueprint Wizard: MatterMost Installation

   Blueprint Wizard: MatterMost Installation

### Initial Peers

When installing a blueprint application users are presented with an
initial list of peers from all the available peers on the system. These
are peers selected by constraints specified by the application author
who knows a thing or two about the needs of the application. Don't worry
you can adapt the environment as you please later on or just select your
own peers which are also displayed.

One of the questions users frequently ask about is the max price
constraint. Not all peers out there are free. Peer owners may choose to
sell their resources for the market price of "GoodWill" or use their own
prices for the various preset `container
sizes <https://github.com/subutai-blueprints/hackathon/wiki/What-is-%22GoodWill%22%3F#container-sizes>`__.
You can setup a peer too and sell resources to make "GoodWill" and price
containers as you like.

So when selecting the peers the first time blueprints will ask for the
maximum price users would be willing to pay per hour to run the
application on paid resources. This is used to select peers that can be
used to host the infrastructure of the application. There might be many
containers used by the application so this adds to the max price.
Usually putting higher values are best, you anyway still have the option
of selecting peers based on their prices at the end of the wizard. Your
own peers, free peers, and your favorite peers will always be made
available.

### Application View

Once you kick off the application build in your cloud environment,
you'll be offered the link to the environment in your list of
environments. You'll see the new environment building or the new
application building in an existing environment. Environments have an
``Applications`` to see the current state of an installing application.

`TODO add screenshot of an application installing here <>`__

Once installed you can reinstall the application. The settings you used
to install the application can be modified to reinstall the application
to alter the deployment.

### Application Settings

When you go through the wizard to install an application via blueprint,
the settings you provide are stored in an area of your user profile
called ``Application Settings``. The settings you used are remembered so
the next time you install the application there's less work.

    Right now one click installation is almost there but not quite.
    We're working to make sure it becomes really easy for everyone to
    use one click installation.

You can navigate to your application settings and manage them through
your profile's drop down menu. The ``Application Settings`` menu item
will take you there.

`TODO screenshot to show application settings <>`__

### Accessing Containers


Normal users will rarely access the infrastructure installed, however
power users, administrators and others will want direct access to those
environment containers. Owners can deploy SSH public keys into all
containers to enable SSH access via Subutai's P2P protocol.

Users can maintain their SSH public keys on the Bazaar in their user
profile. This is useful because these keys can be automatically deployed
to the environments they create to allow access to containers.

`TODO screenshot of the SSH key management area in a user's
profile <>`__

Blueprint authors may specify SSH key name references. This is the name
of a default key in the users profile. If an SSH key by that name is
present, the application requests that it be deployed to all the
containers to allow SSH access. For example, a blueprint my reference
the ``sysadmin`` SSH key name. If users have such a key, then the key is
deployed. Obviously the key is different for every user, but the
reference name is the same.

This feature makes it really nice to include Subutai.json files in Open
Source projects in git repositories. Anyone can launch a cloud
application and use their own keys to securely access the containers in
the application's stack even though the key reference is the same.

### GitHub: Private Blueprints

We're getting close into the realm of `Writing Subutai
Blueprints <https://github.com/subutai-blueprints/hackathon/wiki/Writing-Subutai-Blueprints>`__,
however you don't have to write your own. You can use blueprints others
have made yet have not published on the Subutai Bazaar.


### Fork GitHub Projects

Blueprints are integrated with git. Users can launch blueprints in git
repositories that contain them and the software they're associated with.
This makes for a very nice workflow for developers, and makes it easy
for new comers to use the application.

Users can fork GitHub projects for example and use the GitHub Projects
profile area to launch those blueprints. Any project with a Subutai.json
in the repository root will be loaded as a private blueprint. If you
like you can publish those blueprints to the Bazaar as well.

Once the projects are loaded you can build new environments with the
application or install the application into existing environments. The
blueprint does **NOT** need to be published at the Subutai Bazaar.

.. figure:: images/github_loaded.png
   :alt: GitHub Projects View

   GitHub Projects View

### Environment: Applications Tab

You can launch both publish bazaar blueprints and private GitHub
blueprints through an environment's ``Applications`` tab. There's a
button there, ``Add Applications`` which opens a dialog that offers
users two categories of application blueprints to select from: published
application blueprints, and private application blueprints.

.. figure:: images/hub_env_apps.png
   :alt: Environment Applications Tab

   Environment Applications Tab
