# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env | object | See below | environment variables. See [image docs](https://github.com/oznu/docker-homebridge#parameters) for more details. |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/homebridge"` |  |
| image.tag | string | `"v2022-02@sha256:a6b5e77d71f6cf8ab608ec96a34342a038dd8b5d8ef799108455622ad68bb7e8"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/homebridge"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `8581` |  |
| service.main.ports.main.targetPort | int | `8581` |  |
| service.main.protocol | string | `"HTTP"` |  |

All Rights Reserved - The TrueCharts Project
