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
| image.repository | string | `"ghcr.io/linuxserver/tvheadend"` |  |
| image.tag | string | `"version-63784405@sha256:ae47a3f6a7d2d7efefb68087da7cbed786f801cb87c7c93b1e6b989c0021aefa"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| persistence.varrun.enabled | bool | `true` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.htsp.enabled | bool | `true` |  |
| service.htsp.ports.htsp.enabled | bool | `true` |  |
| service.htsp.ports.htsp.port | int | `9982` |  |
| service.htsp.ports.htsp.targetPort | int | `9982` |  |
| service.main.ports.main.port | int | `9981` |  |
| service.main.ports.main.targetPort | int | `9981` |  |

All Rights Reserved - The TrueCharts Project
