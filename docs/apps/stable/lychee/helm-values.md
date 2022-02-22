# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.APP_DEBUG | bool | `false` |  |
| env.APP_ENV | string | `"production"` |  |
| env.APP_NAME | string | `"Lychee"` |  |
| env.APP_URL | string | `"http://localhost"` |  |
| env.CACHE_DRIVER | string | `"redis"` |  |
| env.DB_CONNECTION | string | `"pgsql"` |  |
| env.DB_DATABASE | string | `"{{ .Values.postgresql.postgresqlDatabase }}"` |  |
| env.DB_PORT | string | `"5432"` |  |
| env.DB_USERNAME | string | `"{{ .Values.postgresql.postgresqlUsername }}"` |  |
| env.MIX_PUSHER_APP_CLUSTER | string | `"{{ .Values.env.PUSHER_APP_CLUSTER }}"` |  |
| env.MIX_PUSHER_APP_KEY | string | `"{{ .Values.env.PUSHER_APP_KEY }}"` |  |
| env.PHP_TZ | string | `"{{ .Values.env.TZ }}"` |  |
| env.PUID | int | `568` |  |
| env.PUSHER_APP_CLUSTER | string | `""` |  |
| env.PUSHER_APP_KEY | string | `""` |  |
| env.REDIS_PORT | string | `"6379"` |  |
| env.SECURITY_HEADER_HSTS_ENABLE | bool | `false` |  |
| env.SESSION_DRIVER | string | `"redis"` |  |
| env.TIMEZONE | string | `"{{ .Values.env.TZ }}"` |  |
| env.TZ | string | `"UTC"` |  |
| envValueFrom.APP_KEY.secretKeyRef.key | string | `"APP_KEY"` |  |
| envValueFrom.APP_KEY.secretKeyRef.name | string | `"lychee-secrets"` |  |
| envValueFrom.DB_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.DB_HOST.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.DB_PASSWORD.secretKeyRef.key | string | `"postgresql-password"` |  |
| envValueFrom.DB_PASSWORD.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.REDIS_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.REDIS_HOST.secretKeyRef.name | string | `"rediscreds"` |  |
| envValueFrom.REDIS_PASSWORD.secretKeyRef.key | string | `"redis-password"` |  |
| envValueFrom.REDIS_PASSWORD.secretKeyRef.name | string | `"rediscreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/lychee-laravel"` |  |
| image.tag | string | `"v4.4.0@sha256:f241d62fa4b2f97577d494c319eaab9e5b127e4a67af58ea90861ce56ff0fb88"` |  |
| persistence.conf.enabled | bool | `true` |  |
| persistence.conf.mountPath | string | `"/conf"` |  |
| persistence.sym.enabled | bool | `true` |  |
| persistence.sym.mountPath | string | `"/sym"` |  |
| persistence.uploads.enabled | bool | `true` |  |
| persistence.uploads.mountPath | string | `"/uploads"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"lychee"` |  |
| postgresql.postgresqlUsername | string | `"lychee"` |  |
| redis.enabled | bool | `true` |  |
| redis.existingSecret | string | `"rediscreds"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10017` |  |
| service.main.ports.main.targetPort | int | `80` |  |

All Rights Reserved - The TrueCharts Project
