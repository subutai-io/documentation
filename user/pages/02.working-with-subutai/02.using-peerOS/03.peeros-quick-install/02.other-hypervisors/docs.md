---
title: 'Other Hypervisors'
visible: true
taxonomy:
    category:
        - docs
---

# Basic setup using Vagrant with other supported hypervisors

You can launch your own peers using Vagrant and the hypervisor of your choice. This guide shows you how to set up the supported Vagrant provider and use a Vagrant box created by Subutai to launch your peer. 

### Prerequisites

Before installing a provider, it is important that you have configured [Vagrant](https://www.vagrantup.com/downloads.html) and the hypervisor of your choice. Some hypervisors may require additional configuration, which is outside the scope of this guide. You also need the [Vagrant Subutai plugin](https://github.com/subutai-io/vagrant) installed on your system. 
***

### Supported providers

At Subutai, we have built Vagrant boxes, available on Vagrant Cloud, for the following Vagrant providers:

|Supported OS|Linux|Mac|Windows|
|------------------|---------------|----------------|--------------------|
|VirtualBox (5.2.0 or higher)|✅|✅|✅|
|Libvirt|✅| | |
|Hyper-V (8.1 or higher)| | |✅|
|VMware Workstation (regular and Pro)|✅| |✅|
|VMware Fusion (regular and Pro)| |✅| |
|Parallels Desktop (10 or higher; only Pro and Business editions)| |✅| |

Here are the boxes to choose from, two versions for each supported Vagrant provider. The boxes use a different Linux OS flavor for the guest virtual machine OS.

* [Debian 9.x (Stretch)](https://app.vagrantup.com/subutai/boxes/stretch) 
* [Ubuntu 16.04 (Xenial)](https://app.vagrantup.com/subutai/boxes/xenial) 

In case you encounter an error during installation, see [Common errors encountered when using Vagrant plugins](https://github.com/MarilizaC/doc_v2/wiki/Maintain-your-Vagrant-plugins#-common-errors-encountered-when-using-vagrant-plugins).

<details><summary><strong> Libvirt setup </strong></summary>

<p> Between Libvirt's QEMU and KVM hypervisors with remote management capabilities, the Vagrant Subutai plugin currently supports only the local KVM hypervisor.  

!!! Vagrant modifications can be made to create remote KVM-based virtual machines, but that is beyond the scope of this guide.

To install and use the provider (on Linux variants only):
1. Install the KVM hypervisor on your local machine.
   * For instructions on Ubuntu, visit the [Ubuntu wiki site](https://help.ubuntu.com/community/KVM/Installation).
   * For instructions on Debian, visit the [Debian wiki site](https://wiki.debian.org/KVM).
2. Install the Vagrant Libvirt provider plugin.  
   :heavy_exclamation_mark: Before installing the provider, be sure that you have all the build dependencies for your Linux distribution. Refer to the detailed instructions [here](https://github.com/vagrant-libvirt/vagrant-libvirt#installation).

   `vagrant plugin install vagrant-libvirt`
3. Launch a Subutai Peer using the Stretch box with the Libvirt provider.   
   `vagrant init subutai/stretch`   
   `vagrant up --provider libvirt`
</p>

</details> 

<details><summary><strong> Parallels Desktop setup </strong></summary>

<p>
For this commercial desktop hypervisor, only Parallels version 10 and above are supported and only the Pro and Business editions can be used with the Vagrant Parallels provider.

To install and use the provider (on Mac only):
1. Install the [Parallels Desktop for Mac](https://www.parallels.com/products/desktop/).
2. Install the Vagrant Parallels Provider plugin.   
   `vagrant plugin install vagrant-parallels`

   For more information about this provider, see the documentation [here](https://github.com/Parallels/vagrant-parallels).
3. Launch a Subutai Peer using the Stretch box for the Parallels provider.   
   `vagrant init subutai/stretch`   
   `vagrant up --provider parallels`
</p>

</details>  

<details><summary><strong> VMware Fusion and Workstation setup </strong></summary>

<p>
The Vagrant VMware plugin, a commercial product provided by [HashiCorp](https://www.hashicorp.com), requires the purchase of a provider license to operate. To purchase a license, visit the [Vagrant VMware provider](https://www.vagrantup.com/vmware/#buy-now) page. The Vagrant VMware plugin is compatible with both the regular and Pro versions of VMware Fusion and VMware Workstation.

To install and use the provider:
1. Make sure that you have installed either one of these supported hypervisors:    
   * [VMware Workstation](https://kb.vmware.com/s/article/2057907) (Linux and Windows)
   * [VMware Fusion](https://kb.vmware.com/s/article/2014097) (Mac OS) 
2. Install the Vagrant VMware Desktop Provider plugin.

   1. Install the Vagrant VMware Utility, a system installation package available for download [here](https://www.vagrantup.com/docs/vmware/vagrant-vmware-utility.html).
   2. Initiate the Vagrant VMware Desktop provider plugin installation.   
   Go [here](https://www.vagrantup.com/docs/vmware/installation.html) for detailed instructions about the installation and license setup.   
   `vagrant plugin install vagrant-vmware-desktop`

3. Launch a Subutai Peer using the Stretch box for the VMWare Desktop provider.   
   `vagrant init subutai/stretch`   
   `vagrant up --provider vmware_desktop`
</p>

</details>

<details><summary><strong> Hyper-V and VirtualBox setup </strong></summary>  

<p>
Vagrant comes ready with a built-in provider for Hyper-V and VirtualBox, so you do not need to install one. The Hyper-V provider is compatible with Windows Enterprise, Professional, or Education 8.1 and higher versions only. 

1. Install Hyper-V or VirtualBox on your machine.   
   :heavy_exclamation_mark: Hyper-V requires that you execute Vagrant with Administrative privileges. The same privileges are required when creating and managing virtual machines with Hyper-V. Vagrant displays an error if you do not have the proper permissions.

   * For Hyper-V on Windows 10, follow the detailed procedures on any of these sites:
     * [Enable Hyper-V](https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/quick-start/enable-hyper-v)
     * [Enabling Hyper-V on Windows 10](https://blogs.technet.microsoft.com/canitpro/2015/09/08/step-by-step-enabling-hyper-v-for-use-on-windows-10/)

   * To install VirtualBox, go [here](https://www.virtualbox.org/wiki/Downloads).    
     If you encounter errors when installing VirtualBox on MacOS, you may refer to the guide [here](https://github.com/subutai-io/control-center/wiki/Troubleshooting-VirtualBox).

2. Now, let’s launch a peer using the Stretch box with the provider:

   * Vagrant Hyper-V provider   
     `vagrant init subutai/stretch`    
     `vagrant up --provider hyperv`   
   
!!!! After running vagrant up, when asked to choose a switch, select the option for vagrant-subutai.

   * Vagrant VirtualBox provider   
     `vagrant plugin install vagrant-vbguest`   
     `vagrant init subutai/stretch`   
     `vagrant up --provider virtualbox`   
</p>

</details>
