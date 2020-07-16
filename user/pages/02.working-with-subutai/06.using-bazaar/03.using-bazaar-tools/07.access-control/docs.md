---
title: 'Access Control'
visible: true
menu: Access Control
taxonomy:
    category:
        - docs
---


### What is Access Control?

Users can give control over resources to other users. *Access Control* gives the ability manage user groups, roles and permissions.

#### Create Role

![Create Role](create-role.png?cropResize=810,392)

* Name 
* Description 
* Permissions 
  
#### Permissions

READ_ENVIRONMENT  - can see an environment, read only

EDIT_ENVIRONMENT  - can change environment name, description etc,

SSH_ENVIRONMENT   - can ssh into containers

CHANGE_HOSTNAME_ENVIRONMENT - can change container hostnames

STOP_CONTAINER_ENVIRONMENT - can stop containers

START_CONTAINER_ENVIRONMENT - can stop container

CHANGE_TYPE_CONTAINER_ENVIRONMENT - can change container type
 
ADD_CONTAINER_ENVIRONMENT - can add container to environment

DESTROY_CONTAINER_ENVIRONMENT - can delete container from environment

ADD_SSH_KEY_ENVIRONMENT - can add ssh key to environment

DELETE_SSH_KEY_ENVIRONMENT - can delete ssh key from environment

ADD_APPLICATION_ENVIRONMENT - can add application to environment

ADD_DOMAIN_ENVIRONMENT - can add domain port mapping to environment

DELETE_DOMAIN_ENVIRONMENT - can delete domain port mapping from environment 



### Create user group


![Create Role](user-group.png?cropResize=810,392)

* Name 
* Description 
* Members
* Roles

User group has members and roles. Members can be selected from the user list. Users can select roles from their own roles only.


### Environment sharing

![Create Role](env-sharing.png?cropResize=810,392)