# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| command[0] | string | `"sh"` |  |
| command[1] | string | `"-c"` |  |
| command[2] | string | `"exec python -B -m synapse.app.homeserver \\\n            -c /data/homeserver.yaml \\\n            -c /data/secret/secret.yaml \\\n            -c /data/custom.yaml\n"` |  |
| coturn.enabled | bool | `false` |  |
| env | object | `{}` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"matrixdotorg/synapse"` |  |
| image.tag | string | `"v1.55.2"` |  |
| installContainers.generate-signing-key.args[0] | string | `"-m"` |  |
| installContainers.generate-signing-key.args[10] | string | `"--generate-keys"` |  |
| installContainers.generate-signing-key.args[1] | string | `"synapse.app.homeserver"` |  |
| installContainers.generate-signing-key.args[2] | string | `"--config-path"` |  |
| installContainers.generate-signing-key.args[3] | string | `"/data/homeserver.yaml"` |  |
| installContainers.generate-signing-key.args[4] | string | `"--config-path"` |  |
| installContainers.generate-signing-key.args[5] | string | `"/data/secret/secret.yaml"` |  |
| installContainers.generate-signing-key.args[6] | string | `"--config-path"` |  |
| installContainers.generate-signing-key.args[7] | string | `"/data/custom.yaml"` |  |
| installContainers.generate-signing-key.args[8] | string | `"--keys-directory"` |  |
| installContainers.generate-signing-key.args[9] | string | `"/data/keys"` |  |
| installContainers.generate-signing-key.command[0] | string | `"python"` |  |
| installContainers.generate-signing-key.env[0].name | string | `"SYNAPSE_SERVER_NAME"` |  |
| installContainers.generate-signing-key.env[0].value | string | `"{{ .Values.matrix.serverName }}"` |  |
| installContainers.generate-signing-key.env[1].name | string | `"SYNAPSE_REPORT_STATS"` |  |
| installContainers.generate-signing-key.env[1].value | string | `"no"` |  |
| installContainers.generate-signing-key.image | string | `"{{ .Values.image.repository }}:{{ .Values.image.tag }}"` |  |
| installContainers.generate-signing-key.volumeMounts[0].mountPath | string | `"/data"` |  |
| installContainers.generate-signing-key.volumeMounts[0].name | string | `"config"` |  |
| installContainers.generate-signing-key.volumeMounts[1].mountPath | string | `"/data/secret"` |  |
| installContainers.generate-signing-key.volumeMounts[1].name | string | `"secret"` |  |
| installContainers.generate-signing-key.volumeMounts[2].mountPath | string | `"/data/keys"` |  |
| installContainers.generate-signing-key.volumeMounts[2].name | string | `"key"` |  |
| mail.enabled | bool | `false` |  NOTE: If enabled, either enable the Exim relay or configure an external mail server below |
| mail.from | string | `"Matrix <matrix@example.com>"` |  |
| mail.host | string | `""` |  |
| mail.password | string | `""` |  |
| mail.port | int | `25` |  |
| mail.requireTransportSecurity | bool | `true` |  |
| mail.riotUrl | string | `""` |  If the ingress is enabled, this is unnecessary. If the ingress is disabled and this is left unspecified, emails will contain a link to https://app.element.io |
| mail.username | string | `""` |  |
| matrix.adminEmail | string | `"admin@example.com"` |  |
| matrix.blockNonAdminInvites | bool | `false` |  |
| matrix.disabled | bool | `false` |  |
| matrix.disabledMessage | string | `""` |  |
| matrix.encryptByDefault | string | `"invite"` |  off: none invite: private messages, or rooms created with the private_chat or trusted_private_chat room preset all: all rooms |
| matrix.federation.allowPublicRooms | bool | `true` |  |
| matrix.federation.blacklist | list | `["127.0.0.0/8","10.0.0.0/8","172.16.0.0/12","192.168.0.0/16","100.64.0.0/10","169.254.0.0/16","::1/128","fe80::/64","fc00::/7"]` |  whitelist: [] IP addresses to blacklist federation requests to |
| matrix.federation.enabled | bool | `true` |  |
| matrix.logging.rootLogLevel | string | `"WARNING"` |  specific settings. |
| matrix.logging.sqlLogLevel | string | `"WARNING"` |  information such as access tokens. |
| matrix.logging.synapseLogLevel | string | `"WARNING"` |  |
| matrix.presence | bool | `true` |  This is *optional* if an Ingress is configured below. If hostname is unspecified, the Synapse hostname of the Ingress will be used hostname: "matrix.example.com" Set to false to disable presence (online/offline indicators) |
| matrix.registration.allowGuests | bool | `false` |  has the shared secret, even if registration is otherwise disabled. sharedSecret: <PRIVATE STRING> Allow users to join rooms as a guest |
| matrix.registration.autoJoinRooms | list | `[]` |  required3Pids:   - email   - msisdn Rooms to automatically join all new users to |
| matrix.registration.enabled | bool | `false` |  |
| matrix.retentionPeriod | string | `"7d"` |  |
| matrix.search | bool | `true` |  |
| matrix.security.surpressKeyServerWarning | bool | `true` |  trustedKeyServers include 'matrix.org'. See below. Set to false to re-enable the warning. |
| matrix.serverName | string | `"example.com"` |  If homeserverOverride is set, the entirety of homeserver.yaml will be replaced with the contents. If homeserverExtra is set, the contents will be appended to the end of the default configuration. It is highly recommended that you take a look at the defaults in templates/synapse/_homeserver.yaml, to get a sense of the requirements and default configuration options to use other services in this chart. homeserverOverride: {} homeserverExtra: {} Domain name of the server This is not necessarily the host name where the service is reachable. In fact, you may want to omit any subdomains from this value as the server name set here will be the name of your homeserver in the fediverse, and will be the domain name at the end of every user's username |
| matrix.uploads.maxPixels | string | `"32M"` |  |
| matrix.uploads.maxSize | string | `"10M"` |  |
| matrix.urlPreviews.enabled | bool | `false` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/data"` |  |
| persistence.config.objectName | string | `"synapse-config"` |  |
| persistence.config.readOnly | bool | `false` |  |
| persistence.config.type | string | `"configMap"` |  |
| persistence.key.enabled | bool | `true` |  |
| persistence.key.mountPath | string | `"/data/keys"` |  |
| persistence.media.enabled | bool | `true` |  |
| persistence.media.mountPath | string | `"/data/media_store"` |  |
| persistence.secret.enabled | bool | `true` |  |
| persistence.secret.mountPath | string | `"/data/secret"` |  |
| persistence.secret.objectName | string | `"synapse-secret"` |  |
| persistence.secret.readOnly | bool | `false` |  |
| persistence.secret.type | string | `"secret"` |  |
| persistence.uploads.enabled | bool | `true` |  |
| persistence.uploads.mountPath | string | `"/uploads"` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.env.POSTGRES_INITDB_ARGS | string | `"--encoding=UTF8 --locale=C"` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"synapse"` |  |
| postgresql.postgresqlUsername | string | `"synapse"` |  |
| probes.liveness.path | string | `"/health"` |  |
| probes.readiness.path | string | `"/health"` |  |
| probes.startup.path | string | `"/health"` |  |
| secret | object | `{}` |  |
| securityContext.allowPrivilegeEscalation | bool | `true` |  |
| service.federation.enabled | bool | `true` |  |
| service.federation.ports.federation.enabled | bool | `true` |  |
| service.federation.ports.federation.port | int | `8448` |  |
| service.federation.ports.federation.targetPort | int | `8008` |  |
| service.main.ports.main.port | int | `8008` |  |
| service.main.ports.main.targetPort | int | `8008` |  |
| service.metrics.enabled | bool | `true` |  |
| service.metrics.ports.metrics.enabled | bool | `true` |  |
| service.metrics.ports.metrics.port | int | `9093` |  |
| service.metrics.ports.metrics.targetPort | int | `9090` |  |
| service.replication.enabled | bool | `true` |  |
| service.replication.ports.replication.enabled | bool | `true` |  |
| service.replication.ports.replication.port | int | `9092` |  |
| service.replication.ports.replication.targetPort | int | `9092` |  |
| synapse.appConfig | list | `[]` | List of application config .yaml files to be loaded from /appConfig |
| synapse.loadCustomConfig | bool | `false` |  |
| synapse.metrics | object | `{"annotations":true,"enabled":true,"port":9092}` |  https://github.com/matrix-org/synapse/blob/master/docs/metrics-howto.md |

All Rights Reserved - The TrueCharts Project
