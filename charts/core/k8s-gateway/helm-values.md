# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| apex | string | `""` | Override the default `serviceName.namespace` domain apex |
| args[0] | string | `"-conf"` |  |
| args[1] | string | `"/etc/coredns/Corefile"` |  |
| domains | list | `[{"dnsChallenge":{"domain":"dns01.clouddns.com","enabled":false},"domain":"example.com"}]` | list of processed domains |
| domains[0] | object | `{"dnsChallenge":{"domain":"dns01.clouddns.com","enabled":false},"domain":"example.com"}` | Delegated domain |
| domains[0].dnsChallenge | object | `{"domain":"dns01.clouddns.com","enabled":false}` | Optional configuration option for DNS01 challenge that will redirect all acme challenge requests to external cloud domain (e.g. managed by cert-manager) See: https://cert-manager.io/docs/configuration/acme/dns01/ |
| forward.enabled | bool | `true` |  |
| forward.options[0].name | string | `"tls_servername"` |  |
| forward.options[0].value | string | `"cloudflare-dns.com"` |  |
| forward.primary | string | `"tls://1.1.1.1"` |  |
| forward.secondary | string | `"tls://1.0.0.1"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"quay.io/oriedge/k8s_gateway"` |  |
| image.tag | string | `"v0.1.8@sha256:4937e28bb5dc4bd9c700a72d28e50d43929b4a9e8f64b4a306346426e6ed01e2"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| probes.liveness.custom | bool | `true` |  |
| probes.liveness.spec.failureThreshold | int | `5` |  |
| probes.liveness.spec.httpGet.path | string | `"/health"` |  |
| probes.liveness.spec.httpGet.port | int | `8080` |  |
| probes.liveness.spec.httpGet.scheme | string | `"HTTP"` |  |
| probes.liveness.spec.initialDelaySeconds | int | `60` |  |
| probes.liveness.spec.successThreshold | int | `1` |  |
| probes.liveness.spec.timeoutSeconds | int | `5` |  |
| probes.readiness.custom | bool | `true` |  |
| probes.readiness.spec.failureThreshold | int | `5` |  |
| probes.readiness.spec.httpGet.path | string | `"/ready"` |  |
| probes.readiness.spec.httpGet.port | int | `8181` |  |
| probes.readiness.spec.httpGet.scheme | string | `"HTTP"` |  |
| probes.readiness.spec.initialDelaySeconds | int | `10` |  |
| probes.readiness.spec.successThreshold | int | `1` |  |
| probes.readiness.spec.timeoutSeconds | int | `5` |  |
| probes.startup.custom | bool | `true` |  |
| probes.startup.spec.failureThreshold | int | `60` |  |
| probes.startup.spec.httpGet.path | string | `"/ready"` |  |
| probes.startup.spec.httpGet.port | int | `8181` |  |
| probes.startup.spec.httpGet.scheme | string | `"HTTP"` |  |
| probes.startup.spec.initialDelaySeconds | int | `3` |  |
| probes.startup.spec.periodSeconds | int | `5` |  |
| probes.startup.spec.timeoutSeconds | int | `2` |  |
| rbac | object | See below | Create a ClusterRole and ClusterRoleBinding |
| rbac.enabled | bool | `true` | Enables or disables the ClusterRole and ClusterRoleBinding |
| rbac.rules | list | `[{"apiGroups":[""],"resources":["services","namespaces"],"verbs":["list","watch"]},{"apiGroups":["extensions","networking.k8s.io"],"resources":["ingresses"],"verbs":["list","watch"]}]` | Set Rules on the ClusterRole |
| secondary | string | `""` | Service name of a secondary DNS server (should be `serviceName.namespace`) |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `53` |  |
| service.main.ports.main.protocol | string | `"UDP"` |  |
| service.main.ports.main.targetPort | int | `53` |  |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| ttl | int | `300` | TTL for non-apex responses (in seconds) |
| watchedResources | list | `[]` | Limit what kind of resources to watch, e.g. watchedResources: ["Ingress"] |

All Rights Reserved - The TrueCharts Project
