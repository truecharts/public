MinIO
=====

[MinIO](https://min.io) is a High Performance Object Storage released under Apache License v2.0. It is API compatible with Amazon S3 cloud storage service. Use MinIO to build high performance infrastructure for machine learning, analytics and application data workloads.

MinIO supports [distributed mode](https://docs.minio.io/docs/distributed-minio-quickstart-guide). In distributed mode, you can pool multiple drives (even on different machines) into a single object storage server.

For more detailed documentation please visit [here](https://docs.minio.io/)

Introduction
------------

This chart bootstraps MinIO deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.


Configuration
-------------

The following table lists the configurable parameters of the MinIO chart and their default values.

| Parameter                                        | Description                                                                                                                             | Default                          |
|:-------------------------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------|:---------------------------------|
| `image.repository`                               | Image repository                                                                                                                        | `minio/minio`                    |
| `image.tag`                                      | MinIO image tag. Possible values listed [here](https://hub.docker.com/r/minio/minio/tags/).                                             | `RELEASE.2020-11-06T23-17-07Z`   |
| `image.pullPolicy`                               | Image pull policy                                                                                                                       | `IfNotPresent`                   |
| `extraArgs`                                      | Additional command line arguments to pass to the MinIO server                                                                           | `[]`                             |
| `accessKey`                                      | Default access key (5 to 20 characters)                                                                                                 | random 20 chars                  |
| `secretKey`                                      | Default secret key (8 to 40 characters)                                                                                                 | random 40 chars                  |
| `persistence.enabled`                            | Use persistent volume to store data                                                                                                     | `true`                           |
| `persistence.size`                               | Size of persistent volume claim                                                                                                         | `500Gi`                          |
| `persistence.existingClaim`                      | Use an existing PVC to persist data                                                                                                     | `nil`                            |
| `persistence.storageClass`                       | Storage class name of PVC                                                                                                               | `nil`                            |
| `persistence.accessMode`                         | ReadWriteOnce or ReadOnly                                                                                                               | `ReadWriteOnce`                  |
| `persistence.subPath`                            | Mount a sub directory of the persistent volume if set                                                                                   | `""`                             |
| `environment`                                    | Set MinIO server relevant environment variables in `values.yaml` file. MinIO containers will be passed these variables when they start. | `MINIO_STORAGE_CLASS_STANDARD: EC:4"` |

Some parameters above map to the env variables defined in the [MinIO DockerHub image](https://hub.docker.com/r/minio/minio/).

Pass environment variables to MinIO containers
----------------------------------------------

To pass environment variables to MinIO containers when deploying via Helm chart, use the below command line format

```bash
$ helm install --set environment.MINIO_BROWSER=on,environment.MINIO_DOMAIN=domain-name minio/minio
```

You can add as many environment variables as required, using the above format. Just add `environment.<VARIABLE_NAME>=<value>` under `set` flag.

**NOTE**
- On fresh installation, minIO data directory's ownership will be updated to minio:minio.
- For existing installations that are exhibiting the upgrade to >=1.5.0, the minIO data directory's ownership will be migrated to minio:minio.
