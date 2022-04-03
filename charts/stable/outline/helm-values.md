# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.DEFAULT_LANGUAGE | string | `"en_US"` |  |
| env.ENABLE_UPDATES | bool | `true` |  |
| env.FORCE_HTTPS | bool | `false` |  |
| env.MAXIMUM_IMPORT_SIZE | int | `5120000` |  |
| env.PGSSLMODE | string | `"disable"` |  |
| env.PORT | string | `"{{ .Values.service.main.ports.main.port }}"` |  |
| env.SLACK_MESSAGE_ACTIONS | bool | `true` |  |
| env.URL | string | `"http://localhost:{{ .Values.service.main.ports.main.port }}"` |  |
| env.WEB_CONCURRENCY | int | `1` |  |
| envValueFrom.DATABASE_URL.secretKeyRef.key | string | `"url-noql"` |  |
| envValueFrom.DATABASE_URL.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.REDIS_URL.secretKeyRef.key | string | `"url"` |  |
| envValueFrom.REDIS_URL.secretKeyRef.name | string | `"rediscreds"` |  |
| envValueFrom.SECRET_KEY.secretKeyRef.key | string | `"SECRET_KEY"` |  |
| envValueFrom.SECRET_KEY.secretKeyRef.name | string | `"outline-secrets"` |  |
| envValueFrom.UTILS_SECRET.secretKeyRef.key | string | `"UTILS_SECRET"` |  |
| envValueFrom.UTILS_SECRET.secretKeyRef.name | string | `"outline-secrets"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/outline"` |  |
| image.tag | string | `"v0.62.0@sha256:9350ace6f88ae314620ab32e9990481d0e89895409b171fa0545b8ef9f7ede65"` |  |
| initContainers.1-migratedb.command[0] | string | `"sh"` |  |
| initContainers.1-migratedb.command[1] | string | `"-c"` |  |
| initContainers.1-migratedb.command[2] | string | `"yarn sequelize db:migrate --env=production-ssl-disabled"` |  |
| initContainers.1-migratedb.env[0].name | string | `"DATABASE_URL"` |  |
| initContainers.1-migratedb.env[0].valueFrom.secretKeyRef.key | string | `"url-noql"` |  |
| initContainers.1-migratedb.env[0].valueFrom.secretKeyRef.name | string | `"dbcreds"` |  |
| initContainers.1-migratedb.env[1].name | string | `"REDIS_URL"` |  |
| initContainers.1-migratedb.env[1].valueFrom.secretKeyRef.key | string | `"url"` |  |
| initContainers.1-migratedb.env[1].valueFrom.secretKeyRef.name | string | `"rediscreds"` |  |
| initContainers.1-migratedb.env[2].name | string | `"SECRET_KEY"` |  |
| initContainers.1-migratedb.env[2].valueFrom.secretKeyRef.key | string | `"SECRET_KEY"` |  |
| initContainers.1-migratedb.env[2].valueFrom.secretKeyRef.name | string | `"outline-secrets"` |  |
| initContainers.1-migratedb.env[3].name | string | `"UTILS_SECRET"` |  |
| initContainers.1-migratedb.env[3].valueFrom.secretKeyRef.key | string | `"UTILS_SECRET"` |  |
| initContainers.1-migratedb.env[3].valueFrom.secretKeyRef.name | string | `"outline-secrets"` |  |
| initContainers.1-migratedb.image | string | `"{{ .Values.image.repository }}:{{ .Values.image.tag }}"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"outline"` |  |
| postgresql.postgresqlUsername | string | `"outline"` |  |
| probes.liveness.path | string | `"/_health"` |  |
| probes.readiness.path | string | `"/_health"` |  |
| probes.startup.path | string | `"/_health"` |  |
| redis.enabled | bool | `true` |  |
| redis.existingSecret | string | `"rediscreds"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10196` |  |

All Rights Reserved - The TrueCharts Project
