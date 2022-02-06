# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.JELLYFIN_PublishedServerUrl | string | `"https://jelly.mydomain.com"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/jellyfin"` |  |
| image.tag | string | `"v10.7.7@sha256:0136db4677a2ee2ee8a6962d813d6e3b49aa86784a7cfdc3af76427db32c3470"` |  |
| persistence.cache.enabled | bool | `true` |  |
| persistence.cache.mountPath | string | `"/cache"` |  |
| persistence.cache.type | string | `"emptyDir"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| service.main.ports.main.port | int | `8096` |  |
| service.main.ports.main.targetPort | int | `8096` |  |

All Rights Reserved - The TrueCharts Project
