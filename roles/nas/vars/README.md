# nas role vars documentation

NFS exports:

```yaml
nfs_exports:
  path: '/path/to/export'
  network: '10.16.0.0/21'  # default is '*'
  options: 'rw'            # default is rw,acl,sync,no_subtree_check,sec=krb5p
```

SMB shares:

```yaml
smb_shares:
  - name: share-name
    path: /path/to/share
    timemachine: true      # default is omitted
```

Ownership paramters for directory paths:

```yaml
ownerships:
  - acl_user: username
    acl_user_perms: rwX     # optional, default is "rwX"
    acl_group: groupname
    acl_group_perms: rwX    # optional, default is "rwX"
    unix_user: username
    unix_group: groupname
    unix_perms_dir: "0755"  # optional, default is "0775"
    unix_perms_file: "0755" # optional, default is "0664"
    path: /tank/path/name
 
```
