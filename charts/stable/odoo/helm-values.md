# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.USER | string | `"{{ .Values.postgresql.postgresqlUsername }}"` |  |
| envValueFrom.HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.HOST.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.PASSWORD.secretKeyRef.key | string | `"postgresql-password"` |  |
| envValueFrom.PASSWORD.secretKeyRef.name | string | `"dbcreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/odoo"` |  |
| image.tag | string | `"version-14.0@sha256:dec23986ced979e029a78512272e2be18bab60d811bccb3d7ddc4b3241b210e2"` |  |
| persistence.addons.enabled | bool | `true` |  |
| persistence.addons.mountPath | string | `"/mnt/extra-addons"` |  |
| persistence.odoo.enabled | bool | `true` |  |
| persistence.odoo.mountPath | string | `"/var/lib/odoo"` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"postgres"` |  |
| postgresql.postgresqlUsername | string | `"odoo"` |  |
| secret | object | `{}` |  |
| service.main.ports.main.port | int | `8069` |  |
| service.main.ports.main.targetPort | int | `8069` |  |
| service.odoo.enabled | bool | `true` |  |
| service.odoo.ports.odoo-1.enabled | bool | `true` |  |
| service.odoo.ports.odoo-1.port | int | `8071` |  |
| service.odoo.ports.odoo-1.targetPort | int | `8071` |  |
| service.odoo.ports.odoo-2.enabled | bool | `true` |  |
| service.odoo.ports.odoo-2.port | int | `8072` |  |
| service.odoo.ports.odoo-2.targetPort | int | `8072` |  |

All Rights Reserved - The TrueCharts Project
