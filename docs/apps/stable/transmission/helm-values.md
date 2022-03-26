# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.TRANSMISSION_PEER_PORT | string | `"{{ .Values.service.torrent.ports.torrent.targetPort }}"` |  |
| env.TRANSMISSION_RPC_PORT | string | `"{{ .Values.service.main.ports.main.targetPort }}"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/transmission"` |  |
| image.tag | string | `"v3.00@sha256:06b6839f7401357797e8aca435e58c87407c6006d74e92b88b10c51855ff0c94"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| secret | object | `{}` |  |
| service.main.ports.main.port | int | `10109` |  |
| service.main.ports.main.targetPort | int | `9091` |  |
| service.torrent.enabled | bool | `true` |  |
| service.torrent.ports.torrent.enabled | bool | `true` |  |
| service.torrent.ports.torrent.port | int | `51414` |  |
| service.torrent.ports.torrent.targetPort | int | `51414` |  |
| service.torrentudp.enabled | bool | `true` |  |
| service.torrentudp.ports.torrentudp.enabled | bool | `true` |  |
| service.torrentudp.ports.torrentudp.port | int | `51414` |  |
| service.torrentudp.ports.torrentudp.protocol | string | `"UDP"` |  |
| service.torrentudp.ports.torrentudp.targetPort | int | `51414` |  |

All Rights Reserved - The TrueCharts Project
