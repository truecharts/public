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
| service.comm.ports.tcp.enabled | bool | `true` |  |
| service.comm.ports.tcp.port | int | `8080` |  |
| service.comm.ports.tcp.protocol | string | `"TCP"` |  |
| service.comm.ports.tcp.targetPort | int | `8080` |  |
| service.main.ports.main.port | int | `8443` |  |
| service.main.ports.main.protocol | string | `"HTTPS"` |  |
| service.stun.enabled | bool | `true` |  |
| service.stun.ports.udp.enabled | bool | `true` |  |
| service.stun.ports.udp.port | int | `3478` |  |
| service.stun.ports.udp.protocol | string | `"UDP"` |  |
| service.stun.ports.udp.targetPort | int | `3478` |  |
| strategy.type | string | `"Recreate"` |  |

All Rights Reserved - The TrueCharts Project
