# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env | object | `{}` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/unpackerr"` |  |
| image.tag | string | `"v0.9.8@sha256:9b8c5938e6ec19d3b2b2f1cf0cd4478fa7b6ac9a6e3efa54b77c9e6c9b9bc761"` |  |
| persistence.downloads.enabled | bool | `true` |  |
| persistence.downloads.mountPath | string | `"/downloads"` |  |
| portal.enabled | bool | `false` |  |
| probes.liveness.enabled | bool | `false` |  |
| probes.readiness.enabled | bool | `false` |  |
| probes.startup.enabled | bool | `false` |  |
| service.main.enabled | bool | `false` |  |
| service.main.ports.main.enabled | bool | `false` |  |

All Rights Reserved - The TrueCharts Project
