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
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"traefik"` |  |
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

All Rights Reserved - The TrueCharts Project
