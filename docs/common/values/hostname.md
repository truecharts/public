# Hostname

## key: hostname

Info:

- Type: `string`
- Default: `""`
- Helm Template: ✅

Can be defined in:

- `.Values`.hostname

---

Specifies pod's hostname

Examples:

```yaml
hostname: some_hostname

hostname: "{{ .Values.path.to.key }}"
```

Kubernetes Documentation:

- [Hostname](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#pod-s-hostname-and-subdomain-fields)
