# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.OPENHAB_HTTPS_PORT | string | `"{{ .Values.service.https.ports.https.port }}"` |  |
| env.OPENHAB_HTTP_PORT | string | `"{{ .Values.service.main.ports.main.port }}"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/openhab"` |  |
| image.tag | string | `"v3.2.0@sha256:813f937332689854c808142b0b8af38edeed276e1c5a07bf4c77cb76ea6e7e61"` |  |
| persistence.addons.enabled | bool | `true` |  |
| persistence.addons.mountPath | string | `"/openhab/addons"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/openhab/conf"` |  |
| persistence.userdata.enabled | bool | `true` |  |
| persistence.userdata.mountPath | string | `"/openhab/userdata"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.https.enabled | bool | `true` |  |
| service.https.ports.https.enabled | bool | `true` |  |
| service.https.ports.https.port | int | `10170` |  |
| service.https.protocol | string | `"HTTPS"` |  |
| service.main.ports.main.port | int | `10169` |  |
| service.main.protocol | string | `"HTTP"` |  |

All Rights Reserved - The TrueCharts Project
