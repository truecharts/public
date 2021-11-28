# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env | object | See below | environment variables. See [image docs](https://github.com/xirixiz/dsmr-reader-docker#dsmr-reader---environment-variables) for more details. |
| env.TZ | string | `"UTC"` | Set the container timezone |
| envTpl.DJANGO_DATABASE_ENGINE | string | `"django.db.backends.postgresql"` |  |
| envTpl.DJANGO_DATABASE_NAME | string | `"{{ .Values.postgresql.postgresqlDatabase }}"` |  |
| envTpl.DJANGO_DATABASE_PORT | string | `"5432"` |  |
| envTpl.DJANGO_DATABASE_USER | string | `"{{ .Values.postgresql.postgresqlUsername }}"` |  |
| envTpl.DJANGO_TIME_ZONE | string | `"{{ .Values.env.TZ }}"` |  |
| envValueFrom.DJANGO_DATABASE_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.DJANGO_DATABASE_HOST.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.DJANGO_DATABASE_PASSWORD.secretKeyRef.key | string | `"postgresql-password"` |  |
| envValueFrom.DJANGO_DATABASE_PASSWORD.secretKeyRef.name | string | `"dbcreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"xirixiz/dsmr-reader-docker"` | image repository |
| image.tag | string | `"latest-2021.09.02-amd64@sha256:4858edb1ae63a20639a0ef9c51c7b2cf599686db5c582ead7b37b2a288122935"` | image tag |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| postgresql | object | See values.yaml | Enable and configure postgresql database subchart under this key. |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service | object | See values.yaml | Configures service settings for the chart. |

All Rights Reserved - The TrueCharts Project
