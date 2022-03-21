# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.PORT | string | `"{{ .Values.service.main.ports.main.port }}"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"jonnyan404/verysync"` |  |
| image.tag | string | `"2.13.0@sha256:a6f4fe60d6e95f8b925701cd1c3ec702ccfb39d8da58441ec6e7e9c749a0692c"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/data"` |  |
| service.bt-udp1.enabled | bool | `true` |  |
| service.bt-udp1.ports.bt-udp1.enabled | bool | `true` |  |
| service.bt-udp1.ports.bt-udp1.port | int | `22037` |  |
| service.bt-udp1.ports.bt-udp1.protocol | string | `"UDP"` |  |
| service.bt-udp1.ports.bt-udp1.targetPort | int | `22037` |  |
| service.bt-udp2.enabled | bool | `true` |  |
| service.bt-udp2.ports.bt-udp2.enabled | bool | `true` |  |
| service.bt-udp2.ports.bt-udp2.port | int | `22027` |  |
| service.bt-udp2.ports.bt-udp2.protocol | string | `"UDP"` |  |
| service.bt-udp2.ports.bt-udp2.targetPort | int | `22027` |  |
| service.data.enabled | bool | `true` |  |
| service.data.ports.data.enabled | bool | `true` |  |
| service.data.ports.data.port | int | `22330` |  |
| service.data.ports.data.targetPort | int | `22330` |  |
| service.main.ports.main.port | int | `10193` |  |

All Rights Reserved - The TrueCharts Project
