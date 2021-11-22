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
| env.RPC_SECRET | string | `"ChangemeNow"` |  |
| env.TZ | string | `"UTC"` | Set the container timezone |
| env.UMASK_SET | int | `18` |  |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"p3terx/aria2-pro"` | image repository |
| image.tag | string | `"latest@sha256:2589527dfef6351d459f3a6781e4efef41d694878765b107413a6eb4bb6bbca7"` | image tag |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| persistence.varrun.enabled | bool | `true` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.listen.enabled | bool | `true` |  |
| service.listen.ports.listen.enabled | bool | `true` |  |
| service.listen.ports.listen.port | int | `6888` |  |
| service.listen.ports.listen.targetPort | int | `6888` |  |
| service.main.ports.main.port | int | `6800` |  |
| service.main.ports.main.targetPort | int | `6800` |  |

All Rights Reserved - The TrueCharts Project
