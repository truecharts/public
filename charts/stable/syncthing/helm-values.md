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
| image.repository | string | `"ghcr.io/truecharts/syncthing"` |  |
| image.tag | string | `"v1.18.3@sha256:d299f89bf7a3462953ca415c1dcea27ea1cd0eb776011905d6c37aef9a4fbea5"` |  |
| persistence.config.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/var/syncthing/"` |  |
| persistence.config.size | string | `"100Gi"` |  |
| persistence.config.type | string | `"pvc"` |  |
| service.discovery.ports.discovery.enabled | bool | `true` |  |
| service.discovery.ports.discovery.port | int | `21027` |  |
| service.discovery.ports.discovery.protocol | string | `"UDP"` |  |
| service.listeners.ports.tcp.enabled | bool | `true` |  |
| service.listeners.ports.tcp.port | int | `22000` |  |
| service.listeners.ports.tcp.protocol | string | `"TCP"` |  |
| service.listeners.ports.udp.enabled | bool | `true` |  |
| service.listeners.ports.udp.port | int | `22000` |  |
| service.listeners.ports.udp.protocol | string | `"UDP"` |  |
| service.main.ports.main.port | int | `8384` |  |

All Rights Reserved - The TrueCharts Project
