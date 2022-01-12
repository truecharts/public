# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env | object | See below. | See more environment variables in the tt-rss documentation https://git.tt-rss.org/fox/tt-rss/src/branch/master/classes/config.php#L9 |
| env.TTRSS_SELF_URL_PATH | string | `""` | External URL you use to connect to the RSS (the one you enter in your browser) |
| envValueFrom.TTRSS_DB_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.TTRSS_DB_HOST.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.TTRSS_DB_PASS.secretKeyRef.key | string | `"postgresql-password"` |  |
| envValueFrom.TTRSS_DB_PASS.secretKeyRef.name | string | `"dbcreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"tccr.io/truecharts/tt-rss"` | image repository |
| image.tag | string | `"v1.9090.0@sha256:1f0c5734f5c1526de668922f13556ad74f1c346b9deef6f255dd6867122e5e9b"` | image tag |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"tt-rss"` | Postgres database password |
| postgresql.postgresqlUsername | string | `"tt-rss"` | Postgres database user name |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service | object | See below. | Configure the services for the chart here. |

All Rights Reserved - The TrueCharts Project
