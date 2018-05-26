The easiest and quickest way to get a Subutai Peer running on any
platform is to use Vagrant with VirtualBox.

Don't use package managers to install this softwares: package manager
versions are usually out of date. Download the latest [*Vagrant
2.0.1*](https://www.vagrantup.com/downloads.html) or higher and
[*VirtualBox 5.1.0*](https://www.virtualbox.org/wiki/Downloads) or
higher from their respective websites.

Once Vagrant and VirtualBox are installed, you can init the Vagrantfile
by installing the necessary plugins and upping the instance:

### 1.1 Create a Subutai Peer VM based on Debian 9.x:

> \~\$ vagrant init --minimal subutai/stretch

### 2. Install the subutai and vbguest vagrant plugins:

> \~\$ vagrant plugin install vagrant-subutai
>
> \~\$ vagrant plugin install vagrant-vbguest

### 3. Create and start the Subutai Peer VM:

> \~\$ vagrant up

During this process you will be asked for which bridge interface you
want to use. The first option provided by Vagrant is usually the right
one: the network interface that is actively being used to get on the
Internet.

### Congratulations! You have a Peer!

After a lot of output you’ll see a message similar to the following (but
your console’s IP address will be different) :

> default:
>
> default: SUCCESS: Your peer is up. Welcome to the Horde!
>
> default: -----------------------------------------------
>
> default:
>
> default: Next steps ...
>
> default: Make sure Subutai's E2E Extension/Plugin is installed in your
> browser
>
> default: Search for 'Subutai' in your browser's extension/plugin store
> to find it and install.
>
> default:
>
> default: **Console URL: https://172.16.1.121:8443**
>
> default: Default u/p: 'admin' / 'secret'
>
> default:
>
> default: Vagrant ssh and change the default 'subutai'/'ubuntai' user
> password!
>
> default: If you forget the url, just take a look in
> .vagrant/generated.yml

After your Peer is created, you will be able to log into its management
console. From the output above you can see the IP based URL of your
console:

> default: Console URL:
> [*https://172.16.1.121:8443*](https://172.16.1.121:8443)

**WARNING**: Before you log in to the peer console, follow the
post-installation directions to install the Browser Extension, P2P
client and Control Center. Then you can correctly register your Peer at
the Subutai Bazaar.
