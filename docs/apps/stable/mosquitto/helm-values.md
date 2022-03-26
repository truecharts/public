# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| auth.enabled | bool | `false` | By enabling this, `allow_anonymous` gets set to `false` in the mosquitto config. |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/eclipse-mosquitto"` |  |
| image.tag | string | `"v2.0.14@sha256:6e58ccce3eb94b213f5af2a7d969c1c39aea1ccc6f3e35a93d9dd4f961199c81"` |  |
| persistence.configinc.enabled | bool | `true` |  |
| persistence.configinc.mountPath | string | `"/mosquitto/configinc"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/mosquitto/data"` |  |
| service.main.ports.main.port | int | `1883` |  |
| service.main.ports.main.targetPort | int | `1883` |  |

All Rights Reserved - The TrueCharts Project
