# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env | object | See below | environment variables. See [image docs](https://github.com/mitsumaui/leaf2mqtt) for more details. |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.repository | string | `"ghcr.io/k8s-at-home/leaf2mqtt"` | Image repository |
| image.tag | string | `"v0.5@sha256:38af096ee01683a958ff457dea40325bf841d87cb9e95ec2c41ae8fb20ab575a"` | Image tag |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| probes.liveness.enabled | bool | `false` |  |
| probes.readiness.enabled | bool | `false` |  |
| probes.startup.enabled | bool | `false` |  |
| secret.LEAF_PASSWORD | string | `"changeme"` |  |
| secret.LEAF_USERNAME | string | `"leafuser"` |  |
| secret.MQTT_PASSWORD | string | `"changeme"` |  |
| secret.MQTT_USERNAME | string | `"mqttuser"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.enabled | bool | `false` |  |

All Rights Reserved - The TrueCharts Project
