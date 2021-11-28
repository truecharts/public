# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| database.type | string | `"postgresql"` |  |
| database.wal | bool | `true` |  |
| env | object | `{}` |  |
| envFrom[0].configMapRef.name | string | `"vaultwardenconfig"` |  |
| envFrom[1].secretRef.name | string | `"vaultwardensecret"` |  |
| envTpl.DOMAIN | string | `"https://{{ if .Values.ingress }}{{ if .Values.ingress.main.enabled }}{{ ( index .Values.ingress.main.hosts 0 ).host }}{{ else }}placeholder.com{{ end }}{{ else }}placeholder.com{{ end }}"` |  |
| envValueFrom.DATABASE_URL.secretKeyRef.key | string | `"url"` |  |
| envValueFrom.DATABASE_URL.secretKeyRef.name | string | `"dbcreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ghcr.io/truecharts/vaultwarden"` |  |
| image.tag | string | `"v1.23.0@sha256:1e65dd23569e566576c3c80de76f711e0b9fc5e29a39d45f49f0a44d1282d869"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/data"` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"vaultwarden"` |  |
| postgresql.postgresqlUsername | string | `"vaultwarden"` |  |
| service.main.ports.main.port | int | `8080` |  |
| service.main.ports.main.targetPort | int | `8080` |  |
| service.ws.enabled | bool | `true` |  |
| service.ws.ports.ws.enabled | bool | `true` |  |
| service.ws.ports.ws.port | int | `3012` |  |
| service.ws.ports.ws.targetPort | int | `3012` |  |
| vaultwarden.admin.disableAdminToken | bool | `false` |  |
| vaultwarden.admin.enabled | bool | `false` |  |
| vaultwarden.allowInvitation | bool | `true` |  |
| vaultwarden.allowSignups | bool | `true` |  |
| vaultwarden.enableWebVault | bool | `true` |  |
| vaultwarden.enableWebsockets | bool | `true` |  |
| vaultwarden.icons.disableDownload | bool | `false` |  |
| vaultwarden.log.file | string | `""` |  |
| vaultwarden.log.level | string | `"trace"` |  |
| vaultwarden.orgCreationUsers | string | `"all"` |  |
| vaultwarden.requireEmail | bool | `false` |  |
| vaultwarden.showPasswordHint | bool | `true` |  |
| vaultwarden.smtp.enabled | bool | `false` |  |
| vaultwarden.smtp.from | string | `""` |  |
| vaultwarden.smtp.host | string | `""` |  |
| vaultwarden.verifySignup | bool | `false` |  |
| vaultwarden.yubico.enabled | bool | `false` |  |

All Rights Reserved - The TrueCharts Project
