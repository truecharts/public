# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| configmap.makemkv.data.AUTO_DISC_RIPPER | string | `"{{ ternary \"1\" \"0\" .Values.makemkv.AUTO_DISC_RIPPER }}"` |  |
| configmap.makemkv.data.AUTO_DISC_RIPPER_BD_MODE | string | `"{{ .Values.makemkv.AUTO_DISC_RIPPER_BD_MODE }}"` |  |
| configmap.makemkv.data.AUTO_DISC_RIPPER_EJECT | string | `"{{ ternary \"1\" \"0\" .Values.makemkv.AUTO_DISC_RIPPER_EJECT }}"` |  |
| configmap.makemkv.data.AUTO_DISC_RIPPER_FORCE_UNIQUE_OUTPUT_DIR | string | `"{{ ternary \"1\" \"0\" .Values.makemkv.AUTO_DISC_RIPPER_FORCE_UNIQUE_OUTPUT_DIR }}"` |  |
| configmap.makemkv.data.AUTO_DISC_RIPPER_INTERVAL | string | `"{{ .Values.makemkv.AUTO_DISC_RIPPER_INTERVAL }}"` |  |
| configmap.makemkv.data.AUTO_DISC_RIPPER_MAKEMKV_PROFILE | string | `"{{ .Values.makemkv.AUTO_DISC_RIPPER_MAKEMKV_PROFILE }}"` |  |
| configmap.makemkv.data.AUTO_DISC_RIPPER_NO_GUI_PROGRESS | string | `"{{ ternary \"1\" \"0\" .Values.makemkv.AUTO_DISC_RIPPER_NO_GUI_PROGRESS }}"` |  |
| configmap.makemkv.data.AUTO_DISC_RIPPER_PARALLEL_RIP | string | `"{{ ternary \"1\" \"0\" .Values.makemkv.AUTO_DISC_RIPPER_PARALLEL_RIP }}"` |  |
| configmap.makemkv.data.DISPLAY_HEIGHT | string | `"{{ .Values.makemkv.DISPLAY_HEIGHT }}"` |  |
| configmap.makemkv.data.DISPLAY_WIDTH | string | `"{{ .Values.makemkv.DISPLAY_WIDTH }}"` |  |
| configmap.makemkv.data.KEEP_APP_RUNNING | string | `"{{ ternary \"1\" \"0\" .Values.makemkv.KEEP_APP_RUNNING }}"` |  |
| configmap.makemkv.data.MAKEMKV_KEY | string | `"{{ .Values.makemkv.MAKEMKV_KEY }}"` |  |
| configmap.makemkv.data.SECURE_CONNECTION | string | `"{{ ternary \"1\" \"0\" .Values.makemkv.SECURE_CONNECTION }}"` |  |
| configmap.makemkv.enabled | bool | `true` |  |
| envFrom[0].configMapRef.name | string | `"{{ include \"common.names.fullname\" . }}-makemkv"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/makemkv"` |  |
| image.tag | string | `"v1.21.3@sha256:f118ce074c75f8544913c1ed1f2354613e3a8838061aa7d44c323a52a811f23d"` |  |
| makemkv.AUTO_DISC_RIPPER | bool | `false` |  |
| makemkv.AUTO_DISC_RIPPER_BD_MODE | string | `"mkv"` |  |
| makemkv.AUTO_DISC_RIPPER_EJECT | bool | `false` |  |
| makemkv.AUTO_DISC_RIPPER_FORCE_UNIQUE_OUTPUT_DIR | bool | `false` |  |
| makemkv.AUTO_DISC_RIPPER_INTERVAL | int | `5` |  |
| makemkv.AUTO_DISC_RIPPER_MAKEMKV_PROFILE | string | `""` |  |
| makemkv.AUTO_DISC_RIPPER_NO_GUI_PROGRESS | bool | `false` |  |
| makemkv.AUTO_DISC_RIPPER_PARALLEL_RIP | bool | `false` |  |
| makemkv.DISPLAY_HEIGHT | int | `768` |  |
| makemkv.DISPLAY_WIDTH | int | `1280` |  |
| makemkv.KEEP_APP_RUNNING | bool | `false` |  |
| makemkv.MAKEMKV_KEY | string | `"BETA"` |  |
| makemkv.SECURE_CONNECTION | bool | `false` |  |
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
| service.main.ports.main.port | int | `10180` |  |
| service.main.ports.main.targetPort | int | `5800` |  |
| service.vnc.enabled | bool | `true` |  |
| service.vnc.ports.vnc.enabled | bool | `true` |  |
| service.vnc.ports.vnc.port | int | `10181` |  |
| service.vnc.ports.vnc.targetPort | int | `5900` |  |

All Rights Reserved - The TrueCharts Project
