# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.CHECK_FREQUENCY | int | `240` |  |
| env.PASSWORD | string | `"secretpasswordgoeshere"` |  |
| image.pullPolicy | string | `"Always"` |  |
| image.repository | string | `"ghcr.io/truecharts/podgrab"` |  |
| image.tag | string | `"v1.0.0@sha256:17a92f111c5840f1fb78f216e4191ec1f5eeeb04ad5a1a5bdde0df35fdbe8910"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| probes.liveness.enabled | bool | `false` |  |
| probes.readiness.enabled | bool | `false` |  |
| probes.startup.enabled | bool | `false` |  |
| service.main.ports.main.port | int | `8080` |  |
| service.main.ports.main.targetPort | int | `8080` |  |
| service.tcp.enabled | bool | `true` |  |
| service.tcp.ports.tcp.enabled | bool | `true` |  |
| service.tcp.ports.tcp.port | int | `51080` |  |
| service.tcp.ports.tcp.targetPort | int | `51080` |  |

All Rights Reserved - The TrueCharts Project
