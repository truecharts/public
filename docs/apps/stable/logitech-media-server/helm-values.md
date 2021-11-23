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
| envTpl.HTTP_PORT | string | `"{{ .Values.service.main.ports.main.port }}"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"lmscommunity/logitechmediaserver"` |  |
| image.tag | string | `"8.3.0@sha256:a035d06f8d57af2deb3de7ee9d5d22d894b17d31a1dbd46f45844af20e6cfc5a"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.cli.enabled | bool | `true` |  |
| service.cli.ports.cli.enabled | bool | `true` |  |
| service.cli.ports.cli.port | int | `9090` |  |
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
| service.playerudp.ports.slimprotoudp.targetPort | int | `3483` |  |

All Rights Reserved - The TrueCharts Project
