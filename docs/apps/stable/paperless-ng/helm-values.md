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
| env.PAPERLESS_DATA_DIR | string | `"/data/"` |  |
| env.PAPERLESS_DBNAME | string | `"{{ .Values.postgresql.postgresqlDatabase }}"` |  |
| env.PAPERLESS_DBPORT | string | `"5432"` |  |
| env.PAPERLESS_DBUSER | string | `"{{ .Values.postgresql.postgresqlUsername }}"` |  |
| env.PAPERLESS_MEDIA_ROOT | string | `"/media/"` |  |
| env.PAPERLESS_STATICDIR | string | `"/static/"` |  |
| env.PAPERLESS_TIME_ZONE | string | `"{{ .Values.env.TZ }}"` |  |
| env.PUID | int | `568` |  |
| env.USERMAP_GID | string | `"{{ .Values.podSecurityContext.fsGroup }}"` |  |
| env.USERMAP_UID | string | `"{{ .Values.env.PUID }}"` |  |
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
| image.tag | string | `"v1.5.0@sha256:94b00a3fb7e829a6a86d8bfd01abd558d20286976501716b6148a504e6544e3a"` |  |
| persistence.consume.enabled | bool | `true` |  |
| persistence.consume.mountPath | string | `"/consume"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/data"` |  |
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
| redis.redisUsername | string | `"default"` |  |
| secret.PAPERLESS_ADMIN_MAIL | string | `"admin@admin.com"` |  |
| secret.PAPERLESS_ADMIN_PASSWORD | string | `"admin"` |  |
| secret.PAPERLESS_ADMIN_USER | string | `"admin"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10140` |  |
| service.main.ports.main.targetPort | int | `8000` |  |

All Rights Reserved - The TrueCharts Project
