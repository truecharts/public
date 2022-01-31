# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| credentials | object | `{}` |  |
| deployment.N8N_HOST | string | `"localhost"` |  |
| endpoints | object | `{}` |  |
| env.DB_POSTGRESDB_DATABASE | string | `"{{ .Values.postgresql.postgresqlDatabase }}"` |  |
| env.DB_POSTGRESDB_PORT | int | `5432` |  |
| env.DB_POSTGRESDB_USER | string | `"{{ .Values.postgresql.postgresqlUsername }}"` |  |
| env.DB_TYPE | string | `"postgresdb"` |  |
| env.GENERIC_TIMEZONE | string | `"{{ .Values.env.TZ }}"` |  |
| env.N8N_USER_FOLDER | string | `"/data"` |  |
| env.QUEUE_BULL_REDIS_PORT | int | `6379` |  |
| env.TZ | string | `"UTC"` |  |
| envFrom[0].configMapRef.name | string | `"n8n-config"` |  |
| envValueFrom.DB_POSTGRESDB_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.DB_POSTGRESDB_HOST.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.DB_POSTGRESDB_PASSWORD.secretKeyRef.key | string | `"postgresql-password"` |  |
| envValueFrom.DB_POSTGRESDB_PASSWORD.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.QUEUE_BULL_REDIS_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.QUEUE_BULL_REDIS_HOST.secretKeyRef.name | string | `"rediscreds"` |  |
| envValueFrom.QUEUE_BULL_REDIS_PASSWORD.secretKeyRef.key | string | `"redis-password"` |  |
| envValueFrom.QUEUE_BULL_REDIS_PASSWORD.secretKeyRef.name | string | `"rediscreds"` |  |
| executions | object | `{}` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/n8n"` |  |
| image.tag | string | `"v0.160.0@sha256:0bfb1ed711a55f6e93ade9d8550b60a1b829c2f23a7e248ff3b9a3ba611eef2b"` |  |
| logs.N8N_LOG_FILE_LOCATION | string | `"/data/logs"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/data"` |  |
| podSecurityContext.fsGroup | int | `1000` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"n8n"` |  |
| postgresql.postgresqlUsername | string | `"n8n"` |  |
| probes.liveness.path | string | `"/healthz"` |  |
| probes.readiness.path | string | `"/healthz"` |  |
| probes.startup.path | string | `"/healthz"` |  |
| redis.enabled | bool | `true` |  |
| redis.existingSecret | string | `"rediscreds"` |  |
| security | object | `{}` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `5678` |  |
| service.main.ports.main.targetPort | int | `5678` |  |
| workflows | object | `{}` |  |

All Rights Reserved - The TrueCharts Project
