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
| env.AUTOMATED_CONVERSION_KEEP_SOURCE | string | `"1"` |  |
| env.AUTOMATED_CONVERSION_NON_VIDEO_FILE_ACTION | string | `"ignore"` |  |
| env.AUTOMATED_CONVERSION_PRESET | string | `"General/Very Fast 1080p30"` |  |
| env.CLEAN_TMP_DIR | string | `"1"` |  |
| env.DISPLAY_HEIGHT | string | `"768"` |  |
| env.DISPLAY_WIDTH | string | `"1280"` |  |
| env.KEEP_APP_RUNNING | string | `"0"` |  |
| env.PGID | string | `"568"` |  |
| env.PUID | string | `"568"` |  |
| env.SECURE_CONNECTION | string | `"0"` |  |
| env.VNC_PASSWORD | string | `nil` |  |
| envTpl.GROUP_ID | string | `"{{ .Values.env.PGID }}"` |  |
| envTpl.USER_ID | string | `"{{ .Values.env.PUID }}"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ghcr.io/truecharts/handbrake"` |  |
| image.tag | string | `"v1.24.1@sha256:465f3116359c0b40497f0f2249cb1326047208d2aa70c0822df73e3d6e49eee7"` |  |
| persistence.config.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| persistence.config.size | string | `"100Gi"` |  |
| persistence.config.type | string | `"pvc"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `5800` |  |
| service.vnc.enabled | bool | `true` |  |
| service.vnc.ports.vnc.enabled | bool | `true` |  |
| service.vnc.ports.vnc.port | int | `5900` |  |
| service.vnc.ports.vnc.protocol | string | `"TCP"` |  |
| service.vnc.type | string | `"ClusterIP"` |  |

All Rights Reserved - The TrueCharts Project
