Glossary
========

* **Peer** is a single Subutai node with management services (a management host container), and local resource hosts (1 - N RHs) that contribute resources to be exposed.
* **Management Host** is a server hosting management console part of Subutai setup (It is a container that hosts a management container with Subutai console app inside).
* **Resource hosts** are servers providing premises for new containers.
* **Environment** is a logically grouped set of containers distributed across multiple peers that share the same network (they belong to the same p2p swarm - see more on p2p).
* **Container** is an LXC created during environment setup ( a building block of an environment).
* **Template** is an image from which containers are created (cloned)


