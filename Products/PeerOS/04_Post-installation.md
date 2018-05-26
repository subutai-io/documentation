Once you have PeerOS running you should install the client software and
other tools that will allow you to use your Peers and Environments more
effectively. You're going to want to install the browser extension to
manage pgp keys; the p2p client; and the Control Center application.
Then you will be able to register your Peer in the Subutai Bazaar and
start offering your resources in distributed clouds.

Install Browser Extension - E2E
-------------------------------

Before logging into the Peer Console, make sure you install the Subutai
E2E Browser Extension.

We have added security with end to end encryption. Users will have
excessive number keys in Subutai infrastructure which would bring some
certain pain to manage them. Subutai security scheme is designed in a
way that if an adversary steals one key-ring of certain host he is
capable to act only in this key-ring's role is spread. This is an
additional security layer handled by Subutai management, but can
overwhelm users who not used to deal with encryption keys. Subutai E2E
plugin removes all the tedious and dangerous steps required to manage
keys of Peers, Resource Hosts and containers. This decreases the chance
for human error, increase security end to end, and will have users up
and running quickly.

Install the E2E Extension directly from your browser’s store. Currently,
Chrome is supported. The Firefox version is being adapted to recent
changes in the browser.

After installing the Extension, it will prompt you to create a PGP key
and take care of its management whenever Subutai needs it.

Install P2P Daemon and Subutai Control Center
---------------------------------------------

If you want to manage your Subutai Peers from your Desktop PC, you will
still need to install two additional softwares: the P2P Daemon and
Subutai Control Center. The P2P daemon allows systems to join the swarm
to access private cloud environments. The Control Center allows you to
conveniently access environments from your desktop, manage your peers
and check your Goodwill balance.

### Linux Desktop

We only support Debian based systems for now. Instructions are below:

#### Install the P2P Daemon

Download the [*deb
package*](https://cdn.subutai.io:8338/kurjun/rest/raw/get?name=subutai-p2p.deb)
and install it with apt:

sudo apt install /path/to/subutai-p2p.deb

#### Install the Subutai Control Center

Download the [*deb
package*](https://cdn.subutai.io:8338/kurjun/rest/raw/get?name=subutai-control-center.deb)
and install it with apt:

sudo apt install /path/to/subutai-control-center.deb

### Mac OS

#### Install the Subutai P2P Daemon

Download and install the [*Mac OS
package*](https://cdn.subutai.io:8338/kurjun/rest/raw/get?name=subutai-p2p.pkg).

#### Install the Subutai Control Center

Download and install the [*Mac
package*](https://cdn.subutai.io:8338/kurjun/rest/raw/get?name=subutai-control-center.pkg).

### Windows

#### Install the Subutai P2P Daemon

Install the [*MSI package for
Windows*](https://cdn.subutai.io:8338/kurjun/rest/raw/get?name=subutai-p2p.msi).
Double click after downloading and follow the instructions.

#### Install the Subutai Control Center

Install the [*MSI package for
Windows*](https://cdn.subutai.io:8338/kurjun/rest/raw/get?name=subutai-control-center.msi).
Double click after downloading and follow the instructions.

Register your Peer
------------------

After you have all software installed, the first thing you’ll usually
want to do is to register your Peer with the Subutai Bazaar to easily
start sharing resources with the world. To register your Peer, find the
“Register” button in the upper right hand corner of the Console. When
you click this button, a dialog will pop up with fields asking you for
your Subutai Bazaar login and password. Provide your Bazaar credentials
and push the Register button. Within 3-10 seconds you should be notified
of being logged in. The button’s color will change from gray to green.
Your new peer will now appear on the Subutai Bazaar in your peers list.

**Congratulations! You are ready to share resources of your new Subutai
Peer on the Bazaar!**
