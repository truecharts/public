# Host Aliases

## key: hostAliases

Info:

- Type: `list`
- Default: `[]`
- Helm Template: ✅

Can be defined in:

- `.Values`.hostAliases

---

Adds entries to a Pod's `/etc/hosts` file.

Examples:

```yaml
hostAliases:
  - ip: 10.10.10.100
    hostnames:
      - server1.local
      - server-nickname.local
  - ip: 127.0.0.1
    hostnames:
      - example.com
```

Kubernetes Documentation:

- [Host Aliases](https://kubernetes.io/docs/tasks/network/customize-hosts-file-for-pods)
