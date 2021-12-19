# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.PAPERLESS_CONSUMPTION_DIR | string | `"/consume/"` |  |
| env.PAPERLESS_DATA_DIR | string | `"/config/"` |  |
| env.PAPERLESS_MEDIA_ROOT | string | `"/media/"` |  |
| env.PAPERLESS_STATICDIR | string | `"/static/"` |  |
| env.PUID | int | `568` |  |
| envTpl.PAPERLESS_DBNAME | string | `"{{ .Values.postgresql.postgresqlDatabase }}"` |  |
| envTpl.PAPERLESS_DBPORT | string | `"5432"` |  |
| envTpl.PAPERLESS_DBUSER | string | `"{{ .Values.postgresql.postgresqlUsername }}"` |  |
| envTpl.PAPERLESS_TIME_ZONE | string | `"{{ .Values.env.TZ }}"` |  |
| envTpl.USERMAP_GID | string | `"{{ .Values.env.PGID }}"` |  |
| envTpl.USERMAP_UID | string | `"{{ .Values.env.PUID }}"` |  |
| envValueFrom.PAPERLESS_DBHOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.PAPERLESS_DBHOST.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.PAPERLESS_DBPASS.secretKeyRef.key | string | `"postgresql-password"` |  |
| envValueFrom.PAPERLESS_DBPASS.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.PAPERLESS_REDIS.secretKeyRef.key | string | `"url"` |  |
| envValueFrom.PAPERLESS_REDIS.secretKeyRef.name | string | `"rediscreds"` |  |
| envValueFrom.PAPERLESS_SECRET_KEY.secretKeyRef.key | string | `"PAPERLESS_SECRET_KEY"` |  |
| envValueFrom.PAPERLESS_SECRET_KEY.secretKeyRef.name | string | `"paperlessng-secrets"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/paperless-ng"` |  |
| image.tag | string | `"v1.5.0@sha256:aef66d1bd436e237d0f6eb87dc5c0efe437b9ebcb4f20383dc36c165308df755"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| persistence.consume.enabled | bool | `true` |  |
| persistence.consume.mountPath | string | `"/consume"` |  |
| persistence.media.enabled | bool | `true` |  |
| persistence.media.mountPath | string | `"/media"` |  |
| persistence.static.enabled | bool | `true` |  |
| persistence.static.mountPath | string | `"/static"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"paperless-ng"` |  |
| postgresql.postgresqlUsername | string | `"paperless-ng"` |  |
| redis.enabled | bool | `true` |  |
| redis.existingSecret | string | `"rediscreds"` |  |
| redis.redisUsername | string | `"paperless-ng"` |  |
| secret.PAPERLESS_ADMIN_MAIL | string | `"admin@admin.com"` |  |
| secret.PAPERLESS_ADMIN_PASSWORD | string | `"admin"` |  |
| secret.PAPERLESS_ADMIN_USER | string | `"admin"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10140` |  |
| service.main.ports.main.targetPort | int | `8000` |  |

All Rights Reserved - The TrueCharts Project
