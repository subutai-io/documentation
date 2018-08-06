---
title: Environments
visible: true
---

An Environment is a logically grouped set of containers distributed across one or multiple peers that share the same network (they belong to the same p2p swarm - see more on p2p). An environment can host a number of applications.

### Templates

Environments are based on templates - basic software packages that provide a set of functionalities and can be extended to whatever you may need. For instance, there are templates that allow you to deploy a Debian server image to a Subutai Environment. You can use the templates already available in the PeerOS and Bazaar, or you an even create your own:

Check how to create Templates (from the command-line interface or the Subutai Console).


## How To Create And Use Environments

First thing you need to install an Environment is to sign up on the Subutai Bazaar. Any Environment needs at least one Peer on which to run. You can lease or rent other people’s Peers, or you can add include your own Peers on Subutai Bazaar. Once you have a Peer to set up your Environment, please make sure you have the Control Center on your desktop and the E2E plugin for your browser with a properly configured PGP key. Once you have all of this - account on Bazaar, peer, control center, e2e plugin + pgp key setup and configured, you can start with environment creation.

Go to Subutai Bazaar and in the up left corner, click the “Environment” button, then click “create environment”:

After, that, you will be redirected to the Peer selection page, where you will see Peer(s) to be chosen for your Environment and what resources (RAM, CPU, HDD) they have to offer. You can pick from: your own Peers, favorites and ones shared with you by your friends.

Check your Peer(s) and press “next” button:

Then, you will be directed to the Template selection page. There you will have option to choose system template(s) for your Environment.

Please note that you can add your own template and use it - you can do this in the CDN menu.

You can also choose the size of your container - tiny, small, medium, large or huge. And you can easily rename the container’s default name. After you added the template(s) you want, click “save” button, select the name for your environment, press “save” again and at the last step press “build” button.

Next step you have is “under modification” state, which means that your environment is being created. It make take some time before the environment is built as some templates are big.

If all the steps are done properly, containers are built. You will see “ready” in state field and your environment will be “healthy”:

So, now you have your environment and you are ready now to install software you like there. Then, to make it accessible by a domain name, please go to the “Container Port Mapping” page and press “Add new port” button. There you can specify protocol, ports, domain name, proxy (if it’s behind NAT) and pick container:

When all is ready, you will be able to access your container with template by domain name.

This is how it should look like if you have properly configured port mapping:

And if you click your domain name, you will have your container (Apache in the example) opened in browser under previously specified domain:

Congrats! You are now ready to use your environment!

What now? You can access your environment straight from your desktop! For this, you need to install and set up the following components: Subutai P2P daemon and Subutai Control Center. After installing them, please log into the Control Center using your Bazaar website’s account. Then, to access your Environment, you need to generate SSH keys, or add existing SSH keys to your environments:

So when all is up and running, you can SSH into your container via Control Center, by opening its Environment menu, choosing the environment you like and clicking it. You will see this:

Once your SSH button is active (white and clickable), you can click it and then a terminal will be opened and you will have access to your container!

All plain and simple! Feel free to leave your questions or comments in our slack community.
