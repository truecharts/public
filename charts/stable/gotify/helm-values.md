# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env | object | `{"GOTIFY_PASSSTRENGTH":10,"GOTIFY_PLUGINSDIR":"data/plugins","GOTIFY_SERVER_KEEPALIVEPERIODSECONDS":0,"GOTIFY_SERVER_LISTENADDR":"","GOTIFY_SERVER_PORT":8080,"GOTIFY_SERVER_RESPONSEHEADERS":"X-Custom-Header: \"custom value\"","GOTIFY_SERVER_SSL_ENABLED":false,"GOTIFY_SERVER_STREAM_PINGPERIODSECONDS":45,"GOTIFY_UPLOADEDIMAGESDIR":"data/images"}` |  https://gotify.net/docs/config#environment-variables |
| env.GOTIFY_SERVER_RESPONSEHEADERS | string | `"X-Custom-Header: \"custom value\""` |  GOTIFY_SERVER_SSL_LETSENCRYPT_HOSTS: "- mydomain.tld\n- myotherdomain.tld" |
| env.GOTIFY_SERVER_STREAM_PINGPERIODSECONDS | int | `45` |  GOTIFY_SERVER_CORS_ALLOWMETHODS: "- \"GET\"\n- \"POST\"" GOTIFY_SERVER_CORS_ALLOWHEADERS: "- \"Authorization\"\n- \"content-type\"" GOTIFY_SERVER_STREAM_ALLOWEDORIGINS: "- \".+.example.com\"\n- \"otherdomain.com\"" |
| envFrom[0].configMapRef.name | string | `"gotifyenv"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/gotify-server"` |  |
| image.tag | string | `"v2.1.4@sha256:3f568cbc18808a8d138b07073233411a1077676e28a468b7e345fffae639fa32"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/app/data"` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"gotify"` |  |
| postgresql.postgresqlUsername | string | `"gotify"` |  |
| secret.pass | string | `"admin"` |  |
| secret.user | string | `"admin"` |  |
| service.main.ports.main.port | int | `10084` |  |
| service.main.ports.main.targetPort | int | `8080` |  |

All Rights Reserved - The TrueCharts Project
