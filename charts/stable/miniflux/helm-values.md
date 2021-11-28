# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.CREATE_ADMIN | int | `1` | Set to `1` to create an admin user from environment variables. |
| env.RUN_MIGRATIONS | int | `1` | Set to `1` to run database migrations during application startup. |
| env.TZ | string | `"UTC"` | Set the container timezone. |
| envValueFrom.DATABASE_URL | object | `{"secretKeyRef":{"key":"urlnossl","name":"dbcreds"}}` | Postgresql connection parameters. See [lib/pq](https://pkg.go.dev/github.com/lib/pq#hdr-Connection_String_Parameters) for more details. |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"miniflux/miniflux"` |  |
| image.tag | string | `"2.0.33@sha256:77726b617e71a046ea4d02890f7f4a5d43a3c774c7de073ad06bec521ae75f12"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| postgresql | object | Enabled (see values.yaml for more details) | Enable and configure postgresql database subchart under this key. |
| probes | object | See values.yaml | Configures the probes for the main Pod. |
| secret | object | See below | environment variables. See [miniflux docs](https://miniflux.app/docs/configuration.html) for more details. |
| secret.ADMIN_PASSWORD | string | `"changeme"` | Admin user password, it's used only if `CREATE_ADMIN` is enabled. |
| secret.ADMIN_USERNAME | string | `"admin"` | Admin user login, it's used only if `CREATE_ADMIN` is enabled. |
| service | object | See values.yaml | Configures service settings for the chart. |

All Rights Reserved - The TrueCharts Project
