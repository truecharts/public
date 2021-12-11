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
| image.tag | string | `"v3.00@sha256:9a4f48483b93f74394b69555c9324c746414836de247fbeafec5f53c0b077b9f"` |  |
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
