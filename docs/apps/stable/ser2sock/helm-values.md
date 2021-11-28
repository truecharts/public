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
| env | object | See below | environment variables. See [image docs](https://github.com/tenstartups/ser2sock) for more details. |
| env.BAUD_RATE | int | `115200` | Serial device baud rate |
| env.LISTENER_PORT | string | `"{{ .Values.service.main.ports.main.port }}"` | Port where ser2sock listens |
| env.SERIAL_DEVICE | string | `"{{ .Values.persistence.usb.mountPath }}"` | Path to the serial device |
| env.TZ | string | `"UTC"` | Set the container timezone |
| image.pullPolicy | string | `"Always"` | image pull policy |
| image.repository | string | `"tenstartups/ser2sock"` | image repository |
| image.tag | string | `"latest@sha256:379d9338c720da30b63dc4cf2ecea07eb89dac7d62d5c79047294fffe97ae559"` | image tag |
| persistence | object | See values.yaml | Configure persistence settings for the chart under this key. |
| service | object | See values.yaml | Configures service settings for the chart. |

All Rights Reserved - The TrueCharts Project
