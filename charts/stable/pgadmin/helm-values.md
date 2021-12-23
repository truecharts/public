# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env | object | `{}` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/pgadmin4"` |  |
| image.tag | string | `"v6.3@sha256:13498140469d4efc97e0d746baaca4322344e6f295c584de072b7b22cd94d7c7"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/var/lib/pgadmin"` |  |
| podSecurityContext.fsGroup | int | `5050` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| secret.PGADMIN_DEFAULT_EMAIL | string | `"replace@this.now"` |  |
| secret.PGADMIN_DEFAULT_PASSWORD | string | `"changeme"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10024` |  |
| service.main.ports.main.targetPort | int | `80` |  |

All Rights Reserved - The TrueCharts Project
