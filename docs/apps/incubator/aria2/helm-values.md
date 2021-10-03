# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.RPC_PORT | int | `6800` |  |
| env.RPC_SECRET | string | `"ChangemeNow"` | Set the container timezone TZ: UTC PUID: 1000 GUID: 1000 UMASK_SET: 022 |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"p3terx/aria2-pro"` | image repository |
| image.tag | string | `"latest"` | image tag |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountpath | string | `"/config"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountpath | string | `"/downloads"` |  |
| persistence.varrun.enabled | bool | `true` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.listen.enabled | bool | `true` |  |
| service.main.ports.listen.port | int | `6888` |  |
| service.main.ports.main.enabled | bool | `true` |  |
| service.main.ports.main.port | int | `6800` |  |

All Rights Reserved - The TrueCharts Project
