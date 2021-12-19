# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalContainers.nginx.image | string | `"{{ .Values.nginxImage.repository }}:{{ .Values.nginxImage.tag }}"` |  |
| additionalContainers.nginx.name | string | `"nginx"` |  |
| additionalContainers.nginx.ports[0].containerPort | int | `80` |  |
| additionalContainers.nginx.ports[0].name | string | `"main"` |  |
| additionalContainers.nginx.volumeMounts[0].mountPath | string | `"/etc/nginx/nginx.conf"` |  |
| additionalContainers.nginx.volumeMounts[0].name | string | `"recipes-config"` |  |
| additionalContainers.nginx.volumeMounts[0].readOnly | bool | `true` |  |
| additionalContainers.nginx.volumeMounts[0].subPath | string | `"nginx-config"` |  |
| additionalContainers.nginx.volumeMounts[1].mountPath | string | `"/media"` |  |
| additionalContainers.nginx.volumeMounts[1].name | string | `"media"` |  |
| additionalContainers.nginx.volumeMounts[2].mountPath | string | `"/static"` |  |
| additionalContainers.nginx.volumeMounts[2].name | string | `"static"` |  |
| env | object | See below | environment variables. See [project docs](https://raw.githubusercontent.com/vabene1111/recipes/master/.env.template) for more details. |
| envTpl.DB_ENGINE | string | `"django.db.backends.postgresql"` |  |
| envTpl.POSTGRES_DB | string | `"{{ .Values.postgresql.postgresqlDatabase }}"` |  |
| envTpl.POSTGRES_PORT | string | `"5432"` |  |
| envTpl.POSTGRES_USER | string | `"{{ .Values.postgresql.postgresqlUsername }}"` |  |
| envTpl.TIMEZONE | string | `"{{ .Values.env.TZ }}"` |  |
| envValueFrom.POSTGRES_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.POSTGRES_HOST.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.POSTGRES_PASSWORD.secretKeyRef.key | string | `"postgresql-password"` |  |
| envValueFrom.POSTGRES_PASSWORD.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.SECRET_KEY.secretKeyRef.key | string | `"SECRET_KEY"` |  |
| envValueFrom.SECRET_KEY.secretKeyRef.name | string | `"recipes-secrets"` |  |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"tccr.io/truecharts/recipes"` | image repository |
| image.tag | string | `"v1.0.2@sha256:d61f230769c64948f1b2c56ec189666bb08821b02f383f4e0c299c35d2542cbc"` | image tag |
| nginxImage.repository | string | `"tccr.io/truecharts/nginx"` | nginx sidecar image repository |
| nginxImage.tag | string | `"v1.21.4@sha256:81b9486bd8b0f8c9d933013a4b4a6267463625e0dcc756c01ec766ba386f6c93"` | nginx sidecar image tag |
| persistence | object | See values.yaml | Configure persistence settings for the chart under this key. |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"recipes"` |  |
| postgresql.postgresqlUsername | string | `"recipes"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service | object | See values.yaml | Configures service settings for the chart. |

All Rights Reserved - The TrueCharts Project
