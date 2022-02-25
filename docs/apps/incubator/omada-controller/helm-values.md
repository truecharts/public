# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.TZ | string | `"UTC"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/omada-controller"` |  |
| image.tag | string | `"v5.0@sha256:31b3cd5a6eee52c2b04a694f8a103447fc98a03b52f3b20c49d867058f15e314"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/data"` |  |
| persistence.work.enabled | bool | `true` |  |
| persistence.work.mountPath | string | `"/work"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.comm.enabled | bool | `true` |  |
| service.comm.ports.comm.enabled | bool | `true` |  |
| service.comm.ports.comm.port | int | `8843` |  |
| service.comm.ports.comm.protocol | string | `"HTTPS"` |  |
| service.comm.ports.comm.targetPort | int | `8843` |  |
| service.main.ports.main.port | int | `8043` |  |
| service.main.ports.main.protocol | string | `"HTTPS"` |  |
| service.main.ports.main.targetPort | int | `8043` |  |
| service.omada-tcp.enabled | bool | `true` |  |
| service.omada-tcp.ports.omada-tcp1.enabled | bool | `true` |  |
| service.omada-tcp.ports.omada-tcp1.port | int | `29811` |  |
| service.omada-tcp.ports.omada-tcp1.targetPort | int | `29811` |  |
| service.omada-tcp.ports.omada-tcp2.enabled | bool | `true` |  |
| service.omada-tcp.ports.omada-tcp2.port | int | `29812` |  |
| service.omada-tcp.ports.omada-tcp2.targetPort | int | `29812` |  |
| service.omada-tcp.ports.omada-tcp3.enabled | bool | `true` |  |
| service.omada-tcp.ports.omada-tcp3.port | int | `29813` |  |
| service.omada-tcp.ports.omada-tcp3.targetPort | int | `29813` |  |
| service.omada-tcp.ports.omada-tcp4.enabled | bool | `true` |  |
| service.omada-tcp.ports.omada-tcp4.port | int | `29814` |  |
| service.omada-tcp.ports.omada-tcp4.targetPort | int | `29814` |  |
| service.omada-udp.enabled | bool | `true` |  |
| service.omada-udp.ports.omada-udp1.enabled | bool | `true` |  |
| service.omada-udp.ports.omada-udp1.port | int | `29810` |  |
| service.omada-udp.ports.omada-udp1.protocol | string | `"UDP"` |  |
| service.omada-udp.ports.omada-udp1.targetPort | int | `29810` |  |

All Rights Reserved - The TrueCharts Project
