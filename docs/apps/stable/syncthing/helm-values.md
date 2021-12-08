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
| image.repository | string | `"tccr.io/truecharts/syncthing"` |  |
| image.tag | string | `"v1.18.5@sha256:13830f6cf740e859743beb2ee5acf55d226d2e313fd340fc56ddadc497a7597a"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/var/syncthing/"` |  |
| service.discovery.enabled | bool | `true` |  |
| service.discovery.ports.discovery.enabled | bool | `true` |  |
| service.discovery.ports.discovery.port | int | `21027` |  |
| service.discovery.ports.discovery.protocol | string | `"UDP"` |  |
| service.discovery.ports.discovery.targetPort | int | `21027` |  |
| service.listeners-udp.enabled | bool | `true` |  |
| service.listeners-udp.ports.udp.enabled | bool | `true` |  |
| service.listeners-udp.ports.udp.port | int | `22000` |  |
| service.listeners-udp.ports.udp.protocol | string | `"UDP"` |  |
| service.listeners-udp.ports.udp.targetPort | int | `22000` |  |
| service.listeners.enabled | bool | `true` |  |
| service.listeners.ports.tcp.enabled | bool | `true` |  |
| service.listeners.ports.tcp.port | int | `22000` |  |
| service.listeners.ports.tcp.targetPort | int | `22000` |  |
| service.main.ports.main.port | int | `8384` |  |
| service.main.ports.main.targetPort | int | `8384` |  |

All Rights Reserved - The TrueCharts Project
