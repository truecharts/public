# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalArguments[0] | string | `"--metrics.prometheus"` |  |
| additionalArguments[1] | string | `"--ping"` |  |
| additionalArguments[2] | string | `"--serverstransport.insecureskipverify=true"` |  |
| additionalArguments[3] | string | `"--providers.kubernetesingress.allowexternalnameservices=true"` |  |
| globalArguments[0] | string | `"--global.checknewversion"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"traefik"` |  |
| image.tag | string | `"v2.5.4@sha256:7d0228d19042f1286765f0ef56ceba8e4e8a08ae9b45b854179cf09a9c3de633"` |  |
| ingressClass | object | `{"enabled":false,"fallbackApiVersion":"","isDefaultClass":false}` | Use ingressClass. Ignored if Traefik version < 2.3 / kubernetes < 1.18.x |
| ingressRoute | object | `{"dashboard":{"annotations":{},"enabled":true,"labels":{}}}` | Create an IngressRoute for the dashboard |
| logs | object | `{"access":{"enabled":false,"fields":{"general":{"defaultmode":"keep","names":{}},"headers":{"defaultmode":"drop","names":{}}},"filters":{}},"general":{"level":"ERROR"}}` | Logs https://docs.traefik.io/observability/logs/ |
| metrics.prometheus.entryPoint | string | `"metrics"` |  |
| middlewares | object | `{"basicAuth":[],"chain":[],"forwardAuth":[],"ipWhiteList":[],"rateLimit":[],"redirectRegex":[],"redirectScheme":[]}` | SCALE Middleware Handlers |
| pilot | object | `{"enabled":false,"token":""}` | Activate Pilot integration |
| portalhook.enabled | bool | `true` |  |
| probes.liveness | object | See below | Liveness probe configuration |
| probes.liveness.path | string | "/" | If a HTTP probe is used (default for HTTP/HTTPS services) this path is used |
| probes.liveness.type | string | "TCP" | sets the probe type when not using a custom probe |
| probes.readiness | object | See below | Redainess probe configuration |
| probes.readiness.path | string | "/" | If a HTTP probe is used (default for HTTP/HTTPS services) this path is used |
| probes.readiness.type | string | "TCP" | sets the probe type when not using a custom probe |
| probes.startup | object | See below | Startup probe configuration |
| probes.startup.path | string | "/" | If a HTTP probe is used (default for HTTP/HTTPS services) this path is used |
| probes.startup.type | string | "TCP" | sets the probe type when not using a custom probe |
| providers.kubernetesCRD.enabled | bool | `true` |  |
| providers.kubernetesCRD.namespaces | list | `[]` |  |
| providers.kubernetesIngress.enabled | bool | `true` |  |
| providers.kubernetesIngress.namespaces | list | `[]` |  |
| providers.kubernetesIngress.publishedService.enabled | bool | `true` |  |
| rbac | object | `{"enabled":true,"rules":[{"apiGroups":[""],"resources":["services","endpoints","secrets"],"verbs":["get","list","watch"]},{"apiGroups":["extensions","networking.k8s.io"],"resources":["ingresses","ingressclasses"],"verbs":["get","list","watch"]},{"apiGroups":["extensions","networking.k8s.io"],"resources":["ingresses/status"],"verbs":["update"]},{"apiGroups":["traefik.containo.us"],"resources":["ingressroutes","ingressroutetcps","ingressrouteudps","middlewares","middlewaretcps","tlsoptions","tlsstores","traefikservices","serverstransports"],"verbs":["get","list","watch"]}]}` | Whether Role Based Access Control objects like roles and rolebindings should be created |
| service | object | `{"main":{"ports":{"main":{"port":9000,"protocol":"HTTP","targetPort":9000}},"type":"LoadBalancer"},"metrics":{"enabled":true,"ports":{"metrics":{"enabled":true,"port":9100,"protocol":"HTTP","targetPort":9100}},"type":"LoadBalancer"},"tcp":{"enabled":true,"ports":{"web":{"enabled":true,"port":9080,"protocol":"HTTP","redirectTo":"websecure"},"websecure":{"enabled":true,"port":9443,"protocol":"HTTPS"}},"type":"LoadBalancer"},"udp":{"enabled":false}}` | Options for the main traefik service, where the entrypoints traffic comes from from. |
| serviceAccount | object | `{"create":true}` | The service account the pods will use to interact with the Kubernetes API |
| tlsOptions | object | `{"default":{"cipherSuites":["TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256","TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384","TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305","TLS_AES_128_GCM_SHA256","TLS_AES_256_GCM_SHA384","TLS_CHACHA20_POLY1305_SHA256"],"curvePreferences":["CurveP521","CurveP384"],"minVersion":"VersionTLS12","sniStrict":false}}` | TLS Options to be created as TLSOption CRDs https://doc.traefik.io/traefik/https/tls/#tls-options Example: |

All Rights Reserved - The TrueCharts Project
