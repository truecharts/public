# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env | object | See below | environment variables. |
| env.CAMERA_DEV | string | `nil` | MJPG Streamer camera device |
| env.ENABLE_MJPG_STREAMER | string | `"true"` | Enable MJPG Streamer Enable this to ensure camera streaming is enabled you add a video device. |
| env.MJPG_STREAMER_INPUT | string | `nil` | MJPG Streamer input parameters |
| env.TZ | string | `"UTC"` | Set the container timezone |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"ghcr.io/truecharts/octoprint"` | image repository |
| image.tag | string | `"v1.7.2@sha256:80d677488365ad240b0cef90fa381ba849dcd82dfc62b11689d88da9867956c6"` | image tag |
| persistence | object | See values.yaml | Configure persistence settings for the chart under this key. |
| persistence.varrun | object | See values.yaml | Configure a hostPathMount to mount a USB device in the container. |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service | object | See values.yaml | Configures service settings for the chart. |

All Rights Reserved - The TrueCharts Project
