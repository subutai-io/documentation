---
title: 'Advanced PeerOS Install'
visible: true
taxonomy:
    category:
        - docs
---


Users can manually install PeerOS through the Advanced Install option, which allows flexibility in that you can specify the configurations to be included in the setup. This guide describes the recommended way of installing Subutai PeerOS on a fresh Debian system. Alternatively, the [Quick Install](../peeros-quick-install) option is also available, which uses the default setup and settings.

Subutai, which is based on Debian, has its own Debian repository. Setting up the Debian system involves the following procedures:
1. Installing Subutai to convert the host into a Subutai Resource Host (RH)
2. Importing a special container named “management”, which automatically installs the Subutai Management Console in the RH, to convert it into a Subutai Peer

#### Before you start

! Don’t forget to set aside extra disk, partition, or volume.

* Extra disk, partition, or volume
Whether you plan to install Subutai in a virtual machine or a fresh server, it is mandatory to have a separate disk, partition, or logical volume. It will serve as storage for your resource host. Refer to the hardware requirements and the rest of this section before initiating your installation.
* Using your email or social networking accounts
Your email or social network account details are used only for verification and for setting up your unique username identifier. You may receive occasional product and community updates, but rest assured that your details will neither be used to send spam mails nor to solicit network contacts. Such practices are totally against our policies.

#### Hardware requirements
Unlimited hardware configuration options are possible. However, when setting up a peer with a single resource host, we recommend running it on a virtual machine with the following minimum requirements:

* 2 or more CPU cores
* 4 GB of RAM (8 GB or more is best)
* 2 disks or partitions - one for the operating system (more than 10 GB), and one for container storage (more than 100 GB)
* 1 network adapter - preferably 1 Gbit (bridged if stationary, NAT if on a machine, i.e. laptop, moving across different networks)

When running Subutai on a virtual machine, take note of the following guidelines with regard to hardware:
* Peers can run on Hyper-V, GCE, AWS, KVM, VirtualBox, VMware, and Parallels. Make sure that these virtual hardware resources are available to the guest operating system.
* A virtual machine is not necessary, but will prove a convenient approach. Peers can be installed on an existing physical host with full security and isolation without a VM. In this case, similar hardware requirements apply to the existing physical host.

#### Operating system requirements

Review these general caveats and requirements for the operating system on which you want to install Subutai:

* Using a freshly installed and stable version of Debian operating system is preferable.
* Update all system components to the latest available version including system libraries and the kernel.
  ✔️ In case the kernel has been upgraded, be sure to reboot your system before starting the installation. Otherwise, ZFS, in particular, might not install properly.
