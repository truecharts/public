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
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/syslog-ng"` |  |
| image.tag | string | `"v3.30.1"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| persistence.varrun.enabled | bool | `true` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `6601` |  |
| service.main.ports.main.targetPort | int | `6601` |  |
| service.syslog-tls.enabled | bool | `true` |  |
| service.syslog-tls.ports.syslog-tls.enabled | bool | `true` |  |
| service.syslog-tls.ports.syslog-tls.port | int | `6514` |  |
| service.syslog-tls.ports.syslog-tls.targetPort | int | `6514` |  |
| service.syslog-udp.enabled | bool | `true` |  |
| service.syslog-udp.ports.syslog-udp.enabled | bool | `true` |  |
| service.syslog-udp.ports.syslog-udp.port | int | `5514` |  |
| service.syslog-udp.ports.syslog-udp.protocol | string | `"UDP"` |  |
| service.syslog-udp.ports.syslog-udp.targetPort | int | `5514` |  |

All Rights Reserved - The TrueCharts Project
