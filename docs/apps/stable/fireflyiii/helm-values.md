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
| cronjob.schedule | string | `"0 3 * * *"` |  |
| cronjob.successfulJobsHistoryLimit | int | `2` |  |
| env.CACHE_DRIVER | string | `"redis"` |  |
| env.DB_CONNECTION | string | `"pgsql"` |  |
| env.DB_DATABASE | string | `"firefly"` |  |
| env.DB_PORT | int | `5432` |  |
| env.DB_USERNAME | string | `"firefly"` |  |
| env.REDIS_CACHE_DB | string | `"1"` |  |
| env.REDIS_DB | string | `"0"` |  |
| env.REDIS_PORT | int | `6379` |  |
| env.REDIS_SCHEME | string | `"tcp"` |  |
| env.SESSION_DRIVER | string | `"redis"` |  |
| envValueFrom.APP_KEY.secretKeyRef.key | string | `"APP_KEY"` |  |
| envValueFrom.APP_KEY.secretKeyRef.name | string | `"fireflyiii-secrets"` |  |
| envValueFrom.DB_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.DB_HOST.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.DB_PASSWORD.secretKeyRef.key | string | `"postgresql-password"` |  |
| envValueFrom.DB_PASSWORD.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.REDIS_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.REDIS_HOST.secretKeyRef.name | string | `"rediscreds"` |  |
| envValueFrom.REDIS_PASSWORD.secretKeyRef.key | string | `"redis-password"` |  |
| envValueFrom.REDIS_PASSWORD.secretKeyRef.name | string | `"rediscreds"` |  |
| envValueFrom.STATIC_CRON_TOKEN.secretKeyRef.key | string | `"STATIC_CRON_TOKEN"` |  |
| envValueFrom.STATIC_CRON_TOKEN.secretKeyRef.name | string | `"fireflyiii-secrets"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/fireflyiii-core"` |  |
| image.tag | string | `"v5.6.5@sha256:fe75d9df1daf62871eccb976643ff393ed1bd402b61baa0f17f7ad5289697264"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/var/www/html/storage/upload"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"firefly"` |  |
| postgresql.postgresqlUsername | string | `"firefly"` |  |
| probes.liveness.path | string | `"/login"` |  |
| probes.readiness.path | string | `"/login"` |  |
| probes.startup.path | string | `"/login"` |  |
| redis.enabled | bool | `true` |  |
| redis.existingSecret | string | `"rediscreds"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10082` |  |
| service.main.ports.main.targetPort | int | `8080` |  |

All Rights Reserved - The TrueCharts Project
