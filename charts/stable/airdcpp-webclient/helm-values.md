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
| image.repository | string | `"tccr.io/truecharts/airdcpp-webclient"` |  |
| image.tag | string | `"v2.11.2@sha256:9dfc8d1ca4ff738c9586c902eaf3dc92d914412e5a8f3ec9a5002633a58d7a35"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/.airdcpp"` |  |
| service.encrypted-tcp.enabled | bool | `true` |  |
| service.encrypted-tcp.ports.encrypted-tcp.enabled | bool | `true` |  |
| service.encrypted-tcp.ports.encrypted-tcp.port | int | `21249` |  |
| service.encrypted-tcp.ports.encrypted-tcp.targetPort | int | `21249` |  |
| service.main.ports.main.port | int | `10155` |  |
| service.main.ports.main.targetPort | int | `5600` |  |
| service.search-udp.enabled | bool | `true` |  |
| service.search-udp.ports.search-udp.enabled | bool | `true` |  |
| service.search-udp.ports.search-udp.port | int | `21248` |  |
| service.search-udp.ports.search-udp.protocol | string | `"UDP"` |  |
| service.search-udp.ports.search-udp.targetPort | int | `21248` |  |
| service.unencrypted-tcp.enabled | bool | `true` |  |
| service.unencrypted-tcp.ports.unencrypted-tcp.enabled | bool | `true` |  |
| service.unencrypted-tcp.ports.unencrypted-tcp.port | int | `21248` |  |
| service.unencrypted-tcp.ports.unencrypted-tcp.targetPort | int | `21248` |  |

All Rights Reserved - The TrueCharts Project
