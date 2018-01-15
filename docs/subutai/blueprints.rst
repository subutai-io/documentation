Subutai Blueprints
==================

Subutai Blueprints are generalized instructions on how to provision an
applications into a P2P cloud environment. They're general in that They don't
have a priori knowledge of the exact environment, its available resources, or
the network topology to make optimal choices. They simple know the steps
needed to erect an application when given some infrastructure.

At application provisioning time, Subutai combines environment specific
information with these general instructions to optimally allocate resources
based on several factors:

* governance rules provided by environment owners
* cost criteria
* performance criteria
* load distribution
* redundancy criteria

This can happen perpetually and dynamically over time to maintain a desired
state. The term desired state should be familiar to those dealing with devops.
Subutai uses devops best practices in a comprehensive approach to application
provisioning in a P2P cloud environment. Blueprints use devops tools like 
Ansible, to apply idempotent changes to infrastructure. The Subutai Hub hosting
application blueprints pulls them directly from GitHub repositories where they
and other materials involved like Ansible Playbooks are version controlled.

More to come ...