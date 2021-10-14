# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env | object | See below | environment variables. See [image docs](https://hub.docker.com/r/linuxserver/librespeed) for more details. |
| env.PUID | string | `"568"` | Specify the user ID the application will run as |
| env.TZ | string | `"UTC"` | Set the container timezone |
| envTpl.DB_NAME | string | `"{{ .Values.postgresql.postgresqlDatabase }}"` |  |
| envTpl.DB_PORT | string | `"5432"` |  |
| envTpl.DB_TYPE | string | `"postgresql"` |  |
| envTpl.DB_USERNAME | string | `"{{ .Values.postgresql.postgresqlUsername }}"` |  |
| envValueFrom.DB_HOSTNAME.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.DB_HOSTNAME.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.DB_PASSWORD.secretKeyRef.key | string | `"postgresql-password"` |  |
| envValueFrom.DB_PASSWORD.secretKeyRef.name | string | `"dbcreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"ghcr.io/linuxserver/librespeed"` | image repository |
| image.tag | string | `"5.2.4@sha256:6a8a801f5531de520ff07fa123cabbb7a39c4bba05a093be4832cd85e18e2489"` | image tag |
| persistence | object | See values.yaml | Configure persistence settings for the chart under this key. |
| postgresql | object | Enabled (see values.yaml for more details) | Enable and configure postgresql database subchart under this key. |
| service | object | See values.yaml | Configures service settings for the chart. |

All Rights Reserved - The TrueCharts Project
