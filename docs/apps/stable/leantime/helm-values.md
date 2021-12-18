# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.LEAN_DB_DATABASE | string | `"{{ .Values.mariadb.mariadbDatabase }}"` |  |
| env.LEAN_DB_USER | string | `"{{ .Values.mariadb.mariadbUsername }}"` |  |
| envValueFrom.LEAN_DB_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.LEAN_DB_HOST.secretKeyRef.name | string | `"mariadbcreds"` |  |
| envValueFrom.LEAN_DB_PASSWORD.secretKeyRef.key | string | `"mariadb-password"` |  |
| envValueFrom.LEAN_DB_PASSWORD.secretKeyRef.name | string | `"mariadbcreds"` |  |
| envValueFrom.LEAN_SESSION_PASSWORD.secretKeyRef.key | string | `"LEAN_SESSION_PASSWORD"` |  |
| envValueFrom.LEAN_SESSION_PASSWORD.secretKeyRef.name | string | `"leantime-secrets"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/leantime"` |  |
| image.tag | string | `"v2.1.8@sha256:c2a5025fb6019f0fea9d3d8fb37a52f6a91a7d72117a081b759a1d0762dea513"` |  |
| mariadb.enabled | bool | `true` |  |
| mariadb.existingSecret | string | `"mariadbcreds"` |  |
| mariadb.mariadbDatabase | string | `"leantime"` |  |
| mariadb.mariadbUsername | string | `"leantime"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10117` |  |
| service.main.ports.main.targetPort | int | `80` |  |

All Rights Reserved - The TrueCharts Project
