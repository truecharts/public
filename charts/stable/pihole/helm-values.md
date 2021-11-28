# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| envFrom[0].configMapRef.name | string | `"pihole-env"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ghcr.io/truecharts/pihole"` |  |
| image.tag | string | `"v2021.10.1@sha256:406a7368955ed3248a924bcb9c578d8554793048e025deb59f03caf6fd3f17c4"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/etc/pihole"` |  |
| persistence.dnsmasq.enabled | bool | `true` |  |
| persistence.dnsmasq.mountPath | string | `"/etc/dnsmasq.d"` |  |
| pihole.DNS1 | string | `"9.9.9.9"` |  |
| pihole.DNS2 | string | `"149.112.112.112"` |  |
| pihole.WEBPASSWORD | string | `"somepassword"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.allowPrivilegeEscalation | bool | `true` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.dns-tcp.enabled | bool | `true` |  |
| service.dns-tcp.ports.dns-tcp.enabled | bool | `true` |  |
| service.dns-tcp.ports.dns-tcp.port | int | `53` |  |
| service.dns-tcp.ports.dns-tcp.targetPort | int | `53` |  |
| service.dns.enabled | bool | `true` |  |
| service.dns.ports.dns.enabled | bool | `true` |  |
| service.dns.ports.dns.port | int | `53` |  |
| service.dns.ports.dns.protocol | string | `"UDP"` |  |
| service.dns.ports.dns.targetPort | int | `53` |  |
| service.main.ports.main.port | int | `9089` |  |
| service.main.ports.main.targetPort | int | `80` |  |

All Rights Reserved - The TrueCharts Project
