# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.FR_DB_NAME | string | `"filerun"` |  |
| env.FR_DB_PORT | string | `"3306"` |  |
| env.FR_DB_USER | string | `"filerun"` |  |
| envValueFrom.FR_DB_HOST.secretKeyRef.key | string | `"plainporthost"` |  |
| envValueFrom.FR_DB_HOST.secretKeyRef.name | string | `"mariadbcreds"` |  |
| envValueFrom.FR_DB_PASS.secretKeyRef.key | string | `"mariadb-password"` |  |
| envValueFrom.FR_DB_PASS.secretKeyRef.name | string | `"mariadbcreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/filerun"` |  |
| image.tag | string | `"latest@sha256:cc7b8c11610fd5cde28301fa4f68b7d9609e61613fbfbc277c0491ad584a0256"` |  |
| mariadb.enabled | bool | `true` |  |
| mariadb.existingSecret | string | `"mariadbcreds"` |  |
| mariadb.mariadbDatabase | string | `"filerun"` |  |
| mariadb.mariadbUsername | string | `"filerun"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/var/www/html"` |  |
| persistence.userfile.enabled | bool | `true` |  |
| persistence.userfile.mountPath | string | `"/user-files"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10199` |  |
| service.main.ports.main.targetPort | int | `80` |  |

All Rights Reserved - The TrueCharts Project
