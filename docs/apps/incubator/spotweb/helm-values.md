# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.DB_DATABASE | string | `"{{ .Values.postgresql.postgresqlDatabase }}"` |  |
| env.DB_ENGINE | string | `"pdo_pgsql"` |  |
| env.DB_PORT | string | `"5432"` |  |
| env.DB_SCHEMA | string | `"public"` |  |
| env.DB_USER | string | `"{{ .Values.postgresql.postgresqlUsername }}"` |  |
| env.SPOTWEB_FIRSTNAME | string | `"demo"` |  |
| env.SPOTWEB_LASTNAME | string | `"spotweb"` |  |
| env.SPOTWEB_MAIL | string | `"demo@spotweb.com"` |  |
| env.SPOTWEB_RETRIEVE | string | `"15min"` |  |
| env.SPOTWEB_SYSTEMTYPE | string | `"single"` |  |
| env.TZ | string | `"UTC"` |  |
| envValueFrom.DB_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.DB_HOST.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.DB_PASSWORD.secretKeyRef.key | string | `"postgresql-password"` |  |
| envValueFrom.DB_PASSWORD.secretKeyRef.name | string | `"dbcreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/spotweb"` |  |
| image.tag | string | `"v1.5.1@sha256:75fe32474598f89d7b0741c3b96eeebd6b346da5219e1eabf8ed9e769f7a98f5"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"spotweb"` |  |
| postgresql.postgresqlUsername | string | `"spotweb"` |  |
| secret.SPOTWEB_PASSWORD | string | `"changeme"` |  |
| secret.SPOTWEB_USERNAME | string | `"myawesomeuser"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10050` |  |
| service.main.ports.main.targetPort | int | `80` |  |

All Rights Reserved - The TrueCharts Project
