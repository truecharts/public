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
| env.APP_DEBUG | bool | `false` |  |
| env.APP_ENV | string | `"production"` |  |
| env.APP_LOCALE | string | `"en"` |  |
| env.APP_TIMEZONE | string | `"{{ .Values.TZ }}"` |  |
| env.APP_URL | string | `"http://localhost:80"` |  |
| env.CACHE_DRIVER | string | `"redis"` |  |
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
| env.QUEUE_DRIVER | string | `"redis"` |  |
| env.REDIS_PORT | string | `"6379"` |  |
| env.SECURE_COOKIES | bool | `false` |  |
| env.SESSION_DRIVER | string | `"redis"` |  |
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
| persistence.logs.enabled | bool | `true` |  |
| persistence.logs.mountPath | string | `"/var/www/html/storage/logs"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| redis.enabled | bool | `true` |  |
| redis.existingSecret | string | `"rediscreds"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10120` |  |
| service.main.ports.main.targetPort | int | `80` |  |
| upgradeContainers.migratedb.command[0] | string | `"php"` |  |
| upgradeContainers.migratedb.command[1] | string | `"artisan"` |  |
| upgradeContainers.migratedb.command[2] | string | `"migrate"` |  |
| upgradeContainers.migratedb.env[0].name | string | `"APP_ENV"` |  |
| upgradeContainers.migratedb.env[0].value | string | `"production"` |  |
| upgradeContainers.migratedb.env[10].name | string | `"DB_PASSWORD"` |  |
| upgradeContainers.migratedb.env[10].valueFrom.secretKeyRef.key | string | `"mariadb-password"` |  |
| upgradeContainers.migratedb.env[10].valueFrom.secretKeyRef.name | string | `"mariadbcreds"` |  |
| upgradeContainers.migratedb.env[11].name | string | `"REDIS_HOST"` |  |
| upgradeContainers.migratedb.env[11].valueFrom.secretKeyRef.key | string | `"plainhost"` |  |
| upgradeContainers.migratedb.env[11].valueFrom.secretKeyRef.name | string | `"rediscreds"` |  |
| upgradeContainers.migratedb.env[12].name | string | `"REDIS_PASSWORD"` |  |
| upgradeContainers.migratedb.env[12].valueFrom.secretKeyRef.key | string | `"redis-password"` |  |
| upgradeContainers.migratedb.env[12].valueFrom.secretKeyRef.name | string | `"rediscreds"` |  |
| upgradeContainers.migratedb.env[13].name | string | `"APP_KEY"` |  |
| upgradeContainers.migratedb.env[13].valueFrom.secretKeyRef.key | string | `"APP_KEY"` |  |
| upgradeContainers.migratedb.env[13].valueFrom.secretKeyRef.name | string | `"snipeit-secrets"` |  |
| upgradeContainers.migratedb.env[1].name | string | `"REDIS_PORT"` |  |
| upgradeContainers.migratedb.env[1].value | string | `"6379"` |  |
| upgradeContainers.migratedb.env[2].name | string | `"SESSION_DRIVER"` |  |
| upgradeContainers.migratedb.env[2].value | string | `"redis"` |  |
| upgradeContainers.migratedb.env[3].name | string | `"QUEUE_DRIVER"` |  |
| upgradeContainers.migratedb.env[3].value | string | `"redis"` |  |
| upgradeContainers.migratedb.env[4].name | string | `"APP_ENV"` |  |
| upgradeContainers.migratedb.env[4].value | string | `"redis"` |  |
| upgradeContainers.migratedb.env[5].name | string | `"DB_CONNECTION"` |  |
| upgradeContainers.migratedb.env[5].value | string | `"mysql"` |  |
| upgradeContainers.migratedb.env[6].name | string | `"DB_PORT"` |  |
| upgradeContainers.migratedb.env[6].value | string | `"3306"` |  |
| upgradeContainers.migratedb.env[7].name | string | `"DB_USERNAME"` |  |
| upgradeContainers.migratedb.env[7].value | string | `"{{ .Values.mariadb.mariadbUsername }}"` |  |
| upgradeContainers.migratedb.env[8].name | string | `"DB_DATABASE"` |  |
| upgradeContainers.migratedb.env[8].value | string | `"{{ .Values.mariadb.mariadbDatabase }}"` |  |
| upgradeContainers.migratedb.env[9].name | string | `"DB_HOST"` |  |
| upgradeContainers.migratedb.env[9].valueFrom.secretKeyRef.key | string | `"plainhost"` |  |
| upgradeContainers.migratedb.env[9].valueFrom.secretKeyRef.name | string | `"mariadbcreds"` |  |
| upgradeContainers.migratedb.image | string | `"{{ .Values.image.repository }}:{{ .Values.image.tag }}"` |  |
| upgradeContainers.migratedb.volumeMounts[0].mountPath | string | `"/var/www/html/storage/logs"` |  |
| upgradeContainers.migratedb.volumeMounts[0].name | string | `"logs"` |  |

All Rights Reserved - The TrueCharts Project
