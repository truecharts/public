# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.FF_SYNCSERVER_ACCESSLOG | bool | `false` |  |
| env.FF_SYNCSERVER_ALLOW_NEW_USERS | bool | `true` |  |
| env.FF_SYNCSERVER_FORCE_WSGI_ENVIRON | bool | `true` |  |
| env.FF_SYNCSERVER_FORWARDED_ALLOW_IPS | string | `"*"` |  |
| env.FF_SYNCSERVER_LOGLEVEL | string | `"info"` |  |
| env.FF_SYNCSERVER_PUBLIC_URL | string | `"firefox-syncserver.192.168.1.189.nip.io"` |  |
| env.PUID | int | `568` |  |
| env.TZ | string | `"America/Los_Angeles"` |  |
| envValueFrom.DB_HOST.secretKeyRef.key | string | `"url"` |  |
| envValueFrom.DB_HOST.secretKeyRef.name | string | `"dbcreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ghcr.io/crazy-max/firefox-syncserver"` |  |
| image.tag | string | `"1.8.0@sha256:ab1a959d8105c478f0f1523c8c3bbdc53bb8d44f325501b93297bc80cf627da6"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"firefox-syncserver"` |  |
| postgresql.postgresqlUsername | string | `"firefox-syncserver"` |  |
| secret.FF_SYNCSERVER_SECRET | string | `"changeme"` |  |
| securityContext.allowPrivilegeEscalation | bool | `true` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `5000` |  |
| service.main.ports.main.targetPort | int | `5000` |  |

All Rights Reserved - The TrueCharts Project
