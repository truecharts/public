# iX Chart

iX-chart is a chart designed to let user deploy a docker image in a TrueNAS SCALE kubernetes cluster.
It provides a mechanism to specify workload type, add external host interfaces in the pods, configure volumes and allocate host resources to the workload.

This chart will deploy a docker image as a kubernetes workload allowing user to configure the workload deployment / management.

## Introduction

iX-chart is designed for simple single docker image deployments.

## Configuration

The following table lists the configurable parameters of the iX chart and
their default values.

| Parameter                      | Description                                                                                                     | Default                                                              |
|:-------------------------------|:----------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------|
| `workloadType`                 | Specify type of workload to deploy                                                                              | `Deployment`                                                         |
| `cronSchedule`                 | Specify schedule for cronjob if `workloadType` is `CronJob`.                                                    | `{"minute": "5", "hour": "*", "dom": "*", "month": "*", "dow": "*"}` |
| `image.repository`             | The image repository to pull from                                                                               | `debian`                                                             |
| `image.tag`                    | The image tag to pull from                                                                                      | `latest`                                                             |
| `image.pullPolicy`             | Image pull policy                                                                                               | `IfNotPresent`                                                       |
| `updateStrategy`               | Upgrade Policy                                                                                                  | `RollingUpdate`                                                      |
| `jobRestartPolicy`             | Restart Policy for job type workload ( only applicable if `workloadType` is `Job`/`CronJob`                     | `OnFailure`                                                          |
| `containerCommand`             | Commands to execute inside container overriding image CMD default                                               | `null`                                                               |
| `containerArgs`                | Specify arguments for container command                                                                         | `null`                                                               |
| `containerEnvironmentVariables`| Container Environment Variables                                                                                 | `null`                                                               |
| `externalInterfaces`           | Add external interfaces in the pod                                                                              | `null`                                                               |
| `dnsPolicy`                    | Specify DNS Policy for pod                                                                                      | `Default`                                                            |
| `dnsConfig`                    | Specify custom DNS configuration which will be applied to the pod                                               | `{"nameservers": [], "searches": []}`                                |
| `hostNetwork`                  | Use host network for workload ( similar to docker host networking )                                             | `false`                                                              |
| `hostPortsList`                | Specify ports of host and workload to forward traffic from host port to workload port.                          | `null`                                                               |
| `portForwardingList`           | Specify ports of node and workload to forward traffic from node port to workload port                           | `null`                                                               |
| `hostPathVolumes`              | Specify host paths to be used as hostpath volumes for the workload                                              | `null`                                                               |
| `volumes`                      | Specify `ix_volumes`                                                                                            | `null`                                                               |
| `livenessProbe`                | Configure Liveness Probe for workload                                                                           | `null`                                                               |
| `gpuConfiguration`             | Allocate GPU to workload ( if available )                                                                       | `{}`                                                                 |


## Persistence

Chart release iX chart offers 2 ways to have persistent storage:

1) `hostPathVolumes`
2) `volumes`

For (1), they are kubernetes host path volumes which the user can assign to the workload with RO/RW permissions.

(2) is a host path volume as well but it operates differently then (1) in terms of where it lives and how it's lifecycle is tied to the chart release.
For (2), users specify where they would like persistent storage in the workload and a dataset name ( it should be unique per each chart release ), based on this input,
system will create a dataset and then use it as a host path volume for the workload. During upgrades, snapshot will be taken for these volumes and on rollback users can subsequently
restore the snapshots hence the data.
When a chart release will be deleted, all (2) volumes data will be deleted unlike (1) ( until of course they are not in the chart release's dataset path ).

## Recommended Persistence Configuration Examples

The following is a recommended configuration example for creating ix volumes

```
"volumes": [
  {
     "datasetName": "ix_volume1",
     "mountPath": "/mount_test1"
  },
  {
     "datasetName": "ix_volume2",
     "mountPath": "/mount_test2"
  }
]
    
```

`mountPath` refers to the path inside the pod.

---

The following is a recommended configuration example for `hostPathVolumes`

```
"hostPathVolumes": [
  {
    "hostPath": "/mnt/pool/test_dir",
    "mountPath": "/test_dir",
    "readOnly": true
  },
  {
    "hostPath": "/mnt/pool/test_file",
    "mountPath": "/test_file",
    "readOnly": true
  }
]
```

## External Interfaces Configuration Examples

```
"externalInterfaces": [
  {
    "hostInterface": "ens3",
    "ipam": {"type": "dhcp"}
  },
  {
     "hostInterface": "br0",
     "ipam": {
       "type": "static",
       "staticIPConfigurations": ["192.168.0.120/24"],
       "staticRoutes": [
         {"destination": "0.0.0.0/0", "gateway": "192.168.0.1"}
       ]
     }
  }
]
```

The first entry in the above configuration example will add an external interface in the pod using macvlan with `ipam` being set to `dhcp`.
Second entry will add an external interface in the pod using `bridge` and using static IP configuration for the external interface.
