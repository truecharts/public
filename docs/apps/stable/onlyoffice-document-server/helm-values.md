# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.DB_NAME | string | `"{{ .Values.postgresql.postgresqlDatabase }}"` |  |
| env.DB_PORT | int | `5432` |  |
| env.DB_TYPE | string | `"postgres"` |  |
| env.DB_USER | string | `"{{ .Values.postgresql.postgresqlUsername }}"` |  |
| env.JWT_ENABLED | bool | `true` |  |
| env.REDIS_SERVER_PORT | int | `6379` |  |
| env.WOPI_ENABLED | bool | `true` |  |
| envValueFrom.DB_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.DB_HOST.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.DB_PWD.secretKeyRef.key | string | `"postgresql-password"` |  |
| envValueFrom.DB_PWD.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.REDIS_SERVER_HOST.secretKeyRef.key | string | `"url"` |  |
| envValueFrom.REDIS_SERVER_HOST.secretKeyRef.name | string | `"rediscreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/onlyoffice-ds"` |  |
| image.tag | string | `"v7.0.0@sha256:957599910369a83815b4529d65e1eef41b8eac33eed98da6be33bd80f7464512"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"onlyoffice"` |  |
| postgresql.postgresqlUsername | string | `"onlyoffice"` |  |
| redis.enabled | bool | `true` |  |
| redis.existingSecret | string | `"rediscreds"` |  |
| secret.JWT_SECRET | string | `"randomgeneratedstring"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10043` |  |
| service.main.ports.main.targetPort | int | `80` |  |

All Rights Reserved - The TrueCharts Project
