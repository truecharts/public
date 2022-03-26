# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| config | object | See values.yaml | Configures app settings. See [image docs](https://github.com/Hypfer/ICantBelieveItsNotValetudo) for more information. |
| controller.strategy | string | `"RollingUpdate"` | Set the controller upgrade strategy |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"tccr.io/truecharts/icantbelieveitsnotvaletudo"` | image repository |
| image.tag | string | `"v2021.2.1@sha256:12546c37abe795970d27fda99f78fd45cd25522b11b4c6db6ce98d7484c68883"` | image tag |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| service.main.ports.main.port | int | `10039` |  |
| service.main.ports.main.targetPort | int | `3000` |  |

All Rights Reserved - The TrueCharts Project
