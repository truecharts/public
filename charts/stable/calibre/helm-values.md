# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.CLI_ARGS | string | `nil` |  |
| env.PUID | int | `568` |  |
| env.TZ | string | `"UTC"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/calibre"` |  |
| image.tag | string | `"v5.32.0-ls138@sha256:a7c6272300628eb747dc129001aef8bc53d9b462ebe6b4953de904a2a5e15c8e"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| persistence.varrun.enabled | bool | `true` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| secret.PASSWORD | string | `""` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `8084` |  |
| service.main.ports.main.targetPort | int | `8080` |  |
| service.webserver.enabled | bool | `true` |  |
| service.webserver.ports.webserver.enabled | bool | `true` |  |
| service.webserver.ports.webserver.port | int | `8081` |  |
| service.webserver.ports.webserver.targetPort | int | `8081` |  |

All Rights Reserved - The TrueCharts Project
