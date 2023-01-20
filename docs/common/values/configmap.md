# ConfigMap

## key: configmap

Info:

- Type: `dict`
- Default: `{}`
- Helm Template:
  - content.KEY: ❌
  - content.KEY.value: ✅

Can be defined in:

- `.Values`.configmap

---

Creates a configmap based on the `content`

Options:

```yaml
configmap:
  somename:
    enabled: true
    # Optional
    labels: {}
    # Optional
    annotations: {}
    # Optional
    nameOverride: ""
    # Tells to common library that this contains environment variables.
    # So it wil be checked for duplicates among `env`, `envList`, `fixedEnvs`
    # and other `secrets` / `configmaps` (with parseAsEnv set)
    # Optional
    parseAsEnv: true
    # Key/Value
    content:
      key: value
    # Or yaml scalar
    content:
      someKey: |
        configmap content
```

Examples:

```yaml
configmap:
  somename:
    enabled: true
    content:
      somekey: value
      otherkey: othervalue

configmap:
  somename:
    enabled: true
    content:
      somekey: value
      nginx.conf: |
        listen {{ .Values.service.main.ports.main.port }}
```
