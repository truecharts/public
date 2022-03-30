# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.ROOT_URL | string | `"http://localhost"` |  |
| env.WRITABLE_PATH | string | `"/data"` |  |
| envValueFrom.MONGO_URL.secretKeyRef.key | string | `"url"` |  |
| envValueFrom.MONGO_URL.secretKeyRef.name | string | `"mongodbcreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/wekan"` |  |
| image.tag | string | `"v6.11@sha256:4d36ca29c2bf2775903d94e72b5ed55dc2893331ecced6a7ffd01164633e8df4"` |  |
| mongodb.enabled | bool | `true` |  |
| mongodb.existingSecret | string | `"mongodbcreds"` |  |
| mongodb.mongodbDatabase | string | `"wekan"` |  |
| mongodb.mongodbUsername | string | `"wekan"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/data"` |  |
| service.main.ports.main.port | int | `10204` |  |
| service.main.ports.main.targetPort | int | `8080` |  |

All Rights Reserved - The TrueCharts Project
