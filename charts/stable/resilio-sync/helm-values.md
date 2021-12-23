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
| env.TZ | string | `"UTC"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/resilio-sync"` |  |
| image.tag | string | `"version-2.7.2.1375@sha256:54f42485d39a7773ff2e13c27ebfc32fc448eaf13f8972f38e14eedadb0b3a2e"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| persistence.varrun.enabled | bool | `true` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.bt-tcp.enabled | bool | `true` |  |
| service.bt-tcp.ports.bt-tcp.enabled | bool | `true` |  |
| service.bt-tcp.ports.bt-tcp.port | int | `55555` |  |
| service.bt-tcp.ports.bt-tcp.targetPort | int | `55555` |  |
| service.bt-udp.enabled | bool | `true` |  |
| service.bt-udp.ports.bt-udp.enabled | bool | `true` |  |
| service.bt-udp.ports.bt-udp.port | int | `55555` |  |
| service.bt-udp.ports.bt-udp.protocol | string | `"UDP"` |  |
| service.bt-udp.ports.bt-udp.targetPort | int | `55555` |  |
| service.main.ports.main.port | int | `8888` |  |
| service.main.ports.main.targetPort | int | `8888` |  |

All Rights Reserved - The TrueCharts Project
