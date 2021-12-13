# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.PUID | int | `568` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/kodi-headless"` |  |
| image.tag | string | `"v190"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config/.kodi"` |  |
| persistence.varrun.enabled | bool | `true` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.esall.ports.esall.port | int | `9777` |  |
| service.esall.ports.esall.protocol | string | `"UDP"` |  |
| service.esall.ports.esall.targetPort | int | `9777` |  |
| service.main.ports.main.port | int | `10148` |  |
| service.main.ports.main.targetPort | int | `8080` |  |
| service.websocket.ports.websocket.port | int | `10152` |  |
| service.websocket.ports.websocket.targetPort | int | `9090` |  |

All Rights Reserved - The TrueCharts Project
