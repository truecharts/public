# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.DNS_SERVER_ALLOW_TXT_BLOCKING_REPORT | bool | `false` |  |
| env.DNS_SERVER_DOMAIN | string | `"dns-server"` |  |
| env.DNS_SERVER_ENABLE_BLOCKING | bool | `false` |  |
| env.DNS_SERVER_FORWARDERS | string | `"1.1.1.1, 8.8.8.8"` |  |
| env.DNS_SERVER_FORWARDER_PROTOCOL | string | `"Tcp"` |  |
| env.DNS_SERVER_OPTIONAL_PROTOCOL_DNS_OVER_HTTP | bool | `false` |  |
| env.DNS_SERVER_PREFER_IPV6 | bool | `false` |  |
| env.DNS_SERVER_RECURSION | string | `"AllowOnlyForPrivateNetworks"` |  |
| env.DNS_SERVER_RECURSION_ALLOWED_NETWORKS | string | `"127.0.0.1, 192.168.1.0/24"` |  |
| env.DNS_SERVER_RECURSION_DENIED_NETWORKS | string | `"1.1.1.0/24"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/technitium"` |  |
| image.tag | string | `"v8.0@sha256:b59d697bde5613f3c183666e373f80dcf2578d310cd84920dcb1ce97748bf394"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/etc/dns/config"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| secret.DNS_SERVER_ADMIN_PASSWORD | string | `"password"` |  |
| securityContext.allowPrivilegeEscalation | bool | `true` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.dns-cert.enabled | bool | `true` |  |
| service.dns-cert.ports.dns-cert.enabled | bool | `true` |  |
| service.dns-cert.ports.dns-cert.port | int | `10202` |  |
| service.dns-cert.ports.dns-cert.protocol | string | `"TCP"` |  |
| service.dns-cert.ports.dns-cert.targetPort | int | `80` |  |
| service.dns-https-proxy.enabled | bool | `true` |  |
| service.dns-https-proxy.ports.dns-https-proxy.enabled | bool | `true` |  |
| service.dns-https-proxy.ports.dns-https-proxy.port | int | `10204` |  |
| service.dns-https-proxy.ports.dns-https-proxy.protocol | string | `"TCP"` |  |
| service.dns-https-proxy.ports.dns-https-proxy.targetPort | int | `8053` |  |
| service.dns-https.enabled | bool | `true` |  |
| service.dns-https.ports.dns-https.enabled | bool | `true` |  |
| service.dns-https.ports.dns-https.port | int | `10203` |  |
| service.dns-https.ports.dns-https.protocol | string | `"TCP"` |  |
| service.dns-https.ports.dns-https.targetPort | int | `443` |  |
| service.dns-tcp.enabled | bool | `true` |  |
| service.dns-tcp.ports.dns-tcp.enabled | bool | `true` |  |
| service.dns-tcp.ports.dns-tcp.port | int | `53` |  |
| service.dns-tcp.ports.dns-tcp.targetPort | int | `53` |  |
| service.dns-tls.enabled | bool | `true` |  |
| service.dns-tls.ports.dns-tls.enabled | bool | `true` |  |
| service.dns-tls.ports.dns-tls.port | int | `853` |  |
| service.dns-tls.ports.dns-tls.protocol | string | `"TCP"` |  |
| service.dns-tls.ports.dns-tls.targetPort | int | `853` |  |
| service.dns-udp.enabled | bool | `true` |  |
| service.dns-udp.ports.dns-udp.enabled | bool | `true` |  |
| service.dns-udp.ports.dns-udp.port | int | `53` |  |
| service.dns-udp.ports.dns-udp.protocol | string | `"UDP"` |  |
| service.dns-udp.ports.dns-udp.targetPort | int | `53` |  |
| service.main.ports.main.port | int | `5380` |  |
| service.main.ports.main.targetPort | int | `5380` |  |

All Rights Reserved - The TrueCharts Project
