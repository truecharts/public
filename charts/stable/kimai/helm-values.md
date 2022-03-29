# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.APP_ENV | string | `"prod"` |  |
| env.DB_BASE | string | `"{{ .Values.mariadb.mariadbUsername }}"` |  |
| env.DB_PORT | string | `"3306"` |  |
| env.DB_TYPE | string | `"mysql"` |  |
| env.DB_USER | string | `"{{ .Values.mariadb.mariadbDatabase }}"` |  |
| env.TRUSTED_HOSTS | string | `"{{ .Values.env.trust_hosts }},localhost"` |  |
| env.trust_hosts | string | `"127.0.0.1"` |  |
| envValueFrom.APP_SECRET.secretKeyRef.key | string | `"APP_SECRET"` |  |
| envValueFrom.APP_SECRET.secretKeyRef.name | string | `"kimai-secrets"` |  |
| envValueFrom.DB_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.DB_HOST.secretKeyRef.name | string | `"mariadbcreds"` |  |
| envValueFrom.DB_PASS.secretKeyRef.key | string | `"mariadb-password"` |  |
| envValueFrom.DB_PASS.secretKeyRef.name | string | `"mariadbcreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/kimai"` |  |
| image.tag | string | `"v1.19@sha256:c397c8f343f90c7997cf524d9b05636571c017db8d9e6db3c6328abfe3cd3b81"` |  |
| mariadb.enabled | bool | `true` |  |
| mariadb.existingSecret | string | `"mariadbcreds"` |  |
| mariadb.mariadbDatabase | string | `"kimai"` |  |
| mariadb.mariadbUsername | string | `"kimai"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/opt/kimai/var/data"` |  |
| persistence.plugins.enabled | bool | `true` |  |
| persistence.plugins.mountPath | string | `"/opt/kimai/var/plugins"` |  |
| podSecurityContext.runAsGroup | int | `33` |  |
| podSecurityContext.runAsUser | int | `33` |  |
| probes.liveness.path | string | `"/en/login"` |  |
| probes.readiness.path | string | `"/en/login"` |  |
| probes.startup.path | string | `"/en/login"` |  |
| secret.ADMINMAIL | string | `"admin@mysecretdomain.com"` |  |
| secret.ADMINPASS | string | `"MvvTfjagiaqDprGNVA"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| service.main.ports.main.port | int | `10198` |  |
| service.main.ports.main.targetPort | int | `8001` |  |

All Rights Reserved - The TrueCharts Project
