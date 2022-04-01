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
| image.repository | string | `"tccr.io/truecharts/ispy-agent-dvr"` |  |
| image.tag | string | `"v3.9.0.0@sha256:72d5a30ae36e83b8fe0ea7a4ce2bcc470a45a08181606df78e45944f9080e23b"` |  |
| persistence.commands.enabled | bool | `true` |  |
| persistence.commands.mountPath | string | `"/agent/Commands"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/agent/Media/XML"` |  |
| persistence.media.enabled | bool | `true` |  |
| persistence.media.mountPath | string | `"/agent/Media/WebServerRoot/Media"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10184` |  |
| service.main.ports.main.targetPort | int | `8090` |  |
| service.turn.enabled | bool | `true` |  |
| service.turn.ports.turn.enabled | bool | `true` |  |
| service.turn.ports.turn.port | int | `3478` |  |
| service.turn.ports.turn.protocol | string | `"UDP"` |  |
| service.turn.ports.turn.targetPort | int | `3478` |  |
| service.webrtc.enabled | bool | `true` |  |
| service.webrtc.ports.webrtc0.enabled | bool | `true` |  |
| service.webrtc.ports.webrtc0.port | int | `50000` |  |
| service.webrtc.ports.webrtc0.protocol | string | `"UDP"` |  |
| service.webrtc.ports.webrtc0.targetPort | int | `50000` |  |
| service.webrtc.ports.webrtc1.enabled | bool | `true` |  |
| service.webrtc.ports.webrtc1.port | int | `50001` |  |
| service.webrtc.ports.webrtc1.protocol | string | `"UDP"` |  |
| service.webrtc.ports.webrtc1.targetPort | int | `50001` |  |
| service.webrtc.ports.webrtc10.enabled | bool | `true` |  |
| service.webrtc.ports.webrtc10.port | int | `50010` |  |
| service.webrtc.ports.webrtc10.protocol | string | `"UDP"` |  |
| service.webrtc.ports.webrtc10.targetPort | int | `50010` |  |
| service.webrtc.ports.webrtc2.enabled | bool | `true` |  |
| service.webrtc.ports.webrtc2.port | int | `50002` |  |
| service.webrtc.ports.webrtc2.protocol | string | `"UDP"` |  |
| service.webrtc.ports.webrtc2.targetPort | int | `50002` |  |
| service.webrtc.ports.webrtc3.enabled | bool | `true` |  |
| service.webrtc.ports.webrtc3.port | int | `50003` |  |
| service.webrtc.ports.webrtc3.protocol | string | `"UDP"` |  |
| service.webrtc.ports.webrtc3.targetPort | int | `50003` |  |
| service.webrtc.ports.webrtc4.enabled | bool | `true` |  |
| service.webrtc.ports.webrtc4.port | int | `50004` |  |
| service.webrtc.ports.webrtc4.protocol | string | `"UDP"` |  |
| service.webrtc.ports.webrtc4.targetPort | int | `50004` |  |
| service.webrtc.ports.webrtc5.enabled | bool | `true` |  |
| service.webrtc.ports.webrtc5.port | int | `50005` |  |
| service.webrtc.ports.webrtc5.protocol | string | `"UDP"` |  |
| service.webrtc.ports.webrtc5.targetPort | int | `50005` |  |
| service.webrtc.ports.webrtc6.enabled | bool | `true` |  |
| service.webrtc.ports.webrtc6.port | int | `50006` |  |
| service.webrtc.ports.webrtc6.protocol | string | `"UDP"` |  |
| service.webrtc.ports.webrtc6.targetPort | int | `60005` |  |
| service.webrtc.ports.webrtc7.enabled | bool | `true` |  |
| service.webrtc.ports.webrtc7.port | int | `50007` |  |
| service.webrtc.ports.webrtc7.protocol | string | `"UDP"` |  |
| service.webrtc.ports.webrtc7.targetPort | int | `50007` |  |
| service.webrtc.ports.webrtc8.enabled | bool | `true` |  |
| service.webrtc.ports.webrtc8.port | int | `50008` |  |
| service.webrtc.ports.webrtc8.protocol | string | `"UDP"` |  |
| service.webrtc.ports.webrtc8.targetPort | int | `50008` |  |
| service.webrtc.ports.webrtc9.enabled | bool | `true` |  |
| service.webrtc.ports.webrtc9.port | int | `50009` |  |
| service.webrtc.ports.webrtc9.protocol | string | `"UDP"` |  |
| service.webrtc.ports.webrtc9.targetPort | int | `50009` |  |

All Rights Reserved - The TrueCharts Project
