# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| database.type | string | `"postgresql"` |  |
| database.wal | bool | `true` |  |
| env | object | `{}` |  |
| envFrom[0].configMapRef.name | string | `"vaultwardenconfig"` |  |
| envFrom[1].secretRef.name | string | `"vaultwardensecret"` |  |
| envTpl.DOMAIN | string | `"https://{{ if .Values.ingress }}{{ if .Values.ingress.main.enabled }}{{ ( index .Values.ingress.main.hosts 0 ).host }}{{ else }}placeholder.com{{ end }}{{ else }}placeholder.com{{ end }}"` |  |
| envValueFrom.DATABASE_URL.secretKeyRef.key | string | `"url"` |  |
| envValueFrom.DATABASE_URL.secretKeyRef.name | string | `"dbcreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"vaultwarden/server"` |  |
| image.tag | string | `"1.22.2"` |  |
| ingress | object | See below | Configure the ingresses for the chart here. Additional ingresses can be added by adding a dictionary key similar to the 'main' ingress. |
| ingress.main.enabled | bool | `true` | Enables or disables the ingress |
| ingress.main.fixedMiddlewares | list | `["chain-basic"]` | List of middlewares in the traefikmiddlewares k8s namespace to add automatically Creates an annotation with the middlewares and appends k8s and traefik namespaces to the middleware names Primarily used for TrueNAS SCALE to add additional (seperate) middlewares without exposing them to the end-user |
| ingress.main.hosts[0].host | string | `"chart-example.local"` | Host address. Helm template can be passed. |
| ingress.main.hosts[0].paths[0].path | string | `"/"` | Path.  Helm template can be passed. |
| ingress.main.hosts[0].paths[0].pathType | string | `"Prefix"` | Ignored if not kubeVersion >= 1.14-0 |
| ingress.main.hosts[0].paths[0].service.name | string | `nil` | Overrides the service name reference for this path |
| ingress.main.hosts[0].paths[0].service.port | string | `nil` | Overrides the service port reference for this path |
| ingress.main.ingressClassName | string | `nil` | Set the ingressClass that is used for this ingress. Requires Kubernetes >=1.19 |
| ingress.main.middlewares | list | `[]` | Additional List of middlewares in the traefikmiddlewares k8s namespace to add automatically Creates an annotation with the middlewares and appends k8s and traefik namespaces to the middleware names |
| ingress.main.nameOverride | string | `nil` | Override the name suffix that is used for this ingress. |
| ingress.main.primary | bool | `true` | Make this the primary ingress (used in probes, notes, etc...). If there is more than 1 ingress, make sure that only 1 ingress is marked as primary. |
| ingress.main.tls | list | `[]` | Configure TLS for the ingress. Both secretName and hosts can process a Helm template. |
| initContainers.init-postgresdb.command[0] | string | `"sh"` |  |
| initContainers.init-postgresdb.command[1] | string | `"-c"` |  |
| initContainers.init-postgresdb.command[2] | string | `"until pg_isready -U authelia -h ${pghost} ; do sleep 2 ; done"` |  |
| initContainers.init-postgresdb.env[0].name | string | `"pghost"` |  |
| initContainers.init-postgresdb.env[0].valueFrom.secretKeyRef.key | string | `"plainhost"` |  |
| initContainers.init-postgresdb.env[0].valueFrom.secretKeyRef.name | string | `"dbcreds"` |  |
| initContainers.init-postgresdb.image | string | `"postgres:13.1"` |  |
| initContainers.init-postgresdb.imagePullPolicy | string | `"IfNotPresent"` |  |
| persistence.data.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/data"` |  |
| persistence.data.size | string | `"100Gi"` |  |
| persistence.data.type | string | `"pvc"` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"vaultwarden"` |  |
| postgresql.postgresqlUsername | string | `"vaultwarden"` |  |
| service.main.ports.main.port | int | `8080` |  |
| service.ws.ports.ws.enabled | bool | `true` |  |
| service.ws.ports.ws.port | int | `3012` |  |
| strategy.type | string | `"Recreate"` |  |
| vaultwarden.admin.disableAdminToken | bool | `false` |  |
| vaultwarden.admin.enabled | bool | `false` |  |
| vaultwarden.allowInvitation | bool | `true` |  |
| vaultwarden.allowSignups | bool | `true` |  |
| vaultwarden.enableWebVault | bool | `true` |  |
| vaultwarden.enableWebsockets | bool | `true` |  |
| vaultwarden.icons.disableDownload | bool | `false` |  |
| vaultwarden.log.file | string | `""` |  |
| vaultwarden.log.level | string | `"trace"` |  |
| vaultwarden.orgCreationUsers | string | `"all"` |  |
| vaultwarden.requireEmail | bool | `false` |  |
| vaultwarden.showPasswordHint | bool | `true` |  |
| vaultwarden.smtp.enabled | bool | `false` |  |
| vaultwarden.smtp.from | string | `""` |  |
| vaultwarden.smtp.host | string | `""` |  |
| vaultwarden.verifySignup | bool | `false` |  |
| vaultwarden.yubico.enabled | bool | `false` |  |

All Rights Reserved - The TrueCharts Project
