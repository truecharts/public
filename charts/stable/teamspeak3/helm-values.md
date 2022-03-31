# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.TS3SERVER_LICENSE | string | `"accept"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/teamspeak"` |  |
| image.tag | string | `"v3.13.6@sha256:0f90dc90bd7ae2408f0073287e64e8b2160b33f598ecd3298ef9fb9f98e01ca8"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/var/ts3server"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service | object | `{"files":{"enabled":true,"ports":{"files":{"enabled":true,"port":30033,"targetPort":30033}}},"main":{"ports":{"main":{"port":10011,"targetPort":10011}}},"voice":{"enabled":true,"ports":{"voice":{"enabled":true,"port":9987,"protocol":"UDP","targetPort":9987}}}}` |  10011 server query 30033 file transport |

All Rights Reserved - The TrueCharts Project
