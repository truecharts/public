# Hostname

## key: hostname

- Type: `string`
- Default: `""`
- Helm Template: ✅

Specifies pod's hostname

Examples:

```yaml
hostname: some_hostname

hostname: "{{ .Values.path.to.key }}"
```

Kubernetes Documentation:

- [Hostname](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#pod-s-hostname-and-subdomain-fields)
