# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.GOTIFY_PASSSTRENGTH | int | `10` |  |
| env.GOTIFY_PLUGINSDIR | string | `"data/plugins"` |  |
| env.GOTIFY_SERVER_KEEPALIVEPERIODSECONDS | int | `0` |  |
| env.GOTIFY_SERVER_LISTENADDR | string | `""` |  |
| env.GOTIFY_SERVER_PORT | int | `8080` |  |
| env.GOTIFY_SERVER_RESPONSEHEADERS | string | `"X-Custom-Header: \"custom value\""` |  |
| env.GOTIFY_SERVER_SSL_ENABLED | bool | `false` |  |
| env.GOTIFY_SERVER_STREAM_PINGPERIODSECONDS | int | `45` |  |
| env.GOTIFY_UPLOADEDIMAGESDIR | string | `"data/images"` |  |
| env.TZ | string | `"America/Los_Angeles"` |  |
| envFrom[0].configMapRef.name | string | `"gotifyenv"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"gotify/server"` |  |
| image.tag | string | `"2.1.0@sha256:57aa2aabac035c16118f625dd6d3d2c3ca421b43b28cb27512f3212193d65771"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/app/data"` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"gotify"` |  |
| postgresql.postgresqlUsername | string | `"gotify"` |  |
| secret.pass | string | `"admin"` |  |
| secret.user | string | `"admin"` |  |
| service.main.ports.main.port | int | `8080` |  |
| service.main.ports.main.targetPort | int | `8080` |  |

All Rights Reserved - The TrueCharts Project
