# traefik

![Version: 6.13.1](https://img.shields.io/badge/Version-6.13.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.4](https://img.shields.io/badge/AppVersion-2.4-informational?style=flat-square)

A Traefik based Reverse Proxy and Certificate Manager

**Homepage:** <https://github.com/truecharts/apps/tree/master/charts/stable/traefik>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| TrueCharts | info@truecharts.org | truecharts.org |
| Ornias1993 | kjeld@schouten-lebbing.nl | truecharts.org |

## Source Code

* <https://github.com/traefik/traefik>
* <https://github.com/traefik/traefik-helm-chart>
* <https://traefik.io/>

## Requirements

Kubernetes: `>=1.16.0-0`

| Repository | Name | Version |
|------------|------|---------|
| https://truecharts.org/ | common | 6.12.1 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalArguments[0] | string | `"--metrics.prometheus"` |  |
| additionalArguments[1] | string | `"--ping"` |  |
| additionalArguments[2] | string | `"--serverstransport.insecureskipverify=true"` |  |
| additionalVolumeMounts | list | `[]` |  |
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| deployment.additionalContainers | list | `[]` |  |
| deployment.additionalVolumes | list | `[]` |  |
| deployment.annotations | object | `{}` |  |
| deployment.enabled | bool | `true` |  |
| deployment.imagePullSecrets | list | `[]` |  |
| deployment.initContainers | list | `[]` |  |
| deployment.kind | string | `"Deployment"` |  |
| deployment.labels | object | `{}` |  |
| deployment.podAnnotations | object | `{}` |  |
| deployment.podLabels | object | `{}` |  |
| deployment.replicas | int | `1` |  |
| env | list | `[]` |  |
| envFrom | list | `[]` |  |
| experimental.kubernetesGateway.appLabelSelector | string | `"traefik"` |  |
| experimental.kubernetesGateway.certificates | list | `[]` |  |
| experimental.kubernetesGateway.enabled | bool | `false` |  |
| experimental.plugins.enabled | bool | `false` |  |
| globalArguments[0] | string | `"--global.checknewversion"` |  |
| hostNetwork | bool | `false` |  |
| image.name | string | `"traefik"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.tag | string | `"v2.4"` |  |
| ingressClass.enabled | bool | `false` |  |
| ingressClass.fallbackApiVersion | string | `nil` |  |
| ingressClass.isDefaultClass | bool | `false` |  |
| ingressRoute.dashboard.annotations | object | `{}` |  |
| ingressRoute.dashboard.enabled | bool | `true` |  |
| ingressRoute.dashboard.labels | object | `{}` |  |
| logs.access.enabled | bool | `false` |  |
| logs.access.fields.general.defaultmode | string | `"keep"` |  |
| logs.access.fields.general.names | object | `{}` |  |
| logs.access.fields.headers.defaultmode | string | `"drop"` |  |
| logs.access.fields.headers.names | object | `{}` |  |
| logs.access.filters | object | `{}` |  |
| logs.general.level | string | `"INFO"` |  |
| middlewares.basicAuth | list | `[]` |  |
| middlewares.chain | list | `[]` |  |
| middlewares.forwardAuth | list | `[]` |  |
| middlewares.rateLimit | list | `[]` |  |
| middlewares.redirectScheme | list | `[]` |  |
| nodeSelector | object | `{}` |  |
| persistence.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.enabled | bool | `false` |  |
| persistence.name | string | `"data"` |  |
| persistence.path | string | `"/data"` |  |
| persistence.size | string | `"128Mi"` |  |
| pilot.enabled | bool | `false` |  |
| pilot.token | string | `""` |  |
| podDisruptionBudget.enabled | bool | `false` |  |
| podSecurityContext.fsGroup | int | `65532` |  |
| podSecurityPolicy.enabled | bool | `false` |  |
| portalhook.enabled | bool | `true` |  |
| ports.traefik.expose | bool | `false` |  |
| ports.traefik.exposedPort | int | `9000` |  |
| ports.traefik.port | int | `9000` |  |
| ports.traefik.protocol | string | `"TCP"` |  |
| ports.web.expose | bool | `true` |  |
| ports.web.exposedPort | int | `80` |  |
| ports.web.port | int | `9080` |  |
| ports.web.protocol | string | `"TCP"` |  |
| ports.web.redirectTo | string | `"websecure"` |  |
| ports.websecure.expose | bool | `true` |  |
| ports.websecure.exposedPort | int | `443` |  |
| ports.websecure.port | int | `9443` |  |
| ports.websecure.protocol | string | `"TCP"` |  |
| ports.websecure.tls.enabled | bool | `true` |  |
| priorityClassName | string | `""` |  |
| providers.kubernetesCRD.enabled | bool | `true` |  |
| providers.kubernetesCRD.namespaces | list | `[]` |  |
| providers.kubernetesIngress.enabled | bool | `true` |  |
| providers.kubernetesIngress.namespaces | list | `[]` |  |
| providers.kubernetesIngress.publishedService.enabled | bool | `false` |  |
| rbac.enabled | bool | `true` |  |
| rbac.namespaced | bool | `false` |  |
| resources | object | `{}` |  |
| rollingUpdate.maxSurge | int | `1` |  |
| rollingUpdate.maxUnavailable | int | `1` |  |
| securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| securityContext.readOnlyRootFilesystem | bool | `true` |  |
| securityContext.runAsGroup | int | `65532` |  |
| securityContext.runAsNonRoot | bool | `true` |  |
| securityContext.runAsUser | int | `65532` |  |
| service.annotations | object | `{}` |  |
| service.enabled | bool | `true` |  |
| service.externalIPs | list | `[]` |  |
| service.labels | object | `{}` |  |
| service.loadBalancerSourceRanges | list | `[]` |  |
| service.spec | object | `{}` |  |
| service.type | string | `"LoadBalancer"` |  |
| serviceAccount.name | string | `""` |  |
| serviceAccountAnnotations | object | `{}` |  |
| tlsOptions.default.cipherSuites[0] | string | `"TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256"` |  |
| tlsOptions.default.cipherSuites[1] | string | `"TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384"` |  |
| tlsOptions.default.cipherSuites[2] | string | `"TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305"` |  |
| tlsOptions.default.cipherSuites[3] | string | `"TLS_AES_128_GCM_SHA256"` |  |
| tlsOptions.default.cipherSuites[4] | string | `"TLS_AES_256_GCM_SHA384"` |  |
| tlsOptions.default.cipherSuites[5] | string | `"TLS_CHACHA20_POLY1305_SHA256"` |  |
| tlsOptions.default.curvePreferences[0] | string | `"CurveP521"` |  |
| tlsOptions.default.curvePreferences[1] | string | `"CurveP384"` |  |
| tlsOptions.default.minVersion | string | `"VersionTLS12"` |  |
| tlsOptions.default.sniStrict | bool | `false` |  |
| tolerations | list | `[]` |  |
| volumes | list | `[]` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
