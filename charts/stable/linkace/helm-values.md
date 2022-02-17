# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cronjob.annotations | object | `{}` |  |
| cronjob.failedJobsHistoryLimit | int | `5` |  |
| cronjob.schedule | string | `"*/15 * * * *"` |  |
| cronjob.successfulJobsHistoryLimit | int | `2` |  |
| env.APP_DEBUG | bool | `false` |  |
| env.APP_ENV | string | `"production"` |  |
| env.APP_NAME | string | `"LinkAce"` |  |
| env.APP_TIMEZONE | string | `"{{ .Values.env.TZ }}"` |  |
| env.APP_URL | string | `"http://localhost"` |  |
| env.BACKUP_DISK | string | `"s3"` |  |
| env.BACKUP_ENABLED | bool | `false` |  |
| env.BACKUP_MAX_SIZE | int | `512` |  |
| env.BACKUP_NOTIFICATION_EMAIL | string | `"your@email.com"` |  |
| env.CACHE_DRIVER | string | `"redis"` |  |
| env.DB_CONNECTION | string | `"mysql"` |  |
| env.DB_DATABASE | string | `"{{ .Values.mariadb.mariadbDatabase }}"` |  |
| env.DB_PORT | string | `"3306"` |  |
| env.DB_USERNAME | string | `"{{ .Values.mariadb.mariadbUsername }}"` |  |
| env.REDIS_PORT | string | `"6379"` |  |
| env.SESSION_DRIVER | string | `"redis"` |  |
| env.TZ | string | `"UTC"` |  |
| envValueFrom.APP_KEY.secretKeyRef.key | string | `"APP_KEY"` |  |
| envValueFrom.APP_KEY.secretKeyRef.name | string | `"linkace-secrets"` |  |
| envValueFrom.DB_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.DB_HOST.secretKeyRef.name | string | `"mariadbcreds"` |  |
| envValueFrom.DB_PASSWORD.secretKeyRef.key | string | `"mariadb-password"` |  |
| envValueFrom.DB_PASSWORD.secretKeyRef.name | string | `"mariadbcreds"` |  |
| envValueFrom.REDIS_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.REDIS_HOST.secretKeyRef.name | string | `"rediscreds"` |  |
| envValueFrom.REDIS_PASSWORD.secretKeyRef.key | string | `"redis-password"` |  |
| envValueFrom.REDIS_PASSWORD.secretKeyRef.name | string | `"rediscreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/linkace"` |  |
| image.tag | string | `"v1.9.1@sha256:88923f556900b0c6b79ea978e3692c690c0a6f9c28d048f2067a803095de1ef1"` |  |
| initContainers.1-copy-app.args[0] | string | `"echo \"Copying app...\"; cp -R /app/* /tmp/;\n"` |  |
| initContainers.1-copy-app.command[0] | string | `"/bin/sh"` |  |
| initContainers.1-copy-app.command[1] | string | `"-c"` |  |
| initContainers.1-copy-app.image | string | `"{{ .Values.image.repository }}:{{ .Values.image.tag }}"` |  |
| initContainers.1-copy-app.volumeMounts[0].mountPath | string | `"/tmp"` |  |
| initContainers.1-copy-app.volumeMounts[0].name | string | `"app"` |  |
| initContainers.2-create-env-file.args[0] | string | `"if [ ! -f \"/app/.env\" ]; then\n  echo \"Preparing for initial installation\";\n  echo \"SETUP_COMPLETED=false\" > /app/.env;\n  echo \"File .env created.\";\nelse\n  echo \"Initial installation has already completed.\";\nfi;\n"` |  |
| initContainers.2-create-env-file.command[0] | string | `"/bin/sh"` |  |
| initContainers.2-create-env-file.command[1] | string | `"-c"` |  |
| initContainers.2-create-env-file.image | string | `"{{ .Values.image.repository }}:{{ .Values.image.tag }}"` |  |
| initContainers.2-create-env-file.volumeMounts[0].mountPath | string | `"/app"` |  |
| initContainers.2-create-env-file.volumeMounts[0].name | string | `"app"` |  |
| initContainers.3-chmod.args[0] | string | `"echo \"CHMOD-ing files...\"; chmod -R 777 /app; chmod -R 777 /app/storage/logs; chmod -R 777 /app/storage/app/backups; echo \"CHMOD Complete\";\n"` |  |
| initContainers.3-chmod.command[0] | string | `"/bin/sh"` |  |
| initContainers.3-chmod.command[1] | string | `"-c"` |  |
| initContainers.3-chmod.image | string | `"{{ .Values.image.repository }}:{{ .Values.image.tag }}"` |  |
| initContainers.3-chmod.volumeMounts[0].mountPath | string | `"/app"` |  |
| initContainers.3-chmod.volumeMounts[0].name | string | `"app"` |  |
| initContainers.3-chmod.volumeMounts[1].mountPath | string | `"/app/storage/logs"` |  |
| initContainers.3-chmod.volumeMounts[1].name | string | `"logs"` |  |
| initContainers.3-chmod.volumeMounts[2].mountPath | string | `"/app/storage/app/backups"` |  |
| initContainers.3-chmod.volumeMounts[2].name | string | `"backups"` |  |
| mariadb.enabled | bool | `true` |  |
| mariadb.existingSecret | string | `"mariadbcreds"` |  |
| mariadb.mariadbDatabase | string | `"linkace"` |  |
| mariadb.mariadbUsername | string | `"linkace"` |  |
| persistence.app.enabled | bool | `true` |  |
| persistence.app.mountPath | string | `"/app"` |  |
| persistence.backups.enabled | bool | `true` |  |
| persistence.backups.mountPath | string | `"/app/storage/app/backups"` |  |
| persistence.logs.enabled | bool | `true` |  |
| persistence.logs.mountPath | string | `"/app/storage/logs"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| redis.enabled | bool | `true` |  |
| redis.existingSecret | string | `"rediscreds"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10160` |  |
| service.main.ports.main.targetPort | int | `80` |  |

All Rights Reserved - The TrueCharts Project
