# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"zerotier/zerotier"` |  |
| image.tag | string | `"1.8.4@sha256:b57e76e4291fbc26e1c75df07bc3534e9180457343c7ceff5d7ac8c4e25f6f44"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/var/lib/zerotier-one"` |  |
| persistence.tun.enabled | bool | `true` |  |
| persistence.tun.hostPath | string | `"/dev/net/tun"` |  |
| persistence.tun.hostPathType | string | `""` |  |
| persistence.tun.mountPath | string | `"/dev/net/tun"` |  |
| persistence.tun.readOnly | bool | `false` |  |
| persistence.tun.type | string | `"hostPath"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.capabilities.add[0] | string | `"NET_ADMIN"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10190` |  |
| service.main.ports.main.protocol | string | `"UDP"` |  |
| service.main.ports.main.targetPort | int | `9993` |  |

All Rights Reserved - The TrueCharts Project
