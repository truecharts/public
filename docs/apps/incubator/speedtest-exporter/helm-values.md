# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env | object | See below | environment variables. See [application docs](https://docs.miguelndecarvalho.pt/projects/speedtest-exporter/) for more details. |
| env.TZ | string | `"UTC"` | Set the container timezone |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"ghcr.io/miguelndecarvalho/speedtest-exporter"` | image repository |
| image.tag | string | `"v3.3.4"` | image tag |
| metrics.enabled | bool | See values.yaml | Enable and configure a Prometheus serviceMonitor for the chart under this key. |
| metrics.prometheusRule | object | See values.yaml | Enable and configure Prometheus Rules for the chart under this key. |
| metrics.prometheusRule.downloadLimit | int | `400` | Download speed you want alerts to be triggered in Mbps |
| metrics.prometheusRule.jitterLimit | int | `30` | Jitter latency you want alerts to be triggered in ms |
| metrics.prometheusRule.pingLimit | int | `10` | Ping latency you want alerts to be triggered in ms |
| metrics.prometheusRule.rules | list | See prometheusrules.yaml | Configure additionial rules for the chart under this key. |
| metrics.prometheusRule.uploadLimit | int | `400` | Upload speed you want alerts to be triggered in Mbps |
| metrics.serviceMonitor.interval | string | `"60m"` | The interval field must use minutes for the padding to calculate properly. |
| metrics.serviceMonitor.labels | object | `{}` |  |
| metrics.serviceMonitor.scrapeTimeout | string | `"1m"` |  |
| service | object | See values.yaml | Configures service settings for the chart. |

All Rights Reserved - The TrueCharts Project
