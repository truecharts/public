# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.nodeID | string | `"myFirstTdarrNode"` |  |
| env.nodeIP | string | `"0.0.0.0"` |  |
| env.nodePort | int | `8267` |  |
| env.serverIP | string | `"0.0.0.0"` |  |
| env.serverPort | int | `8266` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/tdarr_node"` |  |
| image.tag | string | `"v2.00.14@sha256:77e579e36d56b4b15f82f4e5c9914f157c72f054337584258f7700906e85435b"` |  |
| persistence.configs.enabled | bool | `true` |  |
| persistence.configs.mountPath | string | `"/app/configs"` |  |
| persistence.logs.enabled | bool | `true` |  |
| persistence.logs.mountPath | string | `"/app/logs"` |  |
| persistence.transcode-cache.enabled | bool | `true` |  |
| persistence.transcode-cache.mountPath | string | `"/temp"` |  |
| persistence.varrun.enabled | bool | `true` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `8267` |  |
| service.main.ports.main.targetPort | int | `8267` |  |

All Rights Reserved - The TrueCharts Project
