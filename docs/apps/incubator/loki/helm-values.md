# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| alerting_groups | list | `[]` |  |
| args[0] | string | `"-config.file=/etc/loki/loki.yaml"` |  |
| config.auth_enabled | bool | `false` |  |
| config.chunk_store_config.max_look_back_period | string | `"0s"` |  |
| config.compactor.shared_store | string | `"filesystem"` |  |
| config.compactor.working_directory | string | `"/data/loki/boltdb-shipper-compactor"` |  |
| config.ingester.chunk_block_size | int | `262144` |  |
| config.ingester.chunk_idle_period | string | `"3m"` |  |
| config.ingester.chunk_retain_period | string | `"1m"` |  |
| config.ingester.lifecycler.ring.kvstore.store | string | `"inmemory"` |  |
| config.ingester.lifecycler.ring.replication_factor | int | `1` |  |
| config.ingester.max_transfer_retries | int | `0` |  |
| config.ingester.wal.dir | string | `"/data/loki/wal"` |  |
| config.limits_config.enforce_metric_name | bool | `false` |  |
| config.limits_config.reject_old_samples | bool | `true` |  |
| config.limits_config.reject_old_samples_max_age | string | `"168h"` |  |
| config.schema_config.configs[0].from | string | `"2020-10-24"` |  |
| config.schema_config.configs[0].index.period | string | `"24h"` |  |
| config.schema_config.configs[0].index.prefix | string | `"index_"` |  |
| config.schema_config.configs[0].object_store | string | `"filesystem"` |  |
| config.schema_config.configs[0].schema | string | `"v11"` |  |
| config.schema_config.configs[0].store | string | `"boltdb-shipper"` |  |
| config.server.http_listen_port | int | `3100` |  |
| config.storage_config.boltdb_shipper.active_index_directory | string | `"/data/loki/boltdb-shipper-active"` |  |
| config.storage_config.boltdb_shipper.cache_location | string | `"/data/loki/boltdb-shipper-cache"` |  |
| config.storage_config.boltdb_shipper.cache_ttl | string | `"24h"` |  |
| config.storage_config.boltdb_shipper.shared_store | string | `"filesystem"` |  |
| config.storage_config.filesystem.directory | string | `"/data/loki/chunks"` |  |
| config.table_manager.retention_deletes_enabled | bool | `false` |  |
| config.table_manager.retention_period | string | `"0s"` |  |
| controller.replicas | int | `1` | Number of desired pods |
| controller.revisionHistoryLimit | int | `3` | ReplicaSet revision history limit |
| controller.rollingUpdate.partition | string | `nil` | Set statefulset RollingUpdate partition |
| controller.rollingUpdate.surge | string | `nil` | Set deployment RollingUpdate max surge |
| controller.rollingUpdate.unavailable | int | `1` | Set deployment RollingUpdate max unavailable |
| controller.strategy | string | `"RollingUpdate"` | Set the controller upgrade strategy For Deployments, valid values are Recreate (default) and RollingUpdate. For StatefulSets, valid values are OnDelete and RollingUpdate (default). DaemonSets ignore this. |
| controller.type | string | `"statefulset"` | Set the controller type. Valid options are deployment, daemonset or statefulset |
| env | object | `{}` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"grafana/loki"` |  |
| image.tag | string | `"2.4.1@sha256:f53b40251a601e491c36a4153aa65630c4ebf59404f36d6a532fb261a576ea9f"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/etc/loki"` | Where to mount the volume in the main container. |
| persistence.config.objectName | string | `"{{ include \"common.names.fullname\" . -}}-config"` | Specify the name of the configmap object to be mounted |
| persistence.config.type | string | `"secret"` |  |
| probes.liveness.path | string | `"/ready"` |  |
| probes.readiness.path | string | `"/ready"` |  |
| probes.startup.path | string | `"/ready"` |  |
| promtail.enabled | bool | `true` |  |
| service.main.ports.main.port | int | `3100` |  |
| service.main.ports.main.protocol | string | `"HTTP"` |  |
| service.main.ports.main.targetPort | int | `3100` |  |
| volumeClaimTemplates.data.enabled | bool | `true` |  |
| volumeClaimTemplates.data.mountPath | string | `"/data"` |  |

All Rights Reserved - The TrueCharts Project
