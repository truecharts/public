# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.DB_CONNECTION | string | `"pgsql"` |  |
| env.DB_DATABASE | string | `"{{ .Values.postgresql.postgresqlDatabase }}"` |  |
| env.DB_USERNAME | string | `"{{ .Values.postgresql.postgresqlUsername }}"` |  |
| env.FORCE_HTTPS | bool | `false` |  |
| env.LASTFM_API_KEY | string | `""` |  |
| env.LASTFM_API_SECRET | string | `""` |  |
| env.MEMORY_LIMIT | int | `2048` |  |
| envValueFrom.APP_KEY.secretKeyRef.key | string | `"APP_KEY"` |  |
| envValueFrom.APP_KEY.secretKeyRef.name | string | `"koel-secrets"` |  |
| envValueFrom.DB_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.DB_HOST.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.DB_PASSWORD.secretKeyRef.key | string | `"postgresql-password"` |  |
| envValueFrom.DB_PASSWORD.secretKeyRef.name | string | `"dbcreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"hyzual/koel"` |  |
| image.tag | string | `"latest@sha256:fa4bafbe3ae869f153bdc3bc87db739f300bef6cc94e398d7efa587a443f86fa"` |  |
| persistence.covers.enabled | bool | `true` |  |
| persistence.covers.mountPath | string | `"/var/www/html/public/img/covers"` |  |
| persistence.music.enabled | bool | `true` |  |
| persistence.music.mountPath | string | `"/music"` |  |
| persistence.searchindex.enabled | bool | `true` |  |
| persistence.searchindex.mountPath | string | `"/var/www/html/storage/search-indexes"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"koel"` |  |
| postgresql.postgresqlUsername | string | `"koel"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10185` |  |
| service.main.ports.main.targetPort | int | `80` |  |

All Rights Reserved - The TrueCharts Project
