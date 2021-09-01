# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env | object | `{}` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ghcr.io/k8s-at-home/jackett"` |  |
| image.tag | string | `"v0.18.636"` |  |
| persistence.config.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| persistence.config.size | string | `"100Gi"` |  |
| persistence.config.type | string | `"pvc"` |  |
| service.main.enabled | bool | `true` |  |
| service.main.ports.main.port | int | `9117` |  |
| service.main.portsList[0].enabled | bool | `true` |  |
| service.main.portsList[0].name | string | `"extraport"` |  |
| service.main.portsList[0].port | int | `9118` |  |
| serviceList[0].enabled | bool | `true` |  |
| serviceList[0].name | string | `"extraservice"` |  |
| serviceList[0].portsList[0].enabled | bool | `true` |  |
| serviceList[0].portsList[0].name | string | `"extrasvcport"` |  |
| serviceList[0].portsList[0].port | int | `9119` |  |
| strategy.type | string | `"Recreate"` |  |

All Rights Reserved - The TrueCharts Project
