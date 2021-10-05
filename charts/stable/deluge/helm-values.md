# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ghcr.io/linuxserver/deluge"` |  |
| image.tag | string | `"version-2.0.3-2201906121747ubuntu18.04.1@sha256:1d9751eb58fe7d87f5bfb28154b135436a9bad800ccdca86081843437a63f2f9"` |  |
| persistence.config.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| persistence.config.size | string | `"100Gi"` |  |
| persistence.config.type | string | `"pvc"` |  |
| persistence.varrun.enabled | bool | `true` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `8112` |  |
| service.torrent.enabled | bool | `true` |  |
| service.torrent.ports.tcp.enabled | bool | `true` |  |
| service.torrent.ports.tcp.port | int | `51413` |  |
| service.torrent.ports.tcp.protocol | string | `"TCP"` |  |
| service.torrent.ports.udp.enabled | bool | `true` |  |
| service.torrent.ports.udp.port | int | `51413` |  |
| service.torrent.ports.udp.protocol | string | `"UDP"` |  |
| service.torrent.type | string | `"ClusterIP"` |  |

All Rights Reserved - The TrueCharts Project
