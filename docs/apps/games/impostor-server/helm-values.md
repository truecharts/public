# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.IMPOSTOR_AntiCheat__BanIpFromGame | bool | `true` |  |
| env.IMPOSTOR_AntiCheat__Enabled | bool | `true` |  |
| env.IMPOSTOR_Debug__GameRecorderEnabled | bool | `false` |  |
| env.IMPOSTOR_Debug__GameRecorderPath | string | `""` |  |
| env.IMPOSTOR_Server__ListenIp | string | `"0.0.0.0"` |  |
| env.IMPOSTOR_Server__PublicIp | string | `"127.0.0.1"` |  |
| env.PUID | int | `568` |  |
| env.USER_ID | string | `"{{ .Values.env.PUID }}"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/impostor-server"` |  |
| image.tag | string | `"v1.6.0@sha256:789dda6ea04417d5a7abb9f0373e53ecab7a2cd7b77fa7fc8d9620d977b0e863"` |  |
| nightlyImage.pullPolicy | string | `"IfNotPresent"` |  |
| nightlyImage.repository | string | `"tccr.io/truecharts/impostor-server-nightly"` |  |
| nightlyImage.tag | string | `"vnightly@sha256:2954766c55fac9242517f5637bec19d9bc3c2479f1557d05ad0b3e54d5a173a3"` |  |
| probes.liveness | object | See below | Liveness probe configuration |
| probes.readiness | object | See below | Redainess probe configuration |
| probes.startup | object | See below | Startup probe configuration |
| service.main.ports.main.port | int | `22023` |  |
| service.main.ports.main.protocol | string | `"UDP"` |  |
| service.main.ports.main.targetPort | int | `22023` |  |

All Rights Reserved - The TrueCharts Project
