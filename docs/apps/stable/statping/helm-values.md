# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.DESCRIPTION | string | `"This is a Statping instance deployed as Helm chart"` | Description of the Statping instance |
| env.DISABLE_LOGS | bool | `false` | Disable logs from appearing and writing to disk |
| env.NAME | string | `"Statping Example"` | Name of the Statping instance |
| env.TZ | string | `"UTC"` | Set the container timezone |
| env.USE_CDN | bool | `false` | Use CDN for static context from third-parties |
| env.VIRTUAL_HOST | string | `""` | External URL you use to connect to the statping (the one you enter in your browser) |
| envTpl.DB_CONN | string | `"postgres"` |  |
| envTpl.DB_DATABASE | string | `"{{ .Values.postgresql.postgresqlDatabase }}"` |  |
| envTpl.DB_PORT | string | `"5432"` |  |
| envTpl.DB_USER | string | `"{{ .Values.postgresql.postgresqlUsername }}"` |  |
| envTpl.POSTGRES_SSLMODE | string | `"disable"` |  |
| envValueFrom.DB_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.DB_HOST.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.DB_PASS.secretKeyRef.key | string | `"postgresql-password"` |  |
| envValueFrom.DB_PASS.secretKeyRef.name | string | `"dbcreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"statping/statping"` | image repository |
| image.tag | string | `"v0.90.74@sha256:e874da513a5cf0375fc8e7e8cde533934b57804760c9e2d745a584fc26a664cb"` | image tag |
| persistence | object | See values.yaml | Configure persistence settings for the chart under this key. |
| postgresql | object | See values.yaml | Enable and configure postgresql database subchart under this key. |
| secret | object | See below | environment variables. See [application docs](https://github.com/statping/statping/wiki/Config-with-.env-File) for more details. |
| secret.ADMIN_EMAIL | string | `"info@example.com"` | dashboard admin email |
| secret.ADMIN_PASSWORD | string | `"changeme"` | dashboard admin password (needed to edit) |
| secret.ADMIN_USER | string | `"admin"` | dashboard admin user (needed to edit) |
| service | object | See values.yaml | Configures service settings for the chart. |

All Rights Reserved - The TrueCharts Project
