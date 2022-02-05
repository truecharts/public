# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.AUTH_AUTHENTICATOR | string | `"Database"` |  |
| env.DB_BACKEND | string | `"PostgreSQL"` |  |
| env.DB_PGSQL_DATABASE | string | `"{{ .Values.postgresql.postgresqlDatabase }}"` |  |
| env.DB_PGSQL_PORT | int | `5432` |  |
| env.DB_PGSQL_USERNAME | string | `"{{ .Values.postgresql.postgresqlUsername }}"` |  |
| env.PUID | int | `568` |  |
| env.RUN_OPTS | string | `"--config-from-environment"` |  |
| envValueFrom.DB_PGSQL_HOSTNAME.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.DB_PGSQL_HOSTNAME.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.DB_PGSQL_PASSWORD.secretKeyRef.key | string | `"postgresql-password"` |  |
| envValueFrom.DB_PGSQL_PASSWORD.secretKeyRef.name | string | `"dbcreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/quassel-core"` |  |
| image.tag | string | `"v0.14.0"` |  |
| persistence.varrun.enabled | bool | `true` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| portal.enabled | bool | `false` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"quassel-core"` |  |
| postgresql.postgresqlUsername | string | `"quassel-core"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.ident.enabled | bool | `true` |  |
| service.ident.ports.ident.enabled | bool | `true` |  |
| service.ident.ports.ident.port | int | `10113` |  |
| service.ident.ports.ident.targetPort | int | `10113` |  |
| service.main.ports.main.port | int | `4242` |  |
| service.main.ports.main.targetPort | int | `4242` |  |

All Rights Reserved - The TrueCharts Project
