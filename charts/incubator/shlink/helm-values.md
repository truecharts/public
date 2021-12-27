# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.DB_DRIVER | string | `"postgres"` |  |
| env.DB_NAME | string | `"{{ .Values.postgresql.postgresqlDatabase }}"` |  |
| env.DB_USER | string | `"{{ .Values.postgresql.postgresqlUsername }}"` |  |
| env.DEFAULT_DOMAIN | string | `""` |  |
| env.GEOLITE_LICENSE_KEY | string | `""` |  |
| env.IS_HTTPS_ENABLED | bool | `true` |  |
| env.PORT | int | `10153` |  |
| envValueFrom.DB_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.DB_HOST.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.DB_PASSWORD.secretKeyRef.key | string | `"postgresql-password"` |  |
| envValueFrom.DB_PASSWORD.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.REDIS_SERVERS.secretKeyRef.key | string | `"url"` |  |
| envValueFrom.REDIS_SERVERS.secretKeyRef.name | string | `"rediscreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/shlink"` |  |
| image.tag | string | `"v2.10.1@sha256:2abccbd1a150da840849f01789e4f824e35ee1136da7f5e56abaa86a290794ae"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"shlink"` |  |
| postgresql.postgresqlUsername | string | `"shlink"` |  |
| redis.enabled | bool | `true` |  |
| redis.existingSecret | string | `"rediscreds"` |  |
| redis.redisUsername | string | `"default"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10153` |  |
| service.main.ports.main.targetPort | int | `10153` |  |
| service.main.protocol | string | `"HTTPS"` |  |

All Rights Reserved - The TrueCharts Project
