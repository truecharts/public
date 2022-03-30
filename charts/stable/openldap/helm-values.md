# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| controller.replicas | int | `1` | Number of desired pods |
| controller.revisionHistoryLimit | int | `3` | ReplicaSet revision history limit |
| controller.rollingUpdate.partition | string | `nil` | Set statefulset RollingUpdate partition |
| controller.rollingUpdate.surge | string | `nil` | Set deployment RollingUpdate max surge |
| controller.rollingUpdate.unavailable | int | `1` | Set deployment RollingUpdate max unavailable |
| controller.strategy | string | `"RollingUpdate"` | Set the controller upgrade strategy For Deployments, valid values are Recreate (default) and RollingUpdate. For StatefulSets, valid values are OnDelete and RollingUpdate (default). DaemonSets ignore this. |
| controller.type | string | `"statefulset"` | Set the controller type. Valid options are deployment, daemonset or statefulset |
| env | object | `{"CONTAINER_LOG_LEVEL":4,"KEEP_EXISTING_CONFIG":false,"LDAP_BACKEND":"mdb","LDAP_DOMAIN":"example.org","LDAP_LOG_LEVEL":256,"LDAP_ORGANISATION":"Example Inc.","LDAP_READONLY_USER":false,"LDAP_REMOVE_CONFIG_AFTER_SETUP":true,"LDAP_RFC2307BIS_SCHEMA":false,"LDAP_SSL_HELPER_PREFIX":"ldap","LDAP_TLS":true,"LDAP_TLS_CIPHER_SUITE":"NORMAL","LDAP_TLS_ENFORCE":false,"LDAP_TLS_PROTOCOL_MIN":"3.0","LDAP_TLS_REQCERT":"never","LDAP_TLS_VERIFY_CLIENT":"never"}` |  Use the env variables from https://github.com/osixia/docker-openldap#beginner-guide |
| envFrom[0].configMapRef.name | string | `"openldapconfig"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/openldap"` |  |
| image.tag | string | `"v1.5.0@sha256:0260d37c41f0c1207aaa642d7c786851385471a5ddf02bc6efc178241ddd8706"` |  |
| persistence.varrun.enabled | bool | `false` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| replication.clusterName | string | `"cluster.local"` |  |
| replication.enabled | bool | `false` |  |
| replication.interval | string | `"00:00:00:10"` |  |
| replication.retry | int | `60` |  |
| replication.starttls | string | `"critical"` |  |
| replication.timeout | int | `1` |  |
| replication.tls_reqcert | string | `"never"` |  |
| secret.LDAP_ADMIN_PASSWORD | string | `"ldapadmin"` |  |
| secret.LDAP_CONFIG_PASSWORD | string | `"changeme"` |  |
| secret.LDAP_READONLY_USER_PASSWORD | string | `"readonly"` |  |
| secret.LDAP_READONLY_USER_USERNAME | string | `"readonly"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.ldaps.enabled | bool | `true` |  |
| service.ldaps.ports.ldaps.enabled | bool | `true` |  |
| service.ldaps.ports.ldaps.port | int | `636` |  |
| service.ldaps.ports.ldaps.targetPort | int | `636` |  |
| service.main.ports.main.port | int | `389` |  |
| service.main.ports.main.targetPort | int | `389` |  |
| volumeClaimTemplates | object | `{"data":{"enabled":true,"mountPath":"/var/lib/ldap/"},"slapd":{"enabled":true,"mountPath":"/etc/ldap/slapd.d/"}}` | Used in conjunction with `controller.type: statefulset` to create individual disks for each instance. |

All Rights Reserved - The TrueCharts Project
