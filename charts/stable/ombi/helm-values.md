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
| image.repository | string | `"tccr.io/truecharts/ombi"` |  |
| image.tag | string | `"v4.15.2@sha256:207cea1812d92e56e31c62630cb9d81409be971bd2a7ac816e381f857a4f6af1"` |  |
| mariadb | object | `{"architecture":"standalone","auth":{"database":"ombi","password":"ombi","username":"ombi"},"enabled":false,"primary":{"persistence":{"enabled":false}}}` |  ... for more options see https://github.com/tccr.io/truecharts/charts/tree/master/tccr.io/truecharts/mariadb |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| service.main.ports.main.port | int | `3579` |  |
| service.main.ports.main.targetPort | int | `3579` |  |

All Rights Reserved - The TrueCharts Project
