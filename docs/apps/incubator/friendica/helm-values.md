# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.MYSQL_DATABASE | string | `"friendica"` |  |
| env.MYSQL_USER | string | `"friendica"` |  |
| envValueFrom.MYSQL_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.MYSQL_HOST.secretKeyRef.name | string | `"mariadbcreds"` |  |
| envValueFrom.MYSQL_PASSWORD.secretKeyRef.key | string | `"mariadb-password"` |  |
| envValueFrom.MYSQL_PASSWORD.secretKeyRef.name | string | `"mariadbcreds"` |  |
| envValueFrom.REDIS_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.REDIS_HOST.secretKeyRef.name | string | `"rediscreds"` |  |
| envValueFrom.REDIS_PW.secretKeyRef.key | string | `"redis-password"` |  |
| envValueFrom.REDIS_PW.secretKeyRef.name | string | `"rediscreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"friendica"` |  |
| image.tag | string | `"2021.09@sha256:8fbc873ed9b6cbaf868428c49639282d4124e85676382d7f3f3515fbac7d26a7"` |  |
| mariadb.enabled | bool | `true` |  |
| mariadb.existingSecret | string | `"mariadbcreds"` |  |
| mariadb.mariadbDatabase | string | `"friendica"` |  |
| mariadb.mariadbUsername | string | `"friendica"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/var/www/html"` |  |
| persistence.varrun.enabled | bool | `true` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| redis.enabled | bool | `true` |  |
| redis.existingSecret | string | `"rediscreds"` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10058` |  |
| service.main.ports.main.targetPort | int | `80` |  |

All Rights Reserved - The TrueCharts Project
