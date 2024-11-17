# Homelab Ansible Setup

## Playbooks
### Proxy
Setup Squid HTTP proxy for serving content from outside the homelab

### Jump
Setup for Ansible jump box to allow SSH into homelab from LAN devices

### Bootstrap
Setup server for subsequent ansible runs from jump box

### Poststrap
Finalize configuration after bootstrap

## Roles
### Agent
Installs GitHub Actions Runner for ansible jobs

### Netcfg
Setup static IP and firewall rules related to SSH

### SSH
Setup SSH certificates and keys for logins and SSH login configurations

### User
Creates a user