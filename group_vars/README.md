# group_vars Documentation

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
