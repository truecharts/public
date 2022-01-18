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
| env.WEBROOT | string | `"domoticz"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/domoticz"` |  |
| image.tag | string | `"v2021.1.20220113"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| persistence.varrun.enabled | bool | `true` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.comm1.enabled | bool | `true` |  |
| service.comm1.ports.comm1.enabled | bool | `true` |  |
| service.comm1.ports.comm1.port | int | `6144` |  |
| service.comm1.ports.comm1.targetPort | int | `6144` |  |
| service.comm2.enabled | bool | `true` |  |
| service.comm2.ports.comm2.enabled | bool | `true` |  |
| service.comm2.ports.comm2.port | int | `1443` |  |
| service.comm2.ports.comm2.targetPort | int | `1443` |  |
| service.main.ports.main.port | int | `10144` |  |
| service.main.ports.main.targetPort | int | `8080` |  |

All Rights Reserved - The TrueCharts Project
