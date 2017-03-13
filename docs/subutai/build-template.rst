Custom Templates
================

This document describes steps that should be performed to build custom Subutai template based on Ubuntu 16.04 image. 

Preparing environment
^^^^^^^^^^^^^^^^^^^^^

To build new Subutai template you need following:

1) Subutai Resource host with latest version;

2) Imported ubuntu16 image to the system::

    # subutai import ubuntu16
    INFO[2016-05-02 12:17:56] [Importing ubuntu16]
    INFO[2016-05-02 12:17:56] [Version: 4.0.0, branch: dev]
    INFO[2016-05-02 12:17:56] Trying local repo, dial tcp 10.10.10.1:8339: getsockopt: no route to host
    INFO[2016-05-02 12:17:57] [Downloading ubuntu16]
     73.09 MB / 73.09 MB [==============================================================] 100.00%
    INFO[2016-05-02 12:18:13] [Unpacking template ubuntu16]
    INFO[2016-05-02 12:18:15]
    [Installing template ubuntu16]

Preparing Container
^^^^^^^^^^^^^^^^^^^

1) First of all you need to clone ubuntu16 template to container with required name::

    subutai clone ubuntu16 nginx
    INFO[2016-05-02 12:22:58] [nginx started]
    INFO[2016-05-02 12:22:58] [nginx with ID CEDFD8418B76AB41DC61F14E17C6825041D0A834 successfully cloned]

2) Attach container to execute installation commands inside container::

    lxc-attach -n nginx
    (amd64)root@nginx:/# 

3) Install required software into container::

    apt update; apt install nginx -y

Service Management
^^^^^^^^^^^^^^^^^^

Ubuntu 16.04 uses systemd for service management.

Most of services installed from Ubuntu repository provides correct services that will be started after container up.

But if you need to configure custom service or check that your services active you will need following command:

* ``systemctl status nginx`` shows current status of nginx.service;
* ``systemctl start nginx`` starts nginx.service;
* ``systemctl stop nginx`` stops nginx.service;
* ``systemctl enable nginx`` enables nginx.service auto start after system boot;
* ``systemctl disable nginx`` disables nginx.service auto start after system boot.

Adding custom service to the container
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you need add custom systemd service to the container that was not included after installing your software, you can add systemd unit file that describes required service

Put file with any name with .service suffix like sleep.service to the following directory: ``/etc/systemd/system/sleep.service``

Minimal file should look like following::

    [Unit]
    Description=MyApp

    [Service]
    ExecStart=/bin/sleep 9999

    [Install]
    WantedBy=multi-user.target

After these operation you can use systemctl commands to manipulate your service:

.. image:: https://cloud.githubusercontent.com/assets/8612618/14954691/488ae4a0-1096-11e6-9b0f-de3b527609bd.png

Exporting prepared template
^^^^^^^^^^^^^^^^^^^^^^^^^^^

To finish template preparation you just need to export your container::

    subutai export nginx
    INFO[2016-05-02 12:48:42] [nginx promoted]
    INFO[2016-05-02 12:48:45] [nginx exported to /mnt/lib/lxc/tmpdir/nginx-subutai-template_4.0.0_amd64.tar.gz]


