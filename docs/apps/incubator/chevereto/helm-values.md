# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.CHEVERETO_DB_DRIVER | string | `"mysql"` |  |
| env.CHEVERETO_DB_NAME | string | `"{{ .Values.mariadb.mariadbUsername }}"` |  |
| env.CHEVERETO_DB_PORT | string | `"3306"` |  |
| env.CHEVERETO_DB_USER | string | `"{{ .Values.mariadb.mariadbDatabase }}"` |  |
| env.CHEVERETO_DISABLE_UPDATE_CLI | bool | `true` |  |
| env.CHEVERETO_DISABLE_UPDATE_HTTP | bool | `true` |  |
| env.CHEVERETO_HTTPS | bool | `false` |  |
| env.CHEVERETO_SESSION_SAVE_HANDLER | string | `"redis"` |  |
| env.CHEVERETO_TAG | string | `"free"` |  |
| envValueFrom.CHEVERETO_DB_HOST.secretKeyRef.key | string | `"plainporthost"` |  |
| envValueFrom.CHEVERETO_DB_HOST.secretKeyRef.name | string | `"mariadbcreds"` |  |
| envValueFrom.CHEVERETO_DB_PASS.secretKeyRef.key | string | `"mariadb-password"` |  |
| envValueFrom.CHEVERETO_DB_PASS.secretKeyRef.name | string | `"mariadbcreds"` |  |
| envValueFrom.CHEVERETO_SESSION_SAVE_PATH.secretKeyRef.key | string | `"url"` |  |
| envValueFrom.CHEVERETO_SESSION_SAVE_PATH.secretKeyRef.name | string | `"rediscreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/chevereto"` |  |
| image.tag | string | `"v1.6.2@sha256:6f9c2d7a86d97d4de70995ac258441a07806a328d7ba7b0ae65a965d590dae43"` |  |
| mariadb.enabled | bool | `true` |  |
| mariadb.existingSecret | string | `"mariadbcreds"` |  |
| mariadb.mariadbDatabase | string | `"chevereto"` |  |
| mariadb.mariadbUsername | string | `"chevereto"` |  |
| persistence.content.enabled | bool | `true` |  |
| persistence.content.mountPath | string | `"/var/www/html/content/"` |  |
| persistence.storage.enabled | bool | `true` |  |
| persistence.storage.mountPath | string | `"/var/www/html/images/"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| redis.enabled | bool | `true` |  |
| redis.existingSecret | string | `"rediscreds"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10197` |  |
| service.main.ports.main.targetPort | int | `80` |  |

All Rights Reserved - The TrueCharts Project
