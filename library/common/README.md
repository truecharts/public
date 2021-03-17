# common

![Version: 1.3.0](https://img.shields.io/badge/Version-1.3.0-informational?style=flat-square) ![Type: library](https://img.shields.io/badge/Type-library-informational?style=flat-square)

Function library for TrueCharts

**Homepage:** <https://github.com/truecharts/apps/tree/master/common>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| truecharts |  |  |

## Requirements

Kubernetes: `>=1.16.0-0`

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| PGID | int | `568` |  |
| PUID | int | `568` |  |
| UMASK | string | `"002"` |  |
| additionalContainers | list | `[]` |  |
| additionalVolumeMounts | list | `[]` |  |
| additionalVolumes | list | `[]` |  |
| addons.codeserver.args[0] | string | `"--auth"` |  |
| addons.codeserver.args[1] | string | `"none"` |  |
| addons.codeserver.enabled | bool | `false` |  |
| addons.codeserver.env | object | `{}` |  |
| addons.codeserver.image.pullPolicy | string | `"IfNotPresent"` |  |
| addons.codeserver.image.repository | string | `"codercom/code-server"` |  |
| addons.codeserver.image.tag | string | `"3.7.4"` |  |
| addons.codeserver.ingress.annotations | object | `{}` |  |
| addons.codeserver.ingress.enabled | bool | `false` |  |
| addons.codeserver.ingress.hosts[0].host | string | `"code.chart-example.local"` |  |
| addons.codeserver.ingress.hosts[0].paths[0].path | string | `"/"` |  |
| addons.codeserver.ingress.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| addons.codeserver.ingress.labels | object | `{}` |  |
| addons.codeserver.ingress.nameSuffix | string | `"codeserver"` |  |
| addons.codeserver.ingress.tls | list | `[]` |  |
| addons.codeserver.securityContext.runAsUser | int | `0` |  |
| addons.codeserver.service.annotations | object | `{}` |  |
| addons.codeserver.service.enabled | bool | `true` |  |
| addons.codeserver.service.labels | object | `{}` |  |
| addons.codeserver.service.port.name | string | `"codeserver"` |  |
| addons.codeserver.service.port.port | int | `12321` |  |
| addons.codeserver.service.port.protocol | string | `"TCP"` |  |
| addons.codeserver.service.port.targetPort | string | `"codeserver"` |  |
| addons.codeserver.service.type | string | `"ClusterIP"` |  |
| addons.codeserver.volumeMounts | list | `[]` |  |
| addons.codeserver.workingDir | string | `""` |  |
| addons.vpn.additionalVolumeMounts | list | `[]` |  |
| addons.vpn.configFile | string | `nil` |  |
| addons.vpn.enabled | bool | `false` |  |
| addons.vpn.env | object | `{}` |  |
| addons.vpn.livenessProbe | object | `{}` |  |
| addons.vpn.networkPolicy.egress | string | `nil` |  |
| addons.vpn.networkPolicy.enabled | bool | `false` |  |
| addons.vpn.openvpn.auth | string | `nil` |  |
| addons.vpn.openvpn.authSecret | string | `nil` |  |
| addons.vpn.openvpn.image.pullPolicy | string | `"IfNotPresent"` |  |
| addons.vpn.openvpn.image.repository | string | `"dperson/openvpn-client"` |  |
| addons.vpn.openvpn.image.tag | string | `"latest"` |  |
| addons.vpn.scripts.down | string | `nil` |  |
| addons.vpn.scripts.up | string | `nil` |  |
| addons.vpn.securityContext.capabilities.add[0] | string | `"NET_ADMIN"` |  |
| addons.vpn.securityContext.capabilities.add[1] | string | `"SYS_MODULE"` |  |
| addons.vpn.type | string | `"openvpn"` |  |
| addons.vpn.wireguard.image.pullPolicy | string | `"IfNotPresent"` |  |
| addons.vpn.wireguard.image.repository | string | `"k8sathome/wireguard"` |  |
| addons.vpn.wireguard.image.tag | string | `"1.0.20200827"` |  |
| affinity | object | `{}` |  |
| args | list | `[]` |  |
| command | list | `[]` |  |
| controllerAnnotations | object | `{}` |  |
| controllerLabels | object | `{}` |  |
| controllerType | string | `"deployment"` |  |
| dnsPolicy | string | `"ClusterFirst"` |  |
| enableServiceLinks | bool | `true` |  |
| env | object | `{}` |  |
| envFrom | list | `[]` |  |
| envTpl | object | `{}` |  |
| envValueFrom | object | `{}` |  |
| fixMountPermissions | bool | `true` |  |
| fullnameOverride | string | `""` |  |
| hostAliases | list | `[]` |  |
| hostNetwork | bool | `false` |  |
| ingress.additionalIngresses | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"chart-example.local"` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| ingress.labels | object | `{}` |  |
| ingress.tls | list | `[]` |  |
| initContainers | list | `[]` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| persistence.config.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.config.enabled | bool | `false` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| persistence.config.size | string | `"1Gi"` |  |
| persistence.config.skipuninstall | bool | `false` |  |
| persistence.shared.emptyDir | bool | `true` |  |
| persistence.shared.enabled | bool | `false` |  |
| persistence.shared.mountPath | string | `"/shared"` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| probes.liveness.custom | bool | `false` |  |
| probes.liveness.enabled | bool | `true` |  |
| probes.liveness.spec.failureThreshold | int | `5` |  |
| probes.liveness.spec.initialDelaySeconds | int | `30` |  |
| probes.liveness.spec.periodSeconds | int | `10` |  |
| probes.liveness.spec.timeoutSeconds | int | `10` |  |
| probes.readiness.custom | bool | `false` |  |
| probes.readiness.enabled | bool | `true` |  |
| probes.readiness.spec.failureThreshold | int | `5` |  |
| probes.readiness.spec.initialDelaySeconds | int | `30` |  |
| probes.readiness.spec.periodSeconds | int | `10` |  |
| probes.readiness.spec.timeoutSeconds | int | `10` |  |
| probes.startup.custom | bool | `false` |  |
| probes.startup.enabled | bool | `true` |  |
| probes.startup.spec.failureThreshold | int | `30` |  |
| probes.startup.spec.initialDelaySeconds | int | `5` |  |
| probes.startup.spec.periodSeconds | int | `10` |  |
| probes.startup.spec.timeoutSeconds | int | `10` |  |
| replicas | int | `1` |  |
| resources | object | `{}` |  |
| securityContext | object | `{}` |  |
| service.additionalPorts | list | `[]` |  |
| service.additionalServices | list | `[]` |  |
| service.annotations | object | `{}` |  |
| service.enabled | bool | `true` |  |
| service.labels | object | `{}` |  |
| service.port.name | string | `nil` |  |
| service.port.port | string | `nil` |  |
| service.port.protocol | string | `"TCP"` |  |
| service.port.targetPort | string | `nil` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `false` |  |
| serviceAccount.name | string | `""` |  |
| strategy.type | string | `"RollingUpdate"` |  |
| tolerations | list | `[]` |  |
| volumeClaimTemplates | list | `[]` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
