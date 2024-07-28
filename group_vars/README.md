# group_vars Documentation

## all/backup.yml

The `backup.yml` variables have default information needed for rdiff backups. The following keys are required:

```yaml
backup_host: '192.168.0.1'
backup_path: /mnt/backups
backup_owner: root
backup_group: root
```

## all/caddy.yml

The `caddy.yml` variables have default information needed to generate a Caddyfile and install the executable. The following keys are required:

```yaml
caddy_domain: domain.com
caddy_domain_wildcard: "*.domain.com"
caddy_dns_cloudflare_email: user@domain.com
caddy_dns_cloudflare_token: aslfkalsdflkasdljfljsadljksdjfalskdf
caddy_uid: 1999
caddy_gid: 1999
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

## all/dns.yml

The `dns.yml` variables have default information needed for correctly setting up dnscrypt-proxy, unbound and pi-hole on dns hosts. The following keys are required:

```yaml
dnscrypt_proxy_gid: '5000'
dnscrypt_proxy_uid: '5000'

pihole_gid: '5002'
pihole_uid: '5002'
# The output of echo -n P@ssw0rd | sha256sum | awk '{printf "%s",$1 }' | sha256sum
pihole_password: 0e69e6a4038df88d4c62c837edd7e04a95ea6368bca9d469e00ad766a2266770

unbound_gid: '5001'
unbound_uid: '5001'
```

## all/letsencrypt_duckdns.yml

The `letsencrypt_duckdns.yml` variables have information to set up LetsEncrypt using DuckDNS as a DNS provider. The following keys are required:

```yaml
letsencrypt_duckdns_email: foo@domain.com
letsencrypt_duckdns_token: '8675309-4242-4460-a210-93add45be0c0'
letsencrypt_duckdns_url: '*.domain.duckdns.org'
```

## all/mqtt.yml

The `mqtt.yml` variables have authentication information for other apps to use when connecting to the MQTT broker. The following keys are required:

```yaml
mqtt_user: mqtt_username
mqtt_password: secure_mqtt_password
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

## all/redirects.yml

The `redirects.yml` variables have information so that reverse proxy and DNS entries are set up for devices that are not Proxmox hosts nor LXC containers. The following keys are required:

```yaml
generic_host_redirects:
  - service: 'downstairs_vacuum'
    lb_url: 'http://10.13.5.1'
    reverse_proxy_hostname: 'downstairs-vacuum.domain.com'
  - service: 'upstairs_vacuum'
    lb_url: 'http://10.13.5.2'
    reverse_proxy_hostname: 'upstairs-vacuum.domain.com'

generic_host_dns:
  - shortname: downstairs-vacuum
    reverse_proxy_ip_address: 10.10.5.0
    internal_ip_address: 10.13.5.1
  - shortname: upstairs-vacuum
    reverse_proxy_ip_address: 10.10.5.0
    internal_ip_address: 10.13.5.2
```

## all/syslog-ng.yml

The `syslog-ng.yml` variables have information about the syslog-ng information.

```yaml
syslog_ng_host: syslog-ng.domain.com
```

## all/unbound.yml

The `unbound.yml` variables have information about the local domains hosted and where they stored. Unfortunately, we need to specify the hosts where DNS is running rather than just using the dns_hosts group.

```yaml
unbound_user: root
unbound_config_path: /opt/unbound/etc/unbound/conf.d
unbound_external_domains:
  - domain.com
unbound_internal_domains:
  - int.domain.com
unbound_hosts:
  - 192.168.0.100
  - 192.168.0.101
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
    zfs_options:
      tank:
        acltype: posix
        compression: lz4
        dnodesize: auto
        xattr: sa
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
