# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalArguments | list | `["--metrics.prometheus","--ping","--serverstransport.insecureskipverify=true","--providers.kubernetesingress.allowexternalnameservices=true"]` | Additional arguments to be passed at Traefik's binary All available options available on https://docs.traefik.io/reference/static-configuration/cli/ |
| globalArguments[0] | string | `"--global.checknewversion"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/traefik"` |  |
| image.tag | string | `"v2.6.3@sha256:fab794392ae3e63eef4009b97dfbd57fda9806b70b36333bc502a0ef72838852"` |  |
| ingressClass | object | `{"enabled":false,"fallbackApiVersion":"","isDefaultClass":false}` | Use ingressClass. Ignored if Traefik version < 2.3 / kubernetes < 1.18.x |
| ingressRoute | object | `{"dashboard":{"annotations":{},"enabled":true,"labels":{}}}` | Create an IngressRoute for the dashboard |
| logs | object | `{"access":{"enabled":false,"fields":{"general":{"defaultmode":"keep","names":{}},"headers":{"defaultmode":"drop","names":{}}},"filters":{}},"general":{"level":"ERROR"}}` | Logs https://docs.traefik.io/observability/logs/ |
| logs.access.fields | object | `{"general":{"defaultmode":"keep","names":{}},"headers":{"defaultmode":"drop","names":{}}}` |  retryattempts: true minduration: 10ms Fields https://docs.traefik.io/observability/access-logs/#limiting-the-fieldsincluding-headers |
| logs.access.filters | object | `{}` |  To write logs in JSON, use json in the format option. If the given format is unsupported, the default (CLF) is used instead. format: json To write the logs in an asynchronous fashion, specify a bufferingSize option. This option represents the number of log lines Traefik will keep in memory before writing them to the selected output. In some cases, this option can greatly help performances. bufferingSize: 100 Filtering https://docs.traefik.io/observability/access-logs/#filtering |
| logs.general.level | string | `"ERROR"` |  also ask for the json format in the format option format: json By default, the level is set to ERROR. Alternative logging levels are DEBUG, PANIC, FATAL, ERROR, WARN, and INFO. |
| metrics.prometheus | object | `{"entryPoint":"metrics"}` |    address: 127.0.0.1:8125 influxdb:   address: localhost:8089   protocol: udp |
| middlewares | object | `{"basicAuth":[],"chain":[],"forwardAuth":[],"ipWhiteList":[],"rateLimit":[],"redirectRegex":[],"redirectScheme":[],"stripPrefixRegex":[]}` | SCALE Middleware Handlers |
| middlewares.chain | list | `[]` |    address: https://auth.example.com/   authResponseHeaders:     - X-Secret     - X-Auth-User   authRequestHeaders:     - "Accept"     - "X-CustomHeader"   authResponseHeadersRegex: "^X-"   trustForwardHeader: true |
| middlewares.forwardAuth | list | `[]` |    users:     - username: testuser       password: testpassword |
| middlewares.ipWhiteList | list | `[]` |    regex: [] |
| middlewares.rateLimit | list | `[]` |    scheme: https   permanent: true |
| middlewares.redirectRegex | list | `[]` |    average: 300   burst: 200 |
| middlewares.redirectScheme | list | `[]` |    middlewares:    - name: compress |
| middlewares.stripPrefixRegex | list | `[]` |    regex: putregexhere   replacement: replacementurlhere   permanent: false |
| pilot | object | `{"enabled":false,"token":""}` | Activate Pilot integration |
| podAnnotations."prometheus.io/path" | string | `"/metrics"` |  |
| podAnnotations."prometheus.io/port" | string | `"9180"` |  |
| podAnnotations."prometheus.io/scrape" | string | `"true"` |  |
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
| providers | object | `{"kubernetesCRD":{"enabled":true,"namespaces":[]},"kubernetesIngress":{"enabled":true,"namespaces":[],"publishedService":{"enabled":true}}}` | Configure providers |
| providers.kubernetesIngress.publishedService | object | `{"enabled":true}` |  IP used for Kubernetes Ingress endpoints |
| rbac | object | `{"enabled":true,"rules":[{"apiGroups":[""],"resources":["services","endpoints","secrets"],"verbs":["get","list","watch"]},{"apiGroups":["extensions","networking.k8s.io"],"resources":["ingresses","ingressclasses"],"verbs":["get","list","watch"]},{"apiGroups":["extensions","networking.k8s.io"],"resources":["ingresses/status"],"verbs":["update"]},{"apiGroups":["traefik.containo.us"],"resources":["ingressroutes","ingressroutetcps","ingressrouteudps","middlewares","middlewaretcps","tlsoptions","tlsstores","traefikservices","serverstransports"],"verbs":["get","list","watch"]}]}` | Whether Role Based Access Control objects like roles and rolebindings should be created |
| service | object | `{"main":{"ports":{"main":{"port":9000,"protocol":"HTTP","targetPort":9000}},"type":"LoadBalancer"},"metrics":{"enabled":true,"ports":{"metrics":{"enabled":true,"port":9180,"protocol":"HTTP","targetPort":9180}},"type":"ClusterIP"},"tcp":{"enabled":true,"ports":{"web":{"enabled":true,"port":9080,"protocol":"HTTP","redirectTo":"websecure"},"websecure":{"enabled":true,"port":9443,"protocol":"HTTPS"}},"type":"LoadBalancer"},"udp":{"enabled":false}}` | Options for the main traefik service, where the entrypoints traffic comes from from. |
| serviceAccount | object | `{"create":true}` | The service account the pods will use to interact with the Kubernetes API |
| tlsOptions | object | `{"default":{"cipherSuites":["TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256","TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384","TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305","TLS_AES_128_GCM_SHA256","TLS_AES_256_GCM_SHA384","TLS_CHACHA20_POLY1305_SHA256"],"curvePreferences":["CurveP521","CurveP384"],"minVersion":"VersionTLS12","sniStrict":false}}` | TLS Options to be created as TLSOption CRDs https://doc.traefik.io/tccr.io/truecharts/https/tls/#tls-options Example: |

All Rights Reserved - The TrueCharts Project
