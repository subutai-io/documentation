---
title: 'Maintain your Vagrant plugins'
menu: Maintain Vagrant Plugins
visible: true
taxonomy:
    category:
        - docs
---

### Maintain your Vagrant plugins
Here are best practice guidelines when using the Vagrant providers and boxes:

* Always make sure that your Vagrant boxes and plugins are up to date.
  * [How to update Vagrant boxes](#How-to-update-Vagrant-boxes)
  * [How to update the Vagrant Subutai plugin](#How-to-update-Vagrant-Subutai-plugin)
* If you have more than two hypervisors in your system, make sure to turn on and use only one at a time; otherwise, they will collide when used in parallel.
* Before running updates and configuration tasks on Hyper-V, be sure that you have the required Administrator privileges.
* See the [Common Errors](#Common-errors-Vagrant-plugins) section with details on troubleshooting procedures and guidelines.

#### <a name="How-to-update-Vagrant-boxes"></a> How to update Vagrant boxes
When updating Vagrant boxes, make sure that you specify the provider in the command. Use the command for the appropriate provider:

<div class="scrollTable" markdown="1">

|Vagrant provider|Update command|
|----------------|--------------|
|VirtualBox| `vagrant box update --box subutai/stretch --provider virtualbox` |
|Hyper-V| `vagrant box update --box subutai/stretch --provider hyperv` |
|Libvirt| `vagrant box update --box subutai/stretch --provider libvirt` |
|VMware Workstation or Fusion| `vagrant box update --box subutai/stretch --provider vmware_desktop` |
|Parallels| `vagrant box update --box subutai/stretch --provider parallels`|

</div>

#### <a name="How-to-update-Vagrant-Subutai-plugin"></a> How to update the Vagrant Subutai plugin
`vagrant plugin update vagrant-subutai `

#### <a name="Common-errors-Vagrant-plugins"></a> Common errors encountered when using Vagrant plugins

!! **Error:** No usable default provider could be found for your system

    No usable default provider could be found for your system.

    Vagrant relies on interactions with 3rd party systems, know as "providers",
    to provide Vagrant with resources to run development environments. Examples
    are VirtualBox, VMware, Hyper-V.

* Issue: Setting up Vagrant with a provider that is not supported.
* Action: Use any of the supported Vagrant providers and their versions from the [table here](../other-hypervisors).

!! **Error:** There are errors in the configuration of this machine

    Bringing machine 'default' up with 'vmware_desktop' provider...
    There are errors in the configuration of this machine. Please fix the following
    errors and try again:

    vm:

    * The 'registration' provisioner could not be found.

* Issue: Bringing up a machine when the Vagrant Subutai plugin is not updated.
* Action: To update the Vagrant Subutai plugin, run:
`vagrant plugin update vagrant-subutai`

!! **Error:** VT-x is disabled in the BIOS for all CPU modes

    The system cannot find the path specified.
    There was an error while executing `VBoxManage`, a CLI used by Vagrant
    for controlling VirtualBox. The command and stderr are shown below.


    Command: ["startvm", "a5d219ac-d6fd-4ab9-bc8e-000dd612fdae", "--type", "headless"]

    Stderr: VBoxManage.exe: error: VT-x is disabled in the BIOS for all CPU modes
    (VERR_VMX_MSR_ALL_VMX_DISABLED)
    VBoxManage.exe: error: Details: code E_FAIL (0x80004005), component ConsoleWrap,
    interface IConsole


* Issue: Trying to create a peer while VT-x is not enabled on the machine.
* Action: Reboot your machine to launch BIOS, where you can enable VT-x.

!! **Error:** VT-x is being used by another hypervisor

    ==> default: Booting VM...
    There was an error while executing 'VBoxManage', a CLI used by Vagrant
    for controlling VirtualBox. The command and stderr is shown below.
    ...
    Stderr: VBoxManage: error: VT-x is being used by another hypervisor (VERR_VMX_
    IN_VMX_ROOT_MODE).
    VBoxManage: error: VirtualBox can't operate in VMX root mode. Please disable
    KVM kernel extension, recompile your kernel and reboot (VERR_VMX_
    IN_VMX_ROOT_MODE)
    VBoxManage: error: Details: code NS_ERROR_FAILURE (0x80004005), component
    ConsoleWrap, interface IConsole

* Issue: Setting up a machine with the VirtualBox provider while another hypervisor is already running on the same machine.
* Action: Turn off the other hypervisor first, before bringing up VirtualBox.

!! **Error:** Cannot allocate memory

    Call to virDomainCreateWithFlags failed: internal error: process exited
    while connecting to monitor: 2018-05-26T05:21:29.9574D3Zqemu-system-x86_64:
    cannot set up guest memory 'pc.ram': Cannot allocate memory

* Issue: Installing Vagrant provider on a machine that does not have enough available RAM.
* Action: Verify that your system has the minimum required RAM size for guests. You may check the requirements at <requirements link>

!! **Error:** Failed to build gem native extension

    Bundler, the underlying system Vagrant uses to install plugins, reported
    an error. The error is shown below...

    ERROR: Failed to build gem native extension

        current directory: /home/...
    *** extconf.rb failed ***
    Could not create Makefile due to some reason, probably lack of
    necessary libraries and/or headers. Check the mkmf.log file for more
    details. You may need configuration options.

* Issue: Using Libvirt without the necessary dependencies.
* Action: Before installing, be sure that you have all the build dependencies for the Vagrant Libvirt provider. Review the dependencies required for your Linux distribution [here](https://github.com/vagrant-libvirt/vagrant-libvirt#installation).

!! **Error:** Could not find a registered machine

    There was an error while executing 'VBoxManage', a CLI used by Vagrant
    for controlling VirtualBox. The command and stderr is shown below.
    ...
    Stderr: VBoxManage: error: Could not find a registered machine with UUID {...}
    VBoxManage: error: Details: code VBOX_E_OBJECT_NOT_FOUND (0x80bb0001), component
    VirtualBoxWrap, interface IVirtualBox, callee nsISupports
    VBoxManage: error: Context:"FindMachine(Bstr(VMName).raw(), machine.asOutParam())"
    at line 152 of file VBoxManageMisc.cpp

* Issue: The version of the hypervisor is not or no longer supported.
* Action: Refer the table [here](../other-hypervisors) for the current supported versions of Vagrant providers.

!! **Error:** Peer finished to up with the following errors...

    ... This is an internal error and should be reported as a bug to support@hashicorp.com.

* Issue: Cannot bring up peer through VMware due to reported VMware issues.
* Action: Refer to the known VMware issues and possible workarounds [here](https://www.vagrantup.com/docs/vmware/known-issues.html).

!! **Error:** The Hyper-V cmdlets for PowerShell are not available

    Bringing machine 'default' up with 'fyperv' provider...
    ==> default: Verifying Hyper-V is enabled...
    The Hyper-V cmdlets for PowerShell are not available! Vagrant requires
    these to control Hyper-V. Please enable them in the "Windows Features"
    control panel and try again.

* Issue: Using the Hyper-V provider while Hyper-V is not enabled on the system.
* Action: Be sure to enable Hyper-V on Windows before using the provider. You may refer to the instructions [here](https://blogs.technet.microsoft.com/canitpro/2015/09/08/step-by-step-enabling-hyper-v-for-use-on-windows-10/).

!! **Error:** An action ‘read_state’ was attempted on the machine… but another process is already executing an action on the machine

    C:\Users\User\Peer\Peer2>vagrant ssh
    An action ‘read_state’ was attempted on the machine 'default', but
    another process is already executing an action on the machine. Vagrant
    locks each machine for access by only one process at a time. Please
    wait until the other Vagrant process finishes modifying this machine,
    then try again.

* Issue: Trying to SSH into a machine while other Vagrant processes are running.
* Action: Access System Monitor or Task Manager (for Windows), and then terminate all Ruby and Vagrant processes.

!! Error: An error occurred while executing vmrun, a utility for controlling VMware machines

    Command: ["start", "/Users/admin/justatest/Subutai-peers/subutai-peer_vmwre/.vagrant/machines/default/vmware_desktop/6e1da1a7-6c3a-44c4-aee7-3dad3da14b13/stretch.vmx", "nogui", {:notify=>[:stdout, :stderr], :timeout=>45}]

    Stdout: 2018-10-31T15:07:02.423| ServiceImpl_Opener: PID 28249
    Error: The operation was canceled

* Possible reasons with recommended actions:
  * Virtualization extensions aren't enabled on the CPU
  * The Vmware trial has expired or the application requires a license key
  * Permission problems on the install (corrupted install)
  * You need to fill out some form data in the GUI.

!! Error: The following SSH command responded with a non-zero exit status.
Vagrant assumes that this means the command failed!

	/sbin/ifdown 'enp0s8' || true
	/sbin/ip addr flush dev 'enp0s8'
	# Remove any previous network modifications from the interfaces file
	sed -e '/^#VAGRANT-BEGIN/,$ d' /etc/network/interfaces > /tmp/vagrant-network-interfaces.pre
	sed -ne '/^#VAGRANT-END/,$ p' /etc/network/interfaces | tac | sed -e '/^#VAGRANT-END/,$ d' | tac > /tmp/vagrant-network-interfaces.post
	cat \
	  /tmp/vagrant-network-interfaces.pre \
	  /tmp/vagrant-network-entry \
	  /tmp/vagrant-network-interfaces.post \
	  > /etc/network/interfaces
	rm -f /tmp/vagrant-network-interfaces.pre
	rm -f /tmp/vagrant-network-entry
	rm -f /tmp/vagrant-network-interfaces.post

	/sbin/ifup 'enp0s8'

	Stdout from the command:



	Stderr from the command:

	ifdown: interface enp0s8 not configured
	Internet Systems Consortium DHCP Client 4.3.5
	Copyright 2004-2016 Internet Systems Consortium.
	All rights reserved.
	For info, please visit https://www.isc.org/software/dhcp/

	Listening on LPF/enp0s8/08:00:27:07:1d:cb
	Sending on   LPF/enp0s8/08:00:27:07:1d:cb
	Sending on   Socket/fallback
	DHCPDISCOVER on enp0s8 to 255.255.255.255 port 67 interval 6
	DHCPDISCOVER on enp0s8 to 255.255.255.255 port 67 interval 15
	DHCPDISCOVER on enp0s8 to 255.255.255.255 port 67 interval 15
	DHCPDISCOVER on enp0s8 to 255.255.255.255 port 67 interval 10
	Terminated
	ifup: failed to bring up enp0s8	

**Recommended action:** Please choose bridge interface with state _UP_. For example, one whose output of the command `ip a` is similar to this:

	enp3s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
	link/ether 60:a4:4c:b0:51:d6 brd ff:ff:ff:ff:ff:ff
	inet 192.168.77.21/24 brd 192.168.77.255 scope global dynamic enp3s0
       valid_lft 35559sec preferred_lft 35559sec
    inet6 fe80::62a4:4cff:feb0:51d6/64 scope link 
       valid_lft forever preferred_lft forever

!! **Error:** Network errors prevent access to Peer

    Peer is unreachable via Console UI, or accuses networking/DNS errors such as "Temporary failure resolving 'httpredir.debian.org'"

* Action: reload your Peer from the Resource Host: ```vagrant reload```