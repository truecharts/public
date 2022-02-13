# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalContainers.nginx.image | string | `"{{ .Values.nginxImage.repository }}:{{ .Values.nginxImage.tag }}"` |  |
| additionalContainers.nginx.name | string | `"nginx"` |  |
| additionalContainers.nginx.ports[0].containerPort | int | `80` |  |
| additionalContainers.nginx.ports[0].name | string | `"main"` |  |
| additionalContainers.nginx.volumeMounts[0].mountPath | string | `"/etc/nginx/conf.d/linkace.conf"` |  |
| additionalContainers.nginx.volumeMounts[0].name | string | `"linkace-config"` |  |
| additionalContainers.nginx.volumeMounts[0].readOnly | bool | `true` |  |
| additionalContainers.nginx.volumeMounts[0].subPath | string | `"nginx-config"` |  |
| additionalContainers.nginx.volumeMounts[1].mountPath | string | `"/app"` |  |
| additionalContainers.nginx.volumeMounts[1].name | string | `"app"` |  |
| cronjob.annotations | object | `{}` |  |
| cronjob.failedJobsHistoryLimit | int | `5` |  |
| cronjob.schedule | string | `"* * * * *"` |  |
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
| image.tag | string | `"v1.9.1@sha256:d56fa76113e3e5ab0889a13bdfb463d12b71b3e2ec839a8ff6fa99ec036be862"` |  |
| initContainers.1-create-env-file.args[0] | string | `"if [ ! -f \"/app/.env\" ]; then\n  echo \"Preparing for initial installation\";\n  echo \"SETUP_COMPLETED=false\" > /app/.env;\nelse\n  echo \"Initial installation has already completed.\";\nfi;\n"` |  |
| initContainers.1-create-env-file.command[0] | string | `"/bin/sh"` |  |
| initContainers.1-create-env-file.command[1] | string | `"-c"` |  |
| initContainers.1-create-env-file.image | string | `"{{ .Values.image.repository }}:{{ .Values.image.tag }}"` |  |
| initContainers.1-create-env-file.volumeMounts[0].mountPath | string | `"/app"` |  |
| initContainers.1-create-env-file.volumeMounts[0].name | string | `"app"` |  |
| mariadb.enabled | bool | `true` |  |
| mariadb.existingSecret | string | `"mariadbcreds"` |  |
| mariadb.mariadbDatabase | string | `"linkace"` |  |
| mariadb.mariadbUsername | string | `"linkace"` |  |
| nginxImage.repository | string | `"tccr.io/truecharts/nginx"` |  |
| nginxImage.tag | string | `"v1.21.6@sha256:80d87a1d4d67749d2caaa64ee061a66a946b81942ac56f4780e36f8356cee371"` |  |
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
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10160` |  |
| service.main.ports.main.targetPort | int | `80` |  |

All Rights Reserved - The TrueCharts Project
