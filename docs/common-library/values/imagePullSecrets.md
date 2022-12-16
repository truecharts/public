# Image Pull Secrets

## key: imagePullCredentials

- Type: `list`
- Default: `[]`
- Helm Template: ❌

Every entry here will create a secret of type `kubernetes.io/dockerconfigjson`

And then it will inject it's name in Deployment at `spec.template.spec.imagePullSecret`

All fields are required.

Examples:

```yaml
imagePullCredentials:
  - name: myPrivRegistry
    enabled: true
    contents:
      registry: quay.io
      username: someone
      password: password
      email: someone@host.com
```
