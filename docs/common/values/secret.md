# Secret

## key: secret

Info:

- Type: `dict`
- Default: `{}`
- Helm Template:
  - secretType: ❌
  - content.KEY: ❌
  - content.KEY.value: ✅

Can be defined in:

- `.Values`.secret

---
Creates a secret based on the `content`

Options:

```yaml
secret:
  somename:
    enabled: true
    # Optional
    labels: {}
    # Optional
    annotations: {}
    # Optional
    nameOverride: ""
    # Optional - Defaults to Opaque
    secretType: ""
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
secret:
  somename:
    enabled: true
    content:
      somekey: value
      otherkey: othervalue

secret:
  somename:
    enabled: true
    content:
      somekey: value
      nginx.conf: |
        listen {{ .Values.service.main.ports.main.port }}
```
