# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.FB_ADDRESS | string | `""` |  |
| env.FB_BASEURL | string | `""` |  |
| env.FB_CONFIG | string | `"/config/filebrowser.json"` |  |
| env.FB_DATABASE | string | `"/database/filebrowser.db"` |  |
| env.FB_PORT | string | `"{{ .Values.service.main.ports.main.port }}"` |  |
| env.FB_ROOT | string | `"/data"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"filebrowser/filebrowser"` |  |
| image.tag | string | `"v2.21.1@sha256:fc69202b56e8a883a152f54467e4d8e5a3ed75b7ffb78a33aef63e222b46f773"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/data"` |  |
| persistence.database.enabled | bool | `true` |  |
| persistence.database.mountPath | string | `"/database"` |  |
| service.main.ports.main.port | int | `10187` |  |

All Rights Reserved - The TrueCharts Project
