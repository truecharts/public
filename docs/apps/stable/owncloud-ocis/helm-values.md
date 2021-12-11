# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env | object | See below | environment variables. See more environment variables in the [owncloud-ocis documentation](https://owncloud.dev/ocis/configuration/#environment-variables). |
| env.TZ | string | `"UTC"` | Set the container timezone |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"tccr.io/truecharts/ocis"` | image repository |
| image.tag | string | `"v1.15.0@sha256:2619ab5c44a83de923b18b09abcda4bc552e543e35107c6f2d00b0a2d7e25397"` | image tag |
| persistence | object | See values.yaml | Configure persistence settings for the chart under this key. |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| service | object | See values.yaml | Configures service settings for the chart. |

All Rights Reserved - The TrueCharts Project
