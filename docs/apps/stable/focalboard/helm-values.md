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
| image.repository | string | `"tccr.io/truecharts/focalboard"` | image repository |
| image.tag | string | `"v0.8.0@sha256:0c560a1e1b11015598e63b580d6e21b5bb41bc2e140b15e4a54b7b0c415e765e"` | image tag |
| persistence | object | See values.yaml | Configure persistence settings for the chart under this key. |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| service | object | See values.yaml | Configures service settings for the chart. |

All Rights Reserved - The TrueCharts Project
