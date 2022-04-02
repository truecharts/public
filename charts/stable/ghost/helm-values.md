# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.NODE_ENV | string | `"production"` |  |
| env.adminFrameProtection | bool | `true` |  |
| env.backgroundJobs__emailAnalytics | bool | `true` |  |
| env.compress | bool | `true` |  |
| env.database__client | string | `"mysql"` |  |
| env.database__connection__database | string | `"{{ .Values.mariadb.mariadbDatabase }}"` |  |
| env.database__connection__port | int | `3306` |  |
| env.database__connection__user | string | `"{{ .Values.mariadb.mariadbUsername }}"` |  |
| env.emailAnalytics | bool | `true` |  |
| env.enableStripePromoCodes | bool | `false` |  |
| env.imageOptimization__resize | bool | `true` |  |
| env.imageOptimization__srcsets | bool | `true` |  |
| env.mail__from | string | `""` |  |
| env.mail__options__auth__pass | string | `""` |  |
| env.mail__options__auth__user | string | `""` |  |
| env.mail__options__port | string | `""` |  |
| env.mail__options__secure | bool | `false` |  |
| env.mail__options__service | string | `""` |  |
| env.mail__transport | string | `""` |  |
| env.opensea__privateReadOnlyApiKey | string | `""` |  |
| env.preloadHeaders | bool | `false` |  |
| env.privacy__useGravatar | bool | `false` |  |
| env.privacy__useRpcPing | bool | `false` |  |
| env.privacy__useStructuredData | bool | `false` |  |
| env.privacy__useTinfoil | bool | `true` |  |
| env.privacy__useUpdateCheck | bool | `false` |  |
| env.sendWelcomeEmail | bool | `true` |  |
| env.server__port | string | `"{{ .Values.service.main.ports.main.port }}"` |  |
| env.stripeDirect | bool | `false` |  |
| env.tenor__contentFilter | string | `"off"` |  |
| env.tenor__publicReadOnlyApiKey | string | `""` |  |
| env.twitter__privateReadOnlyToken | string | `""` |  |
| env.url | string | `"http://localhost:10166"` |  |
| env.useMinFiles | bool | `true` |  |
| envValueFrom.database__connection__host.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.database__connection__host.secretKeyRef.name | string | `"mariadbcreds"` |  |
| envValueFrom.database__connection__password.secretKeyRef.key | string | `"mariadb-password"` |  |
| envValueFrom.database__connection__password.secretKeyRef.name | string | `"mariadbcreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/ghost"` |  |
| image.tag | string | `"v4.41.3@sha256:ac4b66c0ef5111f070d3954e2ee4c9cac54781c97121dcd3f3bf6d0b6788ed39"` |  |
| mariadb.enabled | bool | `true` |  |
| mariadb.existingSecret | string | `"mariadbcreds"` |  |
| mariadb.mariadbDatabase | string | `"ghost"` |  |
| mariadb.mariadbUsername | string | `"ghost"` |  |
| persistence.content.enabled | bool | `true` |  |
| persistence.content.mountPath | string | `"/var/lib/ghost/content"` |  |
| service.main.ports.main.port | int | `10166` |  |
| service.main.ports.main.targetPort | int | `10166` |  |

All Rights Reserved - The TrueCharts Project
