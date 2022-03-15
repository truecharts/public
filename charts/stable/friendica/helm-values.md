# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.FRIENDICA_ADMIN_MAIL | string | `"my@domain.com"` |  |
| env.FRIENDICA_CONFIG_DIR | string | `"/config"` |  |
| env.FRIENDICA_DATA_DIR | string | `"/data"` |  |
| env.FRIENDICA_TZ | string | `"{{ .Values.TZ }}"` |  |
| env.FRIENDICA_UPGRADE | bool | `false` |  |
| env.FRIENDICA_URL | string | `"http://localhost:{{ .Values.service.main.ports.main.port }}"` |  |
| env.MYSQL_DATABASE | string | `"{{ .Values.mariadb.mariadbDatabase }}"` |  |
| env.MYSQL_PORT | int | `3306` |  |
| env.MYSQL_USER | string | `"{{ .Values.mariadb.mariadbUsername }}"` |  |
| env.PHP_MEMORY_LIMIT | string | `"512M"` |  |
| env.PHP_UPLOAD_LIMIT | string | `"512M"` |  |
| env.REDIS_DB | int | `1` |  |
| env.REDIS_PORT | int | `6379` |  |
| envValueFrom.MYSQL_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.MYSQL_HOST.secretKeyRef.name | string | `"mariadbcreds"` |  |
| envValueFrom.MYSQL_PASSWORD.secretKeyRef.key | string | `"mariadb-password"` |  |
| envValueFrom.MYSQL_PASSWORD.secretKeyRef.name | string | `"mariadbcreds"` |  |
| envValueFrom.REDIS_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.REDIS_HOST.secretKeyRef.name | string | `"rediscreds"` |  |
| envValueFrom.REDIS_PW.secretKeyRef.key | string | `"redis-password"` |  |
| envValueFrom.REDIS_PW.secretKeyRef.name | string | `"rediscreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/friendica"` |  |
| image.tag | string | `"v2022.03@sha256:950adbe78875a453932f06fc893f7b87311582e32f7d6074170c44fb479f271d"` |  |
| mariadb.enabled | bool | `true` |  |
| mariadb.existingSecret | string | `"mariadbcreds"` |  |
| mariadb.mariadbDatabase | string | `"friendica"` |  |
| mariadb.mariadbUsername | string | `"friendica"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/data"` |  |
| persistence.varrun.enabled | bool | `true` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| probes.liveness.path | string | `"/friendica"` |  |
| probes.readiness.path | string | `"/friendica"` |  |
| probes.startup.path | string | `"/friendica"` |  |
| redis.enabled | bool | `true` |  |
| redis.existingSecret | string | `"rediscreds"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10058` |  |
| service.main.ports.main.targetPort | int | `80` |  |

All Rights Reserved - The TrueCharts Project
