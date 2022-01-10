# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.APP_BASE_URL | string | `"http://localhost:22300"` |  |
| env.APP_PORT | int | `22300` |  |
| env.DB_CLIENT | string | `"pg"` |  |
| env.POSTGRES_DATABASE | string | `"{{ .Values.postgresql.postgresqlDatabase }}"` |  |
| env.POSTGRES_PORT | string | `"5432"` |  |
| env.POSTGRES_USER | string | `"{{ .Values.postgresql.postgresqlUsername }}"` |  |
| env.TZ | string | `"UTC"` |  |
| envValueFrom.POSTGRES_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.POSTGRES_HOST.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.POSTGRES_PASSWORD.secretKeyRef.key | string | `"postgresql-password"` |  |
| envValueFrom.POSTGRES_PASSWORD.secretKeyRef.name | string | `"dbcreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/joplin-server"` |  |
| image.tag | string | `"v2.5.1@sha256:a285ff0cf05f534efd28c6652925b57a9774ba41923d15536b873fbbdbabcd2b"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"joplin"` |  |
| postgresql.postgresqlUsername | string | `"joplin"` |  |
| probes.liveness.path | string | `"/api/ping"` |  |
| probes.readiness.path | string | `"/api/ping"` |  |
| probes.startup.path | string | `"/api/ping"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `22300` |  |
| service.main.ports.main.targetPort | int | `22300` |  |

All Rights Reserved - The TrueCharts Project
