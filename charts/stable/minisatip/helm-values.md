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
| image.repository | string | `"tccr.io/truecharts/minisatip"` |  |
| image.tag | string | `"v2021.12.01"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| persistence.varrun.enabled | bool | `true` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.discovery.enabled | bool | `true` |  |
| service.discovery.ports.discovery.enabled | bool | `true` |  |
| service.discovery.ports.discovery.port | int | `1900` |  |
| service.discovery.ports.discovery.protocol | string | `"UDP"` |  |
| service.discovery.ports.discovery.targetPort | int | `1900` |  |
| service.main.ports.main.port | int | `8875` |  |
| service.main.ports.main.targetPort | int | `8875` |  |
| service.rtsp.enabled | bool | `true` |  |
| service.rtsp.ports.rtsp.enabled | bool | `true` |  |
| service.rtsp.ports.rtsp.port | int | `554` |  |
| service.rtsp.ports.rtsp.targetPort | int | `554` |  |

All Rights Reserved - The TrueCharts Project
