# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.HOST_IP | string | `"localhost"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/nextpvr"` |  |
| image.tag | string | `"latest@sha256:376eadecab56535b4e15e7b75278b1e5bc8040e33041c07b884d90021ed86b2b"` |  |
| persistence.buffer.enabled | bool | `true` |  |
| persistence.buffer.mountPath | string | `"/buffer"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| persistence.recordings.enabled | bool | `true` |  |
| persistence.recordings.mountPath | string | `"/recordings"` |  |
| service.main.ports.main.port | int | `10183` |  |
| service.main.ports.main.targetPort | int | `8866` |  |

All Rights Reserved - The TrueCharts Project
