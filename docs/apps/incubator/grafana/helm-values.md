# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.GF_AUTH_LDAP_ALLOW_SIGN_UP | string | `"false"` |  |
| env.GF_AUTH_LDAP_CONFIG_FILE | string | `"/opt/bitnami/grafana/conf/ldap.toml"` |  |
| env.GF_AUTH_LDAP_ENABLED | string | `"false"` |  |
| env.GF_INSTALL_PLUGINS | string | `""` |  |
| env.GF_PATHS_CONFIG | string | `"/opt/bitnami/grafana/conf/grafana.ini"` |  |
| env.GF_PATHS_DATA | string | `"/opt/bitnami/grafana/data"` |  |
| env.GF_PATHS_LOGS | string | `"/opt/bitnami/grafana/logs"` |  |
| env.GF_PATHS_PLUGINS | string | `"/opt/bitnami/grafana/data/plugins"` |  |
| env.GF_PATHS_PROVISIONING | string | `"/opt/bitnami/grafana/conf/provisioning"` |  |
| env.GF_SECURITY_ADMIN_USER | string | `"admin"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"bitnami/grafana"` |  |
| image.tag | string | `"8.2.5@sha256:105ca819eb14dc773a3df6fd56f5e78e68bd2abdb1b5d9007ff803528a84be70"` |  |
| metrics.enabled | bool | See values.yaml | Enable and configure a Prometheus serviceMonitor for the chart under this key. |
| metrics.prometheusRule | object | See values.yaml | Enable and configure Prometheus Rules for the chart under this key. |
| metrics.prometheusRule.rules | list | See prometheusrules.yaml | Configure additionial rules for the chart under this key. |
| metrics.serviceMonitor.interval | string | `"1m"` |  |
| metrics.serviceMonitor.labels | object | `{}` |  |
| metrics.serviceMonitor.scrapeTimeout | string | `"30s"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/opt/bitnami/grafana/data"` |  |
| probes.liveness.path | string | `"/api/health"` |  |
| probes.readiness.path | string | `"/api/health"` |  |
| probes.startup.path | string | `"/api/health"` |  |
| secret.GF_SECURITY_ADMIN_PASSWORD | string | `"testpassword"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| service.main.ports.main.port | int | `3000` |  |
| service.main.ports.main.targetPort | int | `3000` |  |
| service.main.protocol | string | `"HTTP"` |  |

All Rights Reserved - The TrueCharts Project
