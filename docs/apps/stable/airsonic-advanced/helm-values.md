# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.AIRSONIC_DIR | string | `"/"` |  |
| env.CONTEXT_PATH | string | `"/"` |  |
| env.JAVA_OPTS | string | `nil` | For passing additional java options. For some reverse proxies, you may need to pass `JAVA_OPTS=-Dserver.use-forward-headers=true` for airsonic to generate the proper URL schemes. |
| env.PUID | int | `568` |  |
| env.TZ | string | `"UTC"` |  |
| env.spring_datasource_username | string | `"{{ .Values.postgresql.postgresqlUsername }}"` |  |
| env.spring_liquibase_parameters_userTableQuote | string | `"\""` |  |
| envValueFrom.spring_datasource_password.secretKeyRef.key | string | `"postgresql-password"` |  |
| envValueFrom.spring_datasource_password.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.spring_datasource_url.secretKeyRef.key | string | `"jdbc"` |  |
| envValueFrom.spring_datasource_url.secretKeyRef.name | string | `"dbcreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/airsonic-advanced"` |  |
| image.tag | string | `"v11.0.0@sha256:b6a1b30ecc3e16c39ca56392cd13d55af80235b57ec2d27c2e5f1a21fec34bd9"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/airsonic"` |  |
| persistence.music.enabled | bool | `true` |  |
| persistence.music.mountPath | string | `"/music"` |  |
| persistence.playlists.enabled | bool | `true` |  |
| persistence.playlists.mountPath | string | `"/playlists"` |  |
| persistence.podcasts.enabled | bool | `true` |  |
| persistence.podcasts.mountPath | string | `"/podcasts"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"airsonic-advanced"` |  |
| postgresql.postgresqlUsername | string | `"airsonic-advanced"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10122` |  |
| service.main.ports.main.targetPort | int | `4040` |  |

All Rights Reserved - The TrueCharts Project
