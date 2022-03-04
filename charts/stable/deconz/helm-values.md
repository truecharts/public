# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Affinity constraint rules to place the Pod on a specific node. [[ref]](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity) |
| env.DECONZ_DEVICE | string | `nil` | Override the location where deCONZ looks for the RaspBee/Conbee device. |
| env.DECONZ_GID | string | `"{{ .Values.podSecurityContext.fsGroup }}"` |  |
| env.DECONZ_START_VERBOSE | int | `0` |  |
| env.DECONZ_UID | string | `"{{ .Values.security.PUID }}"` |  |
| env.DECONZ_UPNP | int | `0` |  |
| env.DECONZ_VNC_MODE | int | `1` | Enable VNC access to the container to view the deCONZ ZigBee mesh |
| env.DECONZ_VNC_PORT | string | `"{{ .Values.service.vnc.ports.vnc.port }}"` |  |
| env.DECONZ_WEB_PORT | string | `"{{ .Values.service.main.ports.main.port }}"` |  |
| env.DECONZ_WS_PORT | string | `"{{ .Values.service.websocket.ports.websocket.port }}"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/deconz"` |  |
| image.tag | string | `"v2.14.01@sha256:c3607b4e64b50acb52240d1b6e6798ccd132578fb3f065544be642709638b1c2"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/opt/deCONZ"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| secret.DECONZ_VNC_PASSWORD | string | `""` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10008` |  |
| service.vnc.enabled | bool | `true` |  |
| service.vnc.ports.vnc.enabled | bool | `true` |  |
| service.vnc.ports.vnc.port | int | `10002` |  |
| service.websocket.enabled | bool | `true` |  |
| service.websocket.ports.websocket.enabled | bool | `true` |  |
| service.websocket.ports.websocket.port | int | `10001` |  |

All Rights Reserved - The TrueCharts Project
