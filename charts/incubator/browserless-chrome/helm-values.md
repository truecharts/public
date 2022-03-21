# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.CHROME_REFRESH_TIME | int | `3600000` |  |
| env.CONNECTION_TIMEOUT | int | `30000` |  |
| env.DEFAULT_BLOCK_ADS | bool | `true` |  |
| env.DEFAULT_HEADLESS | bool | `false` |  |
| env.DEFAULT_IGNORE_DEFAULT_ARGS | bool | `true` |  |
| env.DEFAULT_IGNORE_HTTPS_ERRORS | bool | `true` |  |
| env.DISABLE_AUTO_SET_DOWNLOAD_BEHAVIOR | bool | `false` |  |
| env.ENABLE_API_GET | bool | `true` |  |
| env.ENABLE_CORS | bool | `false` |  |
| env.ENABLE_DEBUGGER | bool | `true` |  |
| env.ENABLE_XVBF | bool | `true` |  |
| env.EXIT_ON_HEALTH_FAILURE | bool | `true` |  |
| env.FUNCTION_ENABLE_INCOGNITO_MODE | bool | `true` |  |
| env.HOST | string | `""` |  |
| env.MAX_CONCURRENT_SESSIONS | int | `5` |  |
| env.MAX_QUEUE_LENGTH | int | `5` |  |
| env.METRICS_JSON_PATH | string | `"/metrics/metrics.json"` |  |
| env.WORKSPACE_DELETE_EXPIRED | bool | `false` |  |
| env.WORKSPACE_DIR | string | `"/downloads"` |  |
| env.WORKSPACE_EXPIRE_DAYS | int | `30` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"browserless/chrome"` |  |
| image.tag | string | `"version-v10.6.2@sha256:f0065aa44fb1c38b7fc30d34e220138dc0a0c6477b78eb7f59015622c2052030"` |  |
| imagePuppeteer.pullPolicy | string | `"IfNotPresent"` |  |
| imagePuppeteer.repository | string | `"browserless/chrome"` |  |
| imagePuppeteer.tag | string | `"1.51.1-puppeteer-13.1.3@sha256:1a36d1f4f7646ec3c40a15b8150f1202fc66720e38c7001ab21018737ec04937"` |  |
| imageSelector | string | `"image"` |  |
| persistence.downloads.enabled | bool | `true` |  |
| persistence.downloads.mountPath | string | `"/downloads"` |  |
| persistence.metrics.enabled | bool | `true` |  |
| persistence.metrics.mountPath | string | `"/metrics"` |  |
| probes.liveness.path | string | `"/metrics"` |  |
| probes.readiness.path | string | `"/metrics"` |  |
| probes.startup.path | string | `"/metrics"` |  |
| secret.TOKEN | string | `""` |  |
| service.main.ports.main.port | int | `10194` |  |
| service.main.ports.main.targetPort | int | `3000` |  |

All Rights Reserved - The TrueCharts Project
