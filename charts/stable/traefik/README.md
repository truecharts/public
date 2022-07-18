# traefik

![Version: 12.0.23](https://img.shields.io/badge/Version-12.0.23-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.8.1](https://img.shields.io/badge/AppVersion-2.8.1-informational?style=flat-square)

Traefik is a flexible reverse proxy and Ingress Provider.

**Homepage:** <https://github.com/truecharts/apps/tree/master/charts/core/traefik>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| TrueCharts | info@truecharts.org | https://truecharts.org |

## Source Code

* <https://github.com/traefik/traefik>
* <https://github.com/traefik/traefik-helm-chart>
* <https://traefik.io/>

## Requirements

Kubernetes: `>=1.16.0-0`

| Repository | Name | Version |
|------------|------|---------|
| https://library-charts.truecharts.org | common | 10.4.4 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalArguments | list | `["--metrics.prometheus","--ping","--serverstransport.insecureskipverify=true","--providers.kubernetesingress.allowexternalnameservices=true"]` | Additional arguments to be passed at Traefik's binary All available options available on https://docs.traefik.io/reference/static-configuration/cli/ |
| globalArguments[0] | string | `"--global.checknewversion"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/traefik"` |  |
| image.tag | string | `"v2.8.1@sha256:808661df0066e25faf5d776e6d787d6771d093ca4a485bdb05bd359559a5e1a9"` |  |
| ingressClass | object | `{"enabled":false,"fallbackApiVersion":"","isDefaultClass":false}` | Use ingressClass. Ignored if Traefik version < 2.3 / kubernetes < 1.18.x |
| ingressRoute | object | `{"dashboard":{"annotations":{},"enabled":true,"labels":{}}}` | Create an IngressRoute for the dashboard |
| logs | object | `{"access":{"enabled":false,"fields":{"general":{"defaultmode":"keep","names":{}},"headers":{"defaultmode":"drop","names":{}}},"filters":{},"format":"common"},"general":{"format":"common","level":"ERROR"}}` | Logs https://docs.traefik.io/observability/logs/ |
| logs.access.fields | object | `{"general":{"defaultmode":"keep","names":{}},"headers":{"defaultmode":"drop","names":{}}}` |  retryattempts: true minduration: 10ms Fields https://docs.traefik.io/observability/access-logs/#limiting-the-fieldsincluding-headers |
| logs.access.filters | object | `{}` |  This option represents the number of log lines Traefik will keep in memory before writing them to the selected output. In some cases, this option can greatly help performances. bufferingSize: 100 Filtering https://docs.traefik.io/observability/access-logs/#filtering |
| logs.access.format | string | `"common"` | Set the format of Access Logs to be either Common Log Format or JSON. For more information: https://doc.traefik.io/traefik/observability/access-logs/#format |
| logs.general.format | string | `"common"` | Set the format of General Logs to be either Common Log Format or JSON. For more information: https://doc.traefik.io/traefik/observability/logs/#format |
| metrics.prometheus | object | `{"entryPoint":"metrics"}` |    address: 127.0.0.1:8125 influxdb:   address: localhost:8089   protocol: udp |
| middlewares | object | `{"basicAuth":[],"chain":[],"forwardAuth":[],"ipWhiteList":[],"rateLimit":[],"redirectRegex":[],"redirectScheme":[],"stripPrefixRegex":[]}` | SCALE Middleware Handlers |
| middlewares.chain | list | `[]` |    address: https://auth.example.com/   authResponseHeaders:     - X-Secret     - X-Auth-User   authRequestHeaders:     - "Accept"     - "X-CustomHeader"   authResponseHeadersRegex: "^X-"   trustForwardHeader: true |
| middlewares.forwardAuth | list | `[]` |    users:     - username: testuser       password: testpassword |
| middlewares.ipWhiteList | list | `[]` |    regex: [] |
| middlewares.rateLimit | list | `[]` |    scheme: https   permanent: true |
| middlewares.redirectRegex | list | `[]` |    average: 300   burst: 200 |
| middlewares.redirectScheme | list | `[]` |    middlewares:    - name: compress |
| middlewares.stripPrefixRegex | list | `[]` |    regex: putregexhere   replacement: repslacementurlhere   permanent: false |
| pilot | object | `{"enabled":false,"token":""}` | Activate Pilot integration |
| podAnnotations."prometheus.io/path" | string | `"/metrics"` |  |
| podAnnotations."prometheus.io/port" | string | `"9180"` |  |
| podAnnotations."prometheus.io/scrape" | string | `"true"` |  |
| portalhook.enabled | bool | `true` |  |
| providers | object | `{"kubernetesCRD":{"enabled":true,"namespaces":[]},"kubernetesIngress":{"enabled":true,"namespaces":[],"publishedService":{"enabled":true}}}` | Configure providers |
| providers.kubernetesIngress.publishedService | object | `{"enabled":true}` |  IP used for Kubernetes Ingress endpoints |
| rbac.main.enabled | bool | `true` |  |
| rbac.main.rules[0].apiGroups[0] | string | `""` |  |
| rbac.main.rules[0].resources[0] | string | `"services"` |  |
| rbac.main.rules[0].resources[1] | string | `"endpoints"` |  |
| rbac.main.rules[0].resources[2] | string | `"secrets"` |  |
| rbac.main.rules[0].verbs[0] | string | `"get"` |  |
| rbac.main.rules[0].verbs[1] | string | `"list"` |  |
| rbac.main.rules[0].verbs[2] | string | `"watch"` |  |
| rbac.main.rules[1].apiGroups[0] | string | `"extensions"` |  |
| rbac.main.rules[1].apiGroups[1] | string | `"networking.k8s.io"` |  |
| rbac.main.rules[1].resources[0] | string | `"ingresses"` |  |
| rbac.main.rules[1].resources[1] | string | `"ingressclasses"` |  |
| rbac.main.rules[1].verbs[0] | string | `"get"` |  |
| rbac.main.rules[1].verbs[1] | string | `"list"` |  |
| rbac.main.rules[1].verbs[2] | string | `"watch"` |  |
| rbac.main.rules[2].apiGroups[0] | string | `"extensions"` |  |
| rbac.main.rules[2].apiGroups[1] | string | `"networking.k8s.io"` |  |
| rbac.main.rules[2].resources[0] | string | `"ingresses/status"` |  |
| rbac.main.rules[2].verbs[0] | string | `"update"` |  |
| rbac.main.rules[3].apiGroups[0] | string | `"traefik.containo.us"` |  |
| rbac.main.rules[3].resources[0] | string | `"ingressroutes"` |  |
| rbac.main.rules[3].resources[1] | string | `"ingressroutetcps"` |  |
| rbac.main.rules[3].resources[2] | string | `"ingressrouteudps"` |  |
| rbac.main.rules[3].resources[3] | string | `"middlewares"` |  |
| rbac.main.rules[3].resources[4] | string | `"middlewaretcps"` |  |
| rbac.main.rules[3].resources[5] | string | `"tlsoptions"` |  |
| rbac.main.rules[3].resources[6] | string | `"tlsstores"` |  |
| rbac.main.rules[3].resources[7] | string | `"traefikservices"` |  |
| rbac.main.rules[3].resources[8] | string | `"serverstransports"` |  |
| rbac.main.rules[3].verbs[0] | string | `"get"` |  |
| rbac.main.rules[3].verbs[1] | string | `"list"` |  |
| rbac.main.rules[3].verbs[2] | string | `"watch"` |  |
| service | object | `{"main":{"ports":{"main":{"forwardedHeaders":{"enabled":false},"port":9000,"protocol":"HTTP","targetPort":9000}},"type":"LoadBalancer"},"metrics":{"enabled":true,"ports":{"metrics":{"enabled":true,"forwardedHeaders":{"enabled":false},"port":9180,"protocol":"HTTP","targetPort":9180}},"type":"ClusterIP"},"tcp":{"enabled":true,"ports":{"web":{"enabled":true,"forwardedHeaders":{"enabled":false,"insecureMode":false,"trustedIPs":[]},"port":9080,"protocol":"HTTP","redirectTo":"websecure"},"websecure":{"enabled":true,"forwardedHeaders":{"enabled":false,"insecureMode":false,"trustedIPs":[]},"port":9443,"protocol":"HTTPS"}},"type":"LoadBalancer"},"udp":{"enabled":false}}` | Options for the main traefik service, where the entrypoints traffic comes from from. |
| service.main.ports.main.forwardedHeaders | object | `{"enabled":false}` | Forwarded Headers should never be enabled on Main entrypoint |
| service.metrics.ports.metrics.forwardedHeaders | object | `{"enabled":false}` | Forwarded Headers should never be enabled on Metrics entrypoint |
| service.tcp.ports.web.forwardedHeaders | object | `{"enabled":false,"insecureMode":false,"trustedIPs":[]}` | Configure (Forwarded Headers)[https://doc.traefik.io/traefik/routing/entrypoints/#forwarded-headers] Support |
| service.tcp.ports.web.forwardedHeaders.insecureMode | bool | `false` | Trust all forwarded headers |
| service.tcp.ports.web.forwardedHeaders.trustedIPs | list | `[]` | List of trusted IP and CIDR references |
| service.tcp.ports.websecure.forwardedHeaders | object | `{"enabled":false,"insecureMode":false,"trustedIPs":[]}` | Configure (Forwarded Headers)[https://doc.traefik.io/traefik/routing/entrypoints/#forwarded-headers] Support |
| service.tcp.ports.websecure.forwardedHeaders.insecureMode | bool | `false` | Trust all forwarded headers |
| service.tcp.ports.websecure.forwardedHeaders.trustedIPs | list | `[]` | List of trusted IP and CIDR references |
| serviceAccount | object | `{"main":{"create":true}}` | The service account the pods will use to interact with the Kubernetes API |
| tlsOptions | object | `{"default":{"cipherSuites":["TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256","TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384","TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305","TLS_AES_128_GCM_SHA256","TLS_AES_256_GCM_SHA384","TLS_CHACHA20_POLY1305_SHA256"],"curvePreferences":["CurveP521","CurveP384"],"minVersion":"VersionTLS12","sniStrict":false}}` | TLS Options to be created as TLSOption CRDs https://doc.traefik.io/tccr.io/truecharts/https/tls/#tls-options Example: |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v0.1.1](https://github.com/k8s-at-home/helm-docs/releases/v0.1.1)
