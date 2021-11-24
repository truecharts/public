# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env | object | `{}` | Environment variable configuration options for unifi-poller ([docs](https://unifipoller.com/docs/install/configuration)).    Note: a [configuration file](https://github.com/unifi-poller/unifi-poller/blob/master/examples/up.conf.example) is also supported. |
| image.pullPolicy | string | `"IfNotPresent"` | Image [k8s pull policy](https://kubernetes.io/docs/concepts/containers/images/#updating-images). |
| image.repository | string | `"golift/unifi-poller"` | Image to deploy. |
| image.tag | string | `"2.1.3"` | Image tag to deploy. |
| influxdb.architecture | string | `"standalone"` | InfluxDB cluster deployment architecture. |
| influxdb.authEnabled | bool | `false` | Enable InfluxDB authentication, supported by unifi-poller.    Be sure to match in unifi-poller's [influxdb config](https://unifipoller.com/docs/install/configuration#influxdb). |
| influxdb.database | string | `"unifi"` | Database name to automatically initialize.    Be sure to match in unifi-poller's [influxdb config](https://unifipoller.com/docs/install/configuration#influxdb). |
| influxdb.enabled | bool | `false` | Create an InfluxDB instance as a [unifi-poller storage backend](https://unifipoller.com/docs/dependencies/influxdb).    See [bitnami/influxdb](https://github.com/bitnami/charts/tree/master/bitnami/influxdb) for more options. |
| influxdb.persistence.enabled | bool | `false` | Enable persistence to store in a PV so data survives pod restarts. |
| ingress.main.enabled | bool | `false` | Expose [unifi-poller's web interface](https://unifipoller.com/docs/advanced/webserver)    (if enabled in the configuration) via the k8s ingress by setting this true. |
| metrics.enabled | bool | See values.yaml | Enable and configure a Prometheus serviceMonitor for the chart under this key. |
| metrics.prometheusRule | object | See values.yaml | Enable and configure Prometheus Rules for the chart under this key. |
| metrics.prometheusRule.rules | list | See prometheusrules.yaml | Configure additionial rules for the chart under this key. |
| metrics.serviceMonitor.interval | string | `"1m"` |  |
| metrics.serviceMonitor.labels | object | `{}` |  |
| metrics.serviceMonitor.scrapeTimeout | string | `"30s"` |  |
| service.main.ports.main.enabled | bool | `false` |  |
| service.main.ports.metrics.enabled | bool | `true` |  |
| service.main.ports.metrics.port | int | `9130` |  |
| service.main.ports.metrics.protocol | string | `"TCP"` |  |

All Rights Reserved - The TrueCharts Project