* Avoid installing additional components on the system.
* Avoid desktop distributions due to NetworkManager’s dnsmasq running on port 53.
  !  If not possible, be sure to disable dnsmasq on desktop editions. Refer to the instructions below, [Using a desktop operating system](#Using-desktop-operating-system).
* Ensure that the system has network connectivity (via a bridge if virtual), either with a static IP or one provided by DHCP.
* Before installing Subutai, verify that the required network ports listed below are not used:
  * udp/53 - DNS service port
  * udp/67 - DHCP service port
  * tcp/80 - Web service port
  * tcp/443 - Secure web service port
  * udp/1900 - Service discovery service port
  * udp/6881 - P2P service port
  * tcp/8086 - Metrics service port
  * tcp/8443 - Subutai Management Console web service port
  * tcp/8444 - Subutai Management LAN communication service port

  To verify, run `sudo lsof -i :53`, for example.
* After your installation, set the file descriptor limit by adding it to the `/etc/profile` file:
  `echo “ulimit -n 65535”`
* Make sure to restart your computer after you have completed the installation and set up procedures.

#### <a name="Using-desktop-operating-system"></a> Using a desktop operating system
Using a guest virtual machine allows for maximum flexibility to install a stock unmodified guest VM operating system, and reduces complications. Debian is our recommended operating system.

Virtual or not, desktop editions should be avoided. Besides unnecessarily wasting resources for the windowing system, they use NetworkManager that installs dnsmasq on port 53. If you do need to use a desktop operating system, here are the procedures to ensure that dnsmasq is disabled:

1. Check if port 53 is already bound:
   `sudo lsof -i :53`

   Any output from `lsof` means that port 53 is being used.

2. After verifying that port 53 is already bound, you must stop dnsmasq permanently. Doing so is safe and won’t affect the general use of your system. Here’s how you do that::

   `sudo systemctl disable systemd-resolved.service`
   
   `sudo service systemd-resolved stop`

3. Edit `/etc/NetworkManager/NetworkManager.conf` and then change the DNS property in the `[main]` section so that it is set to `default: dns=default`.

   Here's how the file may look after you have added or modified the DNS property:

   ```
   [main]
   plugins=ifupdown, keyfile
   dns=default
   [ifupdown]
   managed=false
   ```

4. Remove `resolv.conf` and then restart NetworkManager:
   `sudo rm /etc/resolv.conf`
   `sudo service network-manager restart`
   `sudo killall dnsmasq`

   The last `killall` command is just a precaution, don't worry if it says, “no such process”. Another `lsof` for port 53
   should not produce any output now, which means you’re ready to go on.

   !  If NetworkManager is not configured properly, after restart, you may need to add your nameserver into the `/etc/resolv.conf` file it generates. It’s best to add this to the NetworkManager connection configuration if you don’t want the `resolv.conf` file to be overwritten.

### Install Subutai PeerOS
!  All files must be run as root or sudo user.

1. Add the `contrib` and `non-free` components from both stretch and stretch-updates.

  For example, `sed -i 's/main/main contrib non-free/g' /etc/apt/sources.list`

2. Run: `apt update`

3. Install `zfs-dkms`:

   `apt install zfs-dkms`
   
> **WARNING**: The `apt nstall zfs-dkms` command may partially fail on the first try. Dependencies from **zfs-dkms** require loading the zfs module. Loading the zfs module does not occur resulting in a failure to build dependencies. As a result, the install reports a failure. Issuing a `/sbin/modprobe zfs` right after this failed attempt succeeds. The zfs module builds successfully on the failing first install. Another `apt install zfs-dkms` after loading the zfs module will succeed building all dependencies properly. If you encounter a failure on the first try, use this workaround to fix it:

   `/sbin/modprobe zfs && apt install zfs-dkms`

4. Run: `/sbin/modprobe zfs`

5. Create your storage partition using `ZFS`:

   `zpool create -f subutai /<path to your device>` (for example, `/dev/xvdb`).

6. Create your mountpoint:

   `zfs create -o mountpoint="/var/lib/lxc" -o acltype=posixacl subutai/fs`

7. Install `lxc`: `apt install lxc`

8. Add the Subutai repository to `apt`:

   `echo "deb http://deb.subutai.io/subutai prod main" > /etc/apt/sources.list.d/subutai.list`

9. Make sure `dirmngr` is installed:

   `apt install dirmngr`

10. Add security keys:

   `apt-key adv --recv-keys --keyserver keyserver.ubuntu.com C6B2AC7FBEB649F1`

11. Update `apt` and install Subutai:

   `apt update && apt install subutai`
   
12. Reboot

✔️ Make sure `/etc/subutai/agent.conf` has the appropriate CDN URL and step #8 above use the proper `master`/`dev` string in place of `prod` in the sources.list file. If not, edit and restart: `systemctl restart subutai.service`.

In case you notice a failed status for setting up rng-tools, take note that this is due to the original rng-tools.service requiring a hardware random generator installed. This is handled automatically by the installer, by starting an instance of subutai-rng.service when a generator is not present in your system.

#### Troubleshooting installation errors
To recover from an error during installation, you can manually run:
`dpkg --configure spl-dkms`
`dpkg --configure zfs-dkms`

### Import the Management Container

Now that you have successfully installed Subutai, and have an active RH, you can import the management software and its console to convert this host into a peer:

   `subutai import management`

Restart services to make sure all goes smoothly:

   `systemctl stop nginx && systemctl disable nginx && apt-get update && apt-get upgrade && systemctl restart subutai-nginx && systemctl status subutai-nginx`

#### Troubleshooting a CDN unreachable error

When installing directly on a desktop edition, the NetworkManager configuration may not configure the /etc/resolv.conf file properly to resolve CDN addresses causing and displaying - “CDN unreachable errors” - with the import command. If this happens, you must configure NetworkManager to use the right nameserver. For more information, refer to the note on step 1.d.

#### Congratulations! You have a peer!

Command will return the Subutai Console’s access URL, as shown in the screenshot below (within the red box).

![Peer Access](access.png?classes=image-left)

Using this URL, you can access the Management Console and manage the peer. On the output stream, the default admin password, "secret", is also provided. On your first login, you can assign your own admin password.

✔️ Before you log in, make sure that you have also installed the Subutai [E2E Browser Plugin](../../../software-components/e2e-plugin) with at least one PGP key.
