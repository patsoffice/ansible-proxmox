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
