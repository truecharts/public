# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env | object | See below | environment variables. See more environment variables in the [flood documentation] (https://github.com/jesec/flood/blob/v4.6.0/config.ts) Note: The environmental variables are not case sensitive (e.g. FLOOD_OPTION_port=FLOOD_OPTION_PORT). |
| env.FLOOD_OPTION_RUNDIR | string | `"/data"` | Where to store Flood's runtime files (eg. database) |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"ghcr.io/truecharts/flood"` | image repository |
| image.tag | string | `"v4.7.0@sha256:6ad4f3eb39e6b04d1632dd0436031377eb35759e0edcd56a95e5dd8c58c09ed8"` | image tag |
| persistence | object | See values.yaml | Configure persistence settings for the chart under this key. |
| service | object | See values.yaml | Configures service settings for the chart. |

All Rights Reserved - The TrueCharts Project
