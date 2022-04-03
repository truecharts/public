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
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/logitechmediaserver"` |  |
| image.tag | string | `"v8.3.0@sha256:d3b256fbc915c2b035feca6dc66fd694222d6b585e8ed796605f2dad7288341d"` |  |
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
| service.main.ports.main.targetPort | int | `7000` |  You can't just map it like -p 7000:9000, as Logitech Media Server is telling players on which port to connect. Therefore if you have to use a different http port for LMS (other than 9000) you'll have to set the HTTP_PORT environment variable |
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
