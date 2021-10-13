# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.PUID | int | `568` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ghcr.io/linuxserver/beets"` |  |
| image.tag | string | `"version-1.5.0@sha256:ebb8cf9f7182758427c3acda19d6077457090335685986440078fd436345d417"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| persistence.downloads.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.downloads.enabled | bool | `true` |  |
| persistence.downloads.mountPath | string | `"/downloads"` |  |
| persistence.downloads.size | string | `"1Gi"` |  |
| persistence.music.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.music.enabled | bool | `true` |  |
| persistence.music.mountPath | string | `"/music"` |  |
| persistence.music.size | string | `"1Gi"` |  |
| persistence.varrun.enabled | bool | `true` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `8337` |  |

All Rights Reserved - The TrueCharts Project
