# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.API_TOKEN_EXPIRATION_YEARS | int | `40` |  |
| env.APP_ENV | string | `"production"` |  |
| env.APP_LOCALE | string | `"en"` |  |
| env.APP_TIMEZONE | string | `"{{ .Values.TZ }}"` |  |
| env.APP_URL | string | `"http://localhost:80"` |  |
| env.COOKIE_NAME | string | `"snipeit_session"` |  |
| env.DB_CONNECTION | string | `"mysql"` |  |
| env.DB_DATABASE | string | `"{{ .Values.mariadb.mariadbDatabase }}"` |  |
| env.DB_PORT | string | `"3306"` |  |
| env.DB_USERNAME | string | `"{{ .Values.mariadb.mariadbUsername }}"` |  |
| env.ENCRYPT | bool | `false` |  |
| env.EXPIRE_ON_CLOSE | bool | `false` |  |
| env.FILESYSTEM_DISK | string | `"local"` |  |
| env.IMAGE_LIB | string | `"gd"` |  |
| env.LOGIN_LOCKOUT_DURATION | int | `60` |  |
| env.LOGIN_MAX_ATTEMPTS | int | `5` |  |
| env.MAX_RESULTS | int | `500` |  |
| env.REDIS_PORT | string | `"6379"` |  |
| env.SECURE_COOKIES | bool | `false` |  |
| env.SESSION_LIFETIME | int | `30` |  |
| envValueFrom.APP_KEY.secretKeyRef.key | string | `"APP_KEY"` |  |
| envValueFrom.APP_KEY.secretKeyRef.name | string | `"snipeit-secrets"` |  |
| envValueFrom.DB_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.DB_HOST.secretKeyRef.name | string | `"mariadbcreds"` |  |
| envValueFrom.DB_PASSWORD.secretKeyRef.key | string | `"mariadb-password"` |  |
| envValueFrom.DB_PASSWORD.secretKeyRef.name | string | `"mariadbcreds"` |  |
| envValueFrom.REDIS_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.REDIS_HOST.secretKeyRef.name | string | `"rediscreds"` |  |
| envValueFrom.REDIS_PASSWORD.secretKeyRef.key | string | `"redis-password"` |  |
| envValueFrom.REDIS_PASSWORD.secretKeyRef.name | string | `"rediscreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/snipe-it"` |  |
| image.tag | string | `"v5.4.1@sha256:392cd5a87a094675702b2f81a84213624851d2c4adec2dbad207a91f7d39d3d4"` |  |
| mariadb.enabled | bool | `true` |  |
| mariadb.existingSecret | string | `"mariadbcreds"` |  |
| mariadb.mariadbDatabase | string | `"snipe-it"` |  |
| mariadb.mariadbUsername | string | `"snipe-it"` |  |
| persistence.backups.enabled | bool | `true` |  |
| persistence.backups.mountPath | string | `"/var/lib/snipeit/dumps"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/var/lib/snipeit/data"` |  |
| persistence.logs.enabled | bool | `true` |  |
| persistence.logs.mountPath | string | `"/var/www/html/storage/logs"` |  |
| podSecurityContext.fsGroup | int | `50` |  |
| podSecurityContext.runAsGroup | int | `1000` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| redis.enabled | bool | `true` |  |
| redis.existingSecret | string | `"rediscreds"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10120` |  |
| service.main.ports.main.targetPort | int | `80` |  |

All Rights Reserved - The TrueCharts Project
