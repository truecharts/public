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
| focalboard.enableLocalMode | bool | `true` |  |
| focalboard.localOnly | bool | `false` |  |
| focalboard.serverRoot | string | `"http://localhost:10072"` |  |
| focalboard.telemetry | bool | `false` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/focalboard"` |  |
| image.tag | string | `"v0.14.0@sha256:489150257a4638e83a81e3e07afbb76fd891ae47c8b258b0a271ebcaa95638c3"` |  |
| persistence.uploads.enabled | bool | `true` |  |
| persistence.uploads.mountPath | string | `"/uploads"` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"focalboard"` |  |
| postgresql.postgresqlUsername | string | `"focalboard"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| service.main.ports.main.port | int | `10072` |  |

All Rights Reserved - The TrueCharts Project
