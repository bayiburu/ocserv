# docker-ocserv

Lightweight AnyConnect VPN Docker image based on Alpine Linux, focused on security and ease of use.

## Overview

This image provides a ready-to-run OpenConnect VPN server (ocserv) for Cisco AnyConnect clients, with persistent configuration, user management, and TLS support.

## Prerequisites

- Docker 20.10 or later is installed on the host machine, with permission to run docker commands.
- For using Let's Encrypt certificates: Certificates have been issued via certbot on the host, located at `/etc/letsencrypt/live/`.
- If no trusted certificate is available: A self-signed certificate can be used (generation steps are provided below).

## Environment Variables

| Variable | Description | Default | Required |
|----------|-------------|---------|----------|
| `DOMAIN` | The domain name for SSL certificates | - | ✅ Yes |

## Quick Start

Run `ocserv` in a new container:

```sh
# Create SSL certificates.
certbot certonly \
    --webroot \
    --webroot-path=/var/www/acme-challenge \
    -d ocserv.example.com

# Create a persistent volume for ocserv data.
docker volume create ocserv

# Run the ocserv container.
docker run --privileged \
           --name ocserv \
           --detach \
           -e DOMAIN=ocserv.example.com \
           -v ocserv:/data \
           -v /etc/letsencrypt:/etc/letsencrypt:ro \
           -p 6443:443 \
           bayiburu/ocserv:latest
```

#### User Management

In order to do that, we will use openconnect password (ocpasswd) utility. It allows the generation and handling of the password authentication used by OpenConnect VPN Server.

NOTE: All commands are run on the host machine.

**Adding a user**

We can create users for our VPN by using the command below. For example we will create a user named "myusername".

```sh
docker exec -it ocserv ocpasswd -c /data/passwd myusername
```

You will be asked to set a password for the user and to confirm it. We can use the same command to reset the password of the user.

**Locking a User**

Prevents the specified user from logging in by locking its password.

```sh
docker exec -it ocserv ocpasswd -c /data/passwd -l username
```

**Unlocking a User**

Re−enables login for the specified user by unlocking its password.

```sh
docker exec -it ocserv ocpasswd -c /data/passwd -u username
```

**Deleting a User**

Deletes the specified user from the VPN server.

```sh
docker exec -it ocserv ocpasswd -c /data/passwd -d username
```
