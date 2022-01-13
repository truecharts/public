# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env | string | `nil` |  |
| frigate.birdseye.enabled | bool | `true` |  |
| frigate.birdseye.mode | string | `"motion"` |  |
| frigate.cameras[0].best_image_timeout | int | `60` |  |
| frigate.cameras[0].detect.height | int | `720` |  |
| frigate.cameras[0].detect.width | int | `1280` |  |
| frigate.cameras[0].inputs[0].path | string | `"rtsp://username:password@highres.url"` |  |
| frigate.cameras[0].inputs[0].roles[0] | string | `"record"` |  |
| frigate.cameras[0].inputs[1].path | string | `"rtsp://username:password@lowres.url"` |  |
| frigate.cameras[0].inputs[1].roles[0] | string | `"detect"` |  |
| frigate.cameras[0].inputs[1].roles[1] | string | `"rtmp"` |  |
| frigate.cameras[0].name | string | `"camera1"` |  |
| frigate.cameras[0].objects.track[0] | string | `"person"` |  |
| frigate.cameras[0].objects.track[1] | string | `"car"` |  |
| frigate.cameras[0].objects.track[2] | string | `"motorcyle"` |  |
| frigate.cameras[0].objects.track[3] | string | `"cat"` |  |
| frigate.cameras[0].objects.track[4] | string | `"dog"` |  |
| frigate.cameras[0].record.enabled | bool | `true` |  |
| frigate.cameras[0].snapshots.enabled | bool | `true` |  |
| frigate.mqtt.authentitcated | bool | `false` |  |
| frigate.mqtt.host | string | `"mosquitto.ix-mosquitto.svc.cluster.local"` |  |
| frigate.mqtt.password | string | `"password"` |  |
| frigate.mqtt.port | int | `1883` |  |
| frigate.mqtt.username | string | `"mqtt_user"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"blakeblackshear/frigate"` |  |
| image.tag | string | `"0.10.0-beta6-amd64nvidia"` |  |
| persistence.cache.enabled | bool | `true` |  |
| persistence.cache.mountPath | string | `"/tmp/cache"` |  |
| persistence.cache.type | string | `"emptyDir"` |  |
| persistence.media.enabled | bool | `true` |  |
| persistence.media.mountPath | string | `"/media"` |  |
| persistence.shm.enabled | bool | `true` |  |
| persistence.shm.medium | string | `"Memory"` |  |
| persistence.shm.mountPath | string | `"/dev/shm"` |  |
| persistence.shm.type | string | `"emptyDir"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| portal.enabled | bool | `true` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `5000` |  |
| service.main.ports.main.targetPort | int | `5000` |  |
| service.rtmp.enabled | bool | `true` |  |
| service.rtmp.ports.rtmp.enabled | bool | `true` |  |
| service.rtmp.ports.rtmp.port | int | `1935` |  |
| service.rtmp.ports.rtmp.protocol | string | `"TCP"` |  |
| service.rtmp.ports.rtmp.targetPort | int | `1935` |  |

All Rights Reserved - The TrueCharts Project
