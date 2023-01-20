# Image Pull Secrets

## key: imagePullCredentials

Info:

- Type: `list`
- Default: `[]`
- Helm Template: ❌

Can be defined in:

- `.Values`.imagePullCredentials

---

Every entry here will create a secret of type `kubernetes.io/dockerconfigjson`

And then it will inject it's name at `spec.template.spec.imagePullSecret`
in the Pod of Deployment/StatefulSet/DaemonSet/CronJob/Job

All fields are **required**.

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
