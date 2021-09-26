# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env | object | See below | environment variables. See more environment variables in the [image entrypoint script](https://github.com/FlipEnergy/container-images/blob/main/focalboard/entrypoint.sh) |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"ghcr.io/truecharts/focalboard"` | image repository |
| image.tag | string | `"v0.8.0@sha256:c8a81de85722b1d8ce728222cd5b77ea9f8e4ca33c91787a8a3eb0a49f6fa432"` | image tag |
| persistence | object | See values.yaml | Configure persistence settings for the chart under this key. |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| service | object | See values.yaml | Configures service settings for the chart. |

All Rights Reserved - The TrueCharts Project
