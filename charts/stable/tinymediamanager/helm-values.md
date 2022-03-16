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
| image.repository | string | `"tccr.io/truecharts/tinymediamanager"` |  |
| image.tag | string | `"v4.2.7@sha256:ed1883ca3a17969f12810143bed84eb94998e8bf1e65bc9d4717d1605ee03ef5"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/data"` |  |
| persistence.movies.enabled | bool | `true` |  |
| persistence.movies.mountPath | string | `"/media/movies"` |  |
| persistence.tvshows.enabled | bool | `true` |  |
| persistence.tvshows.mountPath | string | `"/media/tvshows"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| secret.PASSWORD | string | `""` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10179` |  |
| service.main.ports.main.targetPort | int | `4000` |  |

All Rights Reserved - The TrueCharts Project
