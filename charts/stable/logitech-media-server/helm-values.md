# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.HTTP_PORT | string | `"{{ .Values.service.main.ports.main.port }}"` |  |
| env.PUID | int | `568` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/logitechmediaserver"` |  |
| image.tag | string | `"v8.3.0@sha256:72c9abb0dc6b5b0e60e4efcc54eb0f68f51398db74b7441dd1664539a2db93a3"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.cli.enabled | bool | `true` |  |
| service.cli.ports.cli.enabled | bool | `true` |  |
| service.cli.ports.cli.port | int | `10059` |  |
| service.cli.ports.cli.targetPort | int | `9090` |  |
| service.main.ports.main.port | int | `7000` |  |
| service.main.ports.main.targetPort | int | `7000` |  |
| service.playertcp.enabled | bool | `true` |  |
| service.playertcp.ports.slimprototcp.enabled | bool | `true` |  |
| service.playertcp.ports.slimprototcp.port | int | `3483` |  |
| service.playertcp.ports.slimprototcp.targetPort | int | `3483` |  |
| service.playerudp.enabled | bool | `true` |  |
| service.playerudp.ports.slimprotoudp.enabled | bool | `true` |  |
| service.playerudp.ports.slimprotoudp.port | int | `3483` |  |
| service.playerudp.ports.slimprotoudp.protocol | string | `"UDP"` |  |
| service.playerudp.ports.slimprotoudp.targetPort | int | `3483` |  |

All Rights Reserved - The TrueCharts Project
