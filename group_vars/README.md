# group_vars Documentation

## all/containers.yml

The `containers.yml` variables have default information needed for any containers defined. The following keys are required:

```yaml
containers_default_pubkey: 'ssh-rsa ...'
```

The `networking.yml` variables have container networking information. The following keys are required:

```yaml
networking_subnet: 192.168.0
networking_subnet_size: 24
networking_default_gateway: 192.168.0.1
```

## init/proxmox_hosts.yml

The `proxmox_hosts.yml` variables have all the information we need to configure Proxmox-VE hosts. This includes setting up the hosts and creating containers on them. For now, containers will be statically defined but they can likely migrate from one host to another
unless they have specific needs to be on a particular host. The `proxmox_hosts.yml` contains secrets so it is encrypted with the vault keys. The format of the file looks like:

```yaml
proxmox_hosts:
  pve001:
    api_host: '10.101.1.1'
    api_user: 'root@pam'
    api_password: 'SuperSecurePassword1'
    zfs_pools:
      - rpool
      - tank
  pve002:
    api_host: '10.101.1.2'
    api_user: 'root@pam'
    api_password: 'SuperSecurePassword2'
    zfs_pools:
      - rpool
  pve003:
    api_host: '10.101.1.4'
    api_user: 'root@pam'
    api_password: 'SuperSecurePassword3'
    zfs_pools:
      - rpool
      - tank
  pve004:
    api_host: '10.101.1.5'
    api_user: 'root@pam'
    api_password: 'SuperSecurePassword4'
    zfs_pools:
      - rpool
```
