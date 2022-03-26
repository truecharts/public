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
| env.DB_PORT | string | `"5432"` |  |
| env.DB_TYPE | string | `"postgres"` |  |
| env.DB_USER | string | `"{{ .Values.postgresql.postgresqlUsername }}"` |  |
| envValueFrom.DB_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.DB_HOST.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.DB_PASS.secretKeyRef.key | string | `"postgresql-password"` |  |
| envValueFrom.DB_PASS.secretKeyRef.name | string | `"dbcreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/wikijs"` |  |
| image.tag | string | `"v2.5.276@sha256:5caedcd71492d09be8272d754eb93c7b3eabfc8db30cf71ff00b2fd809549954"` |  |
| persistence.wikicache.enabled | bool | `true` |  |
| persistence.wikicache.mountPath | string | `"/wiki/data/"` |  |
| persistence.wikicache.type | string | `"emptyDir"` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"wikijs"` |  |
| postgresql.postgresqlUsername | string | `"wikijs"` |  |
| probes.liveness.path | string | `"/healthz"` |  |
| probes.readiness.path | string | `"/healthz"` |  |
| probes.startup.path | string | `"/healthz"` |  |
| service.main.ports.main.port | int | `10045` |  |
| service.main.ports.main.targetPort | int | `3000` |  |

All Rights Reserved - The TrueCharts Project
