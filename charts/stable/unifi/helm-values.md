# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.PGID | string | `"568"` |  |
| env.PUID | string | `"568"` |  |
| envTpl.UNIFI_GID | string | `"{{ .Values.env.PUID }}"` |  |
| envTpl.UNIFI_UID | string | `"{{ .Values.env.PGID }}"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"jacobalberty/unifi"` |  |
| image.tag | string | `"v6.2.26"` |  |
| persistence.config.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/unifi"` |  |
| persistence.config.size | string | `"100Gi"` |  |
| persistence.config.type | string | `"pvc"` |  |
| service.comm.enabled | bool | `true` |  |
| service.comm.ports.comm.enabled | bool | `true` |  |
| service.comm.ports.comm.port | int | `8080` |  |
| service.comm.ports.comm.protocol | string | `"TCP"` |  |
| service.comm.ports.comm.targetPort | int | `8080` |  |
| service.guestportal.enabled | bool | `false` |  |
| service.guestportal.ports.web.enabled | bool | `true` |  |
| service.guestportal.ports.web.port | int | `8880` |  |
| service.guestportal.ports.web.protocol | string | `"HTTP"` |  |
| service.guestportal.ports.web.targetPort | int | `8880` |  |
| service.guestportal.ports.websecure.enabled | bool | `true` |  |
| service.guestportal.ports.websecure.port | int | `8843` |  |
| service.guestportal.ports.websecure.protocol | string | `"HTTPS"` |  |
| service.guestportal.ports.websecure.targetPort | int | `8843` |  |
| service.main.ports.main.port | int | `8443` |  |
| service.main.ports.main.protocol | string | `"HTTPS"` |  |
| service.speedtest.enabled | bool | `false` |  |
| service.speedtest.ports.speedtest.enabled | bool | `true` |  |
| service.speedtest.ports.speedtest.port | int | `6789` |  |
| service.speedtest.ports.speedtest.protocol | string | `"TCP"` |  |
| service.speedtest.ports.speedtest.targetPort | int | `6789` |  |
| service.stun.enabled | bool | `true` |  |
| service.stun.ports.stun.enabled | bool | `true` |  |
| service.stun.ports.stun.port | int | `3478` |  |
| service.stun.ports.stun.protocol | string | `"UDP"` |  |
| service.stun.ports.stun.targetPort | int | `3478` |  |
| strategy.type | string | `"Recreate"` |  |

All Rights Reserved - The TrueCharts Project
