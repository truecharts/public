# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.DASH_URL | string | `"http://$HOSTNAME:5050"` |  |
| env.ELEVATION | int | `1217` |  |
| env.LATITUDE | int | `46` |  |
| env.LONGITUDE | int | `-94` |  |
| env.TZ | string | `"America/Chicago"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"docker.io/acockburn/appdaemon"` |  |
| image.tag | string | `"v4.1.0@sha256:209ee1c83b4c0794dd6f50333f60a212d0df7c4205e7e374ac78d988ffc3d8fd"` |  |
| persistence.conf.enabled | bool | `true` |  |
| persistence.conf.mountPath | string | `"/conf"` |  |
| persistence.varrun.enabled | bool | `true` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `5050` |  |
| service.main.ports.main.targetPort | int | `5050` |  |
| service.tcp.enabled | bool | `true` |  |
| service.tcp.ports.tcp.enabled | bool | `true` |  |
| service.tcp.ports.tcp.port | int | `51050` |  |
| service.tcp.ports.tcp.targetPort | int | `51050` |  |

All Rights Reserved - The TrueCharts Project
