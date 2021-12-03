# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| args[0] | string | `"-config.file=/etc/promtail/promtail.yaml"` |  |
| config | object | See `values.yaml` | Section for crafting Promtails config file. The only directly relevant value is `config.file` which is a templated string that references the other values and snippets below this key. |
| config.file | string | See `values.yaml` | Config file contents for Promtail. Must be configured as string. It is templated so it can be assembled from reusable snippets in order to avoid redundancy. |
| config.logLevel | string | `"info"` | The log level of the Promtail server Must be reference in `config.file` to configure `server.log_level` See default config in `values.yaml` |
| config.lokiAddress | string | `""` | The Loki address to post logs to. Must be reference in `config.file` to configure `client.url`. See default config in `values.yaml` |
| config.serverPort | int | `3101` | The port of the Promtail server Must be reference in `config.file` to configure `server.http_listen_port` See default config in `values.yaml` |
| config.snippets | object | See `values.yaml` | A section of reusable snippets that can be reference in `config.file`. Custom snippets may be added in order to reduce redundancy. This is especially helpful when multiple `kubernetes_sd_configs` are use which usually have large parts in common. |
| config.snippets.extraClientConfigs | string | empty | You can put here any keys that will be directly added to the config file's 'client' block. |
| config.snippets.extraRelabelConfigs | list | `[]` | You can put here any additional relabel_configs to "kubernetes-pods" job |
| config.snippets.extraScrapeConfigs | string | empty | You can put here any additional scrape configs you want to add to the config file. |
| envValueFrom.HOSTNAME.fieldRef.fieldPath | string | `"spec.nodeName"` |  |
| image.repository | string | `"tccr.io/truecharts/promtail"` |  |
| image.tag | string | `"v2.4.1@sha256:83bceed26a638b211d65b6e80d4a33d01dc82b81e630d57e883b490ac0c57ef4"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/etc/promtail"` |  |
| persistence.config.objectName | string | `"promtail-config"` |  |
| persistence.config.type | string | `"secret"` |  |
| persistence.containers.enabled | bool | `true` |  |
| persistence.containers.hostPath | string | `"/mnt"` |  |
| persistence.containers.mountPath | string | `"/mnt"` |  |
| persistence.containers.readOnly | bool | `true` |  |
| persistence.containers.type | string | `"hostPath"` |  |
| persistence.pods.enabled | bool | `true` |  |
| persistence.pods.hostPath | string | `"/var/log/pods"` |  |
| persistence.pods.mountPath | string | `"/var/log/pods"` |  |
| persistence.pods.readOnly | bool | `true` |  |
| persistence.pods.type | string | `"hostPath"` |  |
| persistence.run.enabled | bool | `true` |  |
| persistence.run.hostPath | string | `"/run/promtai"` |  |
| persistence.run.mountPath | string | `"/run/promtail"` |  |
| persistence.run.type | string | `"hostPath"` |  |
| podSecurityContext | object | `{"runAsGroup":0,"runAsUser":0}` | The security context for pods |
| probes.liveness.path | string | `"/ready"` |  |
| probes.readiness.path | string | `"/ready"` |  |
| probes.startup.path | string | `"/ready"` |  |
| rbac | object | `{"enabled":true,"rules":[{"apiGroups":[""],"resources":["nodes","nodes/proxy","services","endpoints","pods"],"verbs":["get","watch","list"]}]}` | Whether Role Based Access Control objects like roles and rolebindings should be created |
| securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"readOnlyRootFilesystem":true,"runAsNonRoot":false}` | The security context for containers |
| service.main.ports.main.port | int | `3101` |  |
| service.main.ports.main.targetPort | int | `3101` |  |
| serviceAccount.create | bool | `true` | Specifies whether a ServiceAccount should be created |
| serviceMonitor.annotations | object | `{}` | ServiceMonitor annotations |
| serviceMonitor.enabled | bool | `false` | If enabled, ServiceMonitor resources for Prometheus Operator are created |
| serviceMonitor.interval | string | `nil` | ServiceMonitor scrape interval |
| serviceMonitor.labels | object | `{}` | Additional ServiceMonitor labels |
| serviceMonitor.namespace | string | `nil` | Alternative namespace for ServiceMonitor resources |
| serviceMonitor.namespaceSelector | object | `{}` | Namespace selector for ServiceMonitor resources |
| serviceMonitor.scrapeTimeout | string | `nil` | ServiceMonitor scrape timeout in Go duration format (e.g. 15s) |
| tolerations | list | `[{"effect":"NoSchedule","key":"node-role.kubernetes.io/master","operator":"Exists"},{"effect":"NoSchedule","key":"node-role.kubernetes.io/control-plane","operator":"Exists"}]` | Tolerations for pods. By default, pods will be scheduled on master/control-plane nodes. |

All Rights Reserved - The TrueCharts Project
