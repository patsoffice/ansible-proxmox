# group_vars Documentation

## all/backup.yml

The `backup.yml` variables have default information needed for rdiff backups. The following keys are required:

```yaml
backup_host: '192.168.0.1'
backup_path: /mnt/backups
backup_owner: root
backup_group: root
```

## all/containers.yml

The `containers.yml` variables have default information needed for any containers defined. The following keys are required:

```yaml
containers_default_pubkey: 'ssh-rsa ...'
```

## all/cron.yml

The `cron.yml` variables have default information needed for correctly setting crontabs. The following keys are required:

```yaml
cron_mailto: user@domain.com
```

## all/networking.yml

The `networking.yml` variables have container networking information. The following keys are required:

```yaml
networking_subnet: 192.168.0
networking_subnet_size: 24
networking_default_gateway: 192.168.0.1
```

## all/package-urls.yml

The `package-urls.yml` variables have links to packages that roles will use to install them in containers.

## all/traefik.yml

The `traefik.yml` variables have information about the traefik instance that is used as a reverse proxy. A file is created on the remote server configuring the reverse proxy. The following keys are required:

```yaml
traefik_host: '192.168.1.5'
traefik_user: remote_user
traefik_config_path: /config/traefik/config.d
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
    containers:
      - hostname: octoprint-host.domain.com
        vmid: 150
        password: SuperSecretContainerPassword
        unprivileged: false
        ostemplate: 'ubuntu-22.04-standard_22.04-1_amd64.tar.zst'
        cores: 1
        memory: 512
        swap: 512
        storage: 'local-zfs'
        rootfs_size: 8
        features:
          - 'nesting=1'
        proxmox_default_behavior: compatibility
        config_changes:
          - 'lxc.cgroup2.devices.allow: c 189:1 rwm'
          - 'lxc.mount.entry: /dev/bus/usb/003/002 dev/bus/usb/003/002 none bind,optional,create=file'
          - 'lxc.cgroup2.devices.allow: c 166:* rwm'
          - 'lxc.mount.entry: /dev/ttyACM0 dev/ttyACM0 none bind,optional,create=file'
        config_task: octoprint
        traefik_service: octoprint
        traefik_hostname: octoprint.domain.com
        service_port: 5000
  pve004:
    api_host: '10.101.1.5'
    api_user: 'root@pam'
    api_password: 'SuperSecurePassword4'
    zfs_pools:
      - rpool
```
