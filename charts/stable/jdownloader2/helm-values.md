# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.CLEAN_TMP_DIR | string | `"1"` |  |
| env.DISPLAY_HEIGHT | string | `"768"` |  |
| env.DISPLAY_WIDTH | string | `"1280"` |  |
| env.KEEP_APP_RUNNING | string | `"0"` |  |
| env.PUID | int | `568` |  |
| env.SECURE_CONNECTION | string | `"0"` |  |
| env.VNC_PASSWORD | string | `""` |  |
| envTpl.USER_ID | string | `"{{ .Values.env.PUID }}"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ghcr.io/truecharts/jdownloader-2"` |  |
| image.tag | string | `"v1.7.1@sha256:ed3299aa7037a99aed5978c30e504ce3daa470d11b6af9533355592c64c3cced"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `5800` |  |
| service.main.ports.main.targetPort | int | `5800` |  |
| service.myjd.enabled | bool | `true` |  |
| service.myjd.ports.myjd.enabled | bool | `true` |  |
| service.myjd.ports.myjd.port | int | `3129` |  |
| service.myjd.ports.myjd.targetPort | int | `3129` |  |
| service.vnc.enabled | bool | `true` |  |
| service.vnc.ports.vnc.enabled | bool | `true` |  |
| service.vnc.ports.vnc.port | int | `5900` |  |
| service.vnc.ports.vnc.protocol | string | `"TCP"` |  |
| service.vnc.ports.vnc.targetPort | int | `5900` |  |

All Rights Reserved - The TrueCharts Project
