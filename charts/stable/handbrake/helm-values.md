# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.AUTOMATED_CONVERSION_FORMAT | string | `"mp4"` |  |
| env.AUTOMATED_CONVERSION_KEEP_SOURCE | int | `1` |  |
| env.AUTOMATED_CONVERSION_NON_VIDEO_FILE_ACTION | string | `"ignore"` |  |
| env.AUTOMATED_CONVERSION_PRESET | string | `"General/Very Fast 1080p30"` |  |
| env.CLEAN_TMP_DIR | int | `1` |  |
| env.DISPLAY_HEIGHT | int | `768` |  |
| env.DISPLAY_WIDTH | int | `1280` |  |
| env.KEEP_APP_RUNNING | int | `0` |  |
| env.PUID | int | `568` |  |
| env.SECURE_CONNECTION | int | `0` |  |
| env.USER_ID | string | `"{{ .Values.env.PUID }}"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/handbrake"` |  |
| image.tag | string | `"v1.24.2@sha256:7b5fa65f152910287ac3346b8e71b67d9d85987ae28aec0730542506b9b5780a"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| secret.VNC_PASSWORD | string | `""` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10053` |  |
| service.main.ports.main.targetPort | int | `5800` |  |
| service.vnc.enabled | bool | `true` |  |
| service.vnc.ports.vnc.enabled | bool | `true` |  |
| service.vnc.ports.vnc.port | int | `10055` |  |
| service.vnc.ports.vnc.targetPort | int | `5900` |  |

All Rights Reserved - The TrueCharts Project
