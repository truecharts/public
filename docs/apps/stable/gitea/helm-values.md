# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| admin.email | string | `"gitea@local.domain"` |  |
| admin.password | string | `"r8sA8CPHD9!bt6d"` |  |
| admin.username | string | `"giteaadmin"` |  |
| config.APP_NAME | string | `"Gitea: Git with a cup of tea"` |  |
| config.RUN_MODE | string | `"dev"` |  |
| customConfig | list | `[]` |  |
| envFrom[0].configMapRef.name | string | `"gitea-env"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"gitea/gitea"` |  |
| image.tag | string | `"1.15.6-rootless"` |  |
| initContainers.1-init-directories.command[0] | string | `"/usr/sbin/init_directory_structure.sh"` |  |
| initContainers.1-init-directories.envFrom[0].configMapRef.name | string | `"gitea-env"` |  |
| initContainers.1-init-directories.image | string | `"{{ .Values.image.repository }}:{{ .Values.image.tag }}"` |  |
| initContainers.1-init-directories.securityContext.runAsNonRoot | bool | `false` |  |
| initContainers.1-init-directories.securityContext.runAsUser | int | `0` |  |
| initContainers.1-init-directories.volumeMounts[0].mountPath | string | `"/usr/sbin"` |  |
| initContainers.1-init-directories.volumeMounts[0].name | string | `"init"` |  |
| initContainers.1-init-directories.volumeMounts[1].mountPath | string | `"/tmp"` |  |
| initContainers.1-init-directories.volumeMounts[1].name | string | `"temp"` |  |
| initContainers.1-init-directories.volumeMounts[2].mountPath | string | `"/etc/gitea/conf"` |  |
| initContainers.1-init-directories.volumeMounts[2].name | string | `"config"` |  |
| initContainers.1-init-directories.volumeMounts[3].mountPath | string | `"/data"` |  |
| initContainers.1-init-directories.volumeMounts[3].name | string | `"data"` |  |
| initContainers.2-configure-gitea.command[0] | string | `"/usr/sbin/configure_gitea.sh"` |  |
| initContainers.2-configure-gitea.envFrom[0].configMapRef.name | string | `"gitea-env"` |  |
| initContainers.2-configure-gitea.image | string | `"{{ .Values.image.repository }}:{{ .Values.image.tag }}"` |  |
| initContainers.2-configure-gitea.volumeMounts[0].mountPath | string | `"/usr/sbin"` |  |
| initContainers.2-configure-gitea.volumeMounts[0].name | string | `"init"` |  |
| initContainers.2-configure-gitea.volumeMounts[1].mountPath | string | `"/tmp"` |  |
| initContainers.2-configure-gitea.volumeMounts[1].name | string | `"temp"` |  |
| initContainers.2-configure-gitea.volumeMounts[2].mountPath | string | `"/data"` |  |
| initContainers.2-configure-gitea.volumeMounts[2].name | string | `"data"` |  |
| ldap.enabled | bool | `false` |  |
| memcached | object | `{"enabled":true}` | memcached dependency settings |
| metrics.enabled | bool | `false` |  |
| metrics.serviceMonitor.enabled | bool | `false` |  |
| oauth.enabled | bool | `false` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/data"` |  |
| persistence.temp.enabled | bool | `true` |  |
| persistence.temp.mountPath | string | `"/tmp"` |  |
| persistence.temp.type | string | `"emptyDir"` |  |
| persistence.varlib.enabled | bool | `true` |  |
| persistence.varlib.mountPath | string | `"/var/lib/gitea"` |  |
| persistence.varlib.type | string | `"emptyDir"` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"gitea"` |  |
| postgresql.postgresqlUsername | string | `"gitea"` |  |
| service.main.ports.main.port | int | `3000` |  |
| service.main.ports.main.targetPort | int | `3000` |  |
| service.ssh.enabled | bool | `true` |  |
| service.ssh.ports.ssh.enabled | bool | `true` |  |
| service.ssh.ports.ssh.port | int | `2222` |  |
| service.ssh.ports.ssh.targetPort | int | `2222` |  |
| signing.enabled | bool | `true` |  |
| signing.gpgHome | string | `"/data/git/.gnupg"` |  |

All Rights Reserved - The TrueCharts Project
