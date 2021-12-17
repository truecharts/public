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
| image.repository | string | `"tccr.io/truecharts/ipfs"` |  |
| image.tag | string | `"v2.13.0"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| persistence.varrun.enabled | bool | `true` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.api.enabled | bool | `true` |  |
| service.api.ports.api.enabled | bool | `true` |  |
| service.api.ports.api.port | int | `5001` |  |
| service.api.ports.api.targetPort | int | `5001` |  |
| service.gateway.enabled | bool | `true` |  |
| service.gateway.ports.gateway.enabled | bool | `true` |  |
| service.gateway.ports.gateway.port | int | `10147` |  |
| service.gateway.ports.gateway.targetPort | int | `8080` |  |
| service.main.ports.main.port | int | `10125` |  |
| service.main.ports.main.targetPort | int | `80` |  |
| service.peer.enabled | bool | `true` |  |
| service.peer.ports.peer.enabled | bool | `true` |  |
| service.peer.ports.peer.port | int | `4001` |  |
| service.peer.ports.peer.targetPort | int | `4001` |  |

All Rights Reserved - The TrueCharts Project
