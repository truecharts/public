# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| configmap.handbrake.data.AUTOMATED_CONVERSION_FORMAT | string | `"{{ .Values.handbrake.AUTOMATED_CONVERSION_FORMAT }}"` |  |
| configmap.handbrake.data.AUTOMATED_CONVERSION_KEEP_SOURCE | string | `"{{ ternary \"1\" \"0\" .Values.handbrake.AUTOMATED_CONVERSION_KEEP_SOURCE }}"` |  |
| configmap.handbrake.data.AUTOMATED_CONVERSION_NON_VIDEO_FILE_ACTION | string | `"{{ .Values.handbrake.AUTOMATED_CONVERSION_NON_VIDEO_FILE_ACTION }}"` |  |
| configmap.handbrake.data.AUTOMATED_CONVERSION_PRESET | string | `"{{ .Values.handbrake.AUTOMATED_CONVERSION_PRESET }}"` |  |
| configmap.handbrake.data.DISPLAY_HEIGHT | string | `"{{ .Values.handbrake.DISPLAY_HEIGHT }}"` |  |
| configmap.handbrake.data.DISPLAY_WIDTH | string | `"{{ .Values.handbrake.DISPLAY_WIDTH }}"` |  |
| configmap.handbrake.data.KEEP_APP_RUNNING | string | `"{{ ternary \"1\" \"0\" .Values.handbrake.KEEP_APP_RUNNING }}"` |  |
| configmap.handbrake.data.SECURE_CONNECTION | string | `"{{ ternary \"1\" \"0\" .Values.handbrake.SECURE_CONNECTION }}"` |  |
| configmap.handbrake.enabled | bool | `true` |  |
| envFrom[0].configMapRef.name | string | `"{{ include \"common.names.fullname\" . }}-handbrake"` |  |
| handbrake.AUTOMATED_CONVERSION_FORMAT | string | `"mp4"` |  |
| handbrake.AUTOMATED_CONVERSION_KEEP_SOURCE | bool | `true` |  |
| handbrake.AUTOMATED_CONVERSION_NON_VIDEO_FILE_ACTION | string | `"ignore"` |  |
| handbrake.AUTOMATED_CONVERSION_PRESET | string | `"General/Very Fast 1080p30"` |  |
| handbrake.DISPLAY_HEIGHT | int | `768` |  |
| handbrake.DISPLAY_WIDTH | int | `1280` |  |
| handbrake.KEEP_APP_RUNNING | bool | `false` |  |
| handbrake.SECURE_CONNECTION | bool | `false` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/handbrake"` |  |
| image.tag | string | `"v1.24.2@sha256:7b5fa65f152910287ac3346b8e71b67d9d85987ae28aec0730542506b9b5780a"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| persistence.output.enabled | bool | `true` |  |
| persistence.output.mountPath | string | `"/output"` |  |
| persistence.storage.enabled | bool | `true` |  |
| persistence.storage.mountPath | string | `"/storage"` |  |
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
