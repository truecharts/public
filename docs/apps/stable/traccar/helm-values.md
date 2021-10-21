# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env | object | See below | environment variables. See more environment variables in the [traccar documentation](https://www.traccar.org/configuration-file/) |
| env.CONFIG_USE_ENVIRONMENT_VARIABLES | bool | `true` | Set application to read environment variables |
| env.LOGGER_CONSOLE | bool | `true` | Set application to log to stdout |
| envTpl.DATABASE_DRIVER | string | `"org.postgresql.Driver"` |  |
| envTpl.DATABASE_USER | string | `"{{ .Values.postgresql.postgresqlUsername }}"` |  |
| envValueFrom.DATABASE_PASSWORD.secretKeyRef.key | string | `"postgresql-password"` |  |
| envValueFrom.DATABASE_PASSWORD.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.DATABASE_URL.secretKeyRef.key | string | `"jdbc"` |  |
| envValueFrom.DATABASE_URL.secretKeyRef.name | string | `"dbcreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"traccar/traccar"` | image repository |
| image.tag | string | `"4.14@sha256:35e733a6a3cab6089cd7b28749ba3483f26d43d392a2606e416409d97d360a55"` | image tag |
| persistence | object | See values.yaml | Configure persistence settings for the chart under this key. |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"traccar"` |  |
| postgresql.postgresqlUsername | string | `"traccar"` |  |
| service | object | See values.yaml | Configures service settings for the chart. |

All Rights Reserved - The TrueCharts Project
