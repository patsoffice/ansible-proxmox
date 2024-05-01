# ansible-proxmox

An Ansible playbook for managing a homelab of Proxmox-VE servers

To run all tasks on the Proxmox-VE hosts and any containers installed on them, the simplest invocation is:

```sh
./setup.sh
```

To run individual tasks, it's necessary to include some extra tags:

```sh
./setup.sh --tags host_manager,apt
```

The `host_manager` role adds each host to the `proxmox_hosts` group.

To run a task involving a container, the `containers` tag is required:

```sh
./setup.sh --tags host_manager,containers,netboot_xyz
```

For CentOS containers, unfortunately, a manual step need to happen before the container can be configured. CentOS containers do not start sshd. To remedy this, do the following:

```sh
# On the proxmox host, console into the container where XXX is the vm_id
pct console XXX
# After you log in, run the following:
dnf install -y openssh-server
cat << EOF > /etc/ssh/sshd_config.d/60-root-login
PermitRootLogin prohibit-password
EOF
systemctl enable --now sshd.service
```
