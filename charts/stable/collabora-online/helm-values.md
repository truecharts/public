# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.dictionaries | string | `"de_DE en_GB en_US es_ES fr_FR it nl pt_BR pt_PT ru"` |  |
| env.domain | string | `"nextcloud\\.domain\\.tld"` |  |
| env.extra_params | string | `"-o:welcome.enable=false -o:user_interface.mode=notebookbar -o:ssl.termination=true -o:ssl.enable=false"` |  |
| env.password | string | `"changeme"` |  |
| env.server_name | string | `"collabora\\.domain\\.tld"` |  |
| env.username | string | `"admin"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ghcr.io/truecharts/collabora"` |  |
| image.tag | string | `"v6.4.11.3@sha256:30eab5f9807e006b90b2533ad3a60b84c6e744a6fed8a3be2bd3f1a839715456"` |  |
| service.main.ports.main.port | int | `9980` |  |
| service.main.type | string | `"NodePort"` |  |

All Rights Reserved - The TrueCharts Project
