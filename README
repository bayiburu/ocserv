# docker-ocserv

AnyConnect VPN Docker image based on alpine.

## How to use this image

Run `ocserv` in a new container:

```sh
docker volume create ocserv
docker run --privileged \
           --name ocserv \
           --detach \
           -v ocserv:/data \
           -p 8443:443 \
           bayiburu/ocserv:latest
```

#### Create and manage users

In order to do that, we will use openconnect password (ocpasswd) utility. It allows the generation and handling of the password authentication used by OpenConnect VPN Server.

**Adding a user**

We can create users for our VPN by using the command below. For example we will create a user named "myusername".

```sh
docker exec -it ocserv ocpasswd -c /data/ocpasswd myusername
```

You will be asked to set a password for the user and to confirm it. We can use the same command to reset the password of the user.

**Locking a User**

Prevents the specified user from logging in by locking its password.

```sh
ocpasswd -c /etc/ocserv/ocpasswd -l username
```

**Unlocking a User**

Re−enables login for the specified user by unlocking its password.

```sh
ocpasswd -c /etc/ocserv/ocpasswd -u username
```

**Deleting a User**

Deletes the specified user from the VPN server.

```sh
ocpasswd -c /etc/ocserv/ocpasswd -d username
```