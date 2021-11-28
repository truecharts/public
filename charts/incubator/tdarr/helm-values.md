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
| env.serverIP | string | `"localhost"` |  |
| env.serverPort | int | `8266` |  |
| env.webUIPort | int | `8265` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"haveagitgat/tdarr"` |  |
| image.tag | string | `"2.00.10@sha256:63b95a5897f7be1841f4f4e192ab978ec4afc2d81d6fcc150f4785071560ed86"` |  |
| persistence.configs.enabled | bool | `true` |  |
| persistence.configs.mountPath | string | `"/app/configs"` |  |
| persistence.logs.enabled | bool | `true` |  |
| persistence.logs.mountPath | string | `"/app/logs"` |  |
| persistence.server.enabled | bool | `true` |  |
| persistence.server.mountPath | string | `"/app/server"` |  |
| persistence.varrun.enabled | bool | `true` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.comm.enabled | bool | `true` |  |
| service.comm.ports.comm.enabled | bool | `true` |  |
| service.comm.ports.comm.port | int | `8266` |  |
| service.comm.ports.comm.targetPort | int | `8266` |  |
| service.main.ports.main.port | int | `8265` |  |
| service.main.ports.main.targetPort | int | `8265` |  |

All Rights Reserved - The TrueCharts Project
