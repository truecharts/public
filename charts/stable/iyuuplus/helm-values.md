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
| image.repository | string | `"iyuucn/iyuuplus"` |  |
| image.tag | string | `"latest@sha256:657efe26a464638a2e39ba618e8912830c6280fa1fe9af55adb942175cf0835e"` |  |
| persistence.btbackup.enabled | bool | `true` |  |
| persistence.btbackup.mountPath | string | `"/BT_backup"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/IYUU/db"` |  |
| persistence.torrents.enabled | bool | `true` |  |
| persistence.torrents.mountPath | string | `"/torrents"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10188` |  |
| service.main.ports.main.targetPort | int | `8787` |  |

All Rights Reserved - The TrueCharts Project
