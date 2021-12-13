# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.LEAN_DB_DATABASE | string | `"leantime"` |  |
| env.LEAN_DB_USER | string | `"leantime"` |  |
| envValueFrom.LEAN_DB_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.LEAN_DB_HOST.secretKeyRef.name | string | `"mariadbcreds"` |  |
| envValueFrom.LEAN_DB_PASSWORD.secretKeyRef.key | string | `"mariadb-password"` |  |
| envValueFrom.LEAN_DB_PASSWORD.secretKeyRef.name | string | `"mariadbcreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/leantime"` |  |
| image.tag | string | `"v2.1.7-ls6@sha256:09f51955b47e8bf7cf8c95b7fa4e023ce2fae4aa15ef42db1568b4c23830b5a6"` |  |
| mariadb.enabled | bool | `true` |  |
| mariadb.existingSecret | string | `"mariadbcreds"` |  |
| mariadb.mariadbDatabase | string | `"leantime"` |  |
| mariadb.mariadbUsername | string | `"leantime"` |  |
| persistence.sessions.enabled | bool | `true` |  |
| persistence.sessions.mountPath | string | `"/sessions"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.extra.enabled | bool | `true` |  |
| service.extra.ports.extra.enabled | bool | `true` |  |
| service.extra.ports.extra.port | int | `10118` |  |
| service.extra.ports.extra.protocol | string | `"UDP"` |  |
| service.extra.ports.extra.targetPort | int | `9000` |  |
| service.main.ports.main.port | int | `10117` |  |
| service.main.ports.main.targetPort | int | `80` |  |

All Rights Reserved - The TrueCharts Project
