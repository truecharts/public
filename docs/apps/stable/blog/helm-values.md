# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.BLOG_DB_CONNECTION | string | `"postgres"` |  |
| env.BLOG_DB_NAME | string | `"blog"` |  |
| env.BLOG_LANG | string | `"en"` |  |
| env.BLOG_NAME | string | `"Max Musermann"` |  |
| env.BLOG_POSTGRES_PORT | int | `5432` |  |
| env.BLOG_POSTGRES_USER | string | `"blog"` |  |
| env.BLOG_TITLE | string | `"Blog"` |  |
| envValueFrom.BLOG_POSTGRES_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.BLOG_POSTGRES_HOST.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.BLOG_POSTGRES_PASS.secretKeyRef.key | string | `"postgresql-password"` |  |
| envValueFrom.BLOG_POSTGRES_PASS.secretKeyRef.name | string | `"dbcreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/blog"` |  |
| image.tag | string | `"latest@sha256:8928fcf62413459ea8fc5236a1eea28d8a15404f3fc9d0bee154c552000a871b"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/var/www/html/data"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"blog"` |  |
| postgresql.postgresqlUsername | string | `"blog"` |  |
| secret.BLOG_NICK | string | `"username"` |  |
| secret.BLOG_PASS | string | `"password"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10111` |  |
| service.main.ports.main.targetPort | int | `80` |  |

All Rights Reserved - The TrueCharts Project
