# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.DATABASE_CLIENT | string | `"postgres"` |  |
| env.DATABASE_NAME | string | `"{{ .Values.postgresql.postgresqlDatabase }}"` |  |
| env.DATABASE_PORT | int | `5432` |  |
| env.DATABASE_USERNAME | string | `"{{ .Values.postgresql.postgresqlUsername }}"` |  |
| env.EXTRA_ARGS | string | `""` |  |
| env.NODE_ENV | string | `"production"` |  |
| env.TZ | string | `"UTC"` |  |
| envValueFrom.DATABASE_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.DATABASE_HOST.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.DATABASE_PASSWORD.secretKeyRef.key | string | `"postgresql-password"` |  |
| envValueFrom.DATABASE_PASSWORD.secretKeyRef.name | string | `"dbcreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/strapi"` |  |
| image.tag | string | `"v3.6.8@sha256:25d345a1787c5be5ef1771b069e0eeaeba5b244a62870cc2b9d5acba0eaedd89"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/srv/app"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"strapi"` |  |
| postgresql.postgresqlUsername | string | `"strapi"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `1337` |  |
| service.main.ports.main.targetPort | int | `1337` |  |

All Rights Reserved - The TrueCharts Project
