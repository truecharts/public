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
| env.RPC_PORT | int | `6800` |  |
| env.TZ | string | `"UTC"` | Set the container timezone |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"tccr.io/truecharts/aria2-pro"` | image repository |
| image.tag | string | `"latest@sha256:6c0ddcc7be4da69ac146ff3153df727a5818f733636a1c4d9b78ccffd6106a23"` | image tag |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| persistence.varrun.enabled | bool | `true` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| secret.RPC_SECRET | string | `"ChangemeNow"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.listen.enabled | bool | `true` |  |
| service.listen.ports.listen.enabled | bool | `true` |  |
| service.listen.ports.listen.port | int | `6888` |  |
| service.listen.ports.listen.targetPort | int | `6888` |  |
| service.main.ports.main.port | int | `6800` |  |
| service.main.ports.main.targetPort | int | `6800` |  |

All Rights Reserved - The TrueCharts Project
