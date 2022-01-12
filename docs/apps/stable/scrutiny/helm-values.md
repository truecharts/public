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
| env.SCRUTINY_API_ENDPOINT | string | `"http://localhost:8080"` |  |
| env.SCRUTINY_COLLECTOR | bool | `true` |  |
| env.SCRUTINY_WEB | bool | `true` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/scrutiny"` |  |
| image.tag | string | `"v2021.12.16"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/scrutiny/config"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/config"` |  |
| persistence.udev.enabled | bool | `true` |  |
| persistence.udev.hostPath | string | `"/run/udev"` |  |
| persistence.udev.mountPath | string | `"/run/udev"` |  |
| persistence.udev.readOnly | bool | `true` |  |
| persistence.udev.type | string | `"hostPath"` |  |
| persistence.varrun.enabled | bool | `true` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.allowPrivilegeEscalation | bool | `true` |  |
| securityContext.privileged | bool | `true` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10151` |  |
| service.main.ports.main.targetPort | int | `8080` |  |

All Rights Reserved - The TrueCharts Project
