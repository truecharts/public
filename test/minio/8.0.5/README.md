MinIO
=====

[MinIO](https://min.io) is a High Performance Object Storage released under Apache License v2.0. It is API compatible with Amazon S3 cloud storage service. Use MinIO to build high performance infrastructure for machine learning, analytics and application data workloads.

MinIO supports [distributed mode](https://docs.minio.io/docs/distributed-minio-quickstart-guide). In distributed mode, you can pool multiple drives (even on different machines) into a single object storage server.

For more detailed documentation please visit [here](https://docs.minio.io/)

Introduction
------------

This chart bootstraps MinIO deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

Prerequisites
-------------

- Kubernetes 1.4+ with Beta APIs enabled for default standalone mode.
- Kubernetes 1.5+ with Beta APIs enabled to run MinIO in [distributed mode](#distributed-minio).
- PV provisioner support in the underlying infrastructure.

Configure MinIO Helm repo
--------------------
```bash
$ helm repo add minio https://helm.min.io/
```

Installing the Chart
--------------------

Install this chart using:

```bash
$ helm install --namespace minio --generate-name minio/minio
```

The command deploys MinIO on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

### Release name

An instance of a chart running in a Kubernetes cluster is called a release. Each release is identified by a unique name within the cluster. Helm automatically assigns a unique release name after installing the chart. You can also set your preferred name by:

```bash
$ helm install my-release minio/minio
```

### Access and Secret keys

By default a pre-generated access and secret key will be used. To override the default keys, pass the access and secret keys as arguments to helm install.

```bash
$ helm install --set accessKey=myaccesskey,secretKey=mysecretkey --generate-name minio/minio
```

Uninstalling the Chart
----------------------

Assuming your release is named as `my-release`, delete it using the command:

```bash
$ helm delete my-release
```

or

```bash
$ helm uninstall my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

Upgrading the Chart
-------------------

You can use Helm to update MinIO version in a live release. Assuming your release is named as `my-release`, get the values using the command:

```bash
$ helm get values my-release > old_values.yaml
```

Then change the field `image.tag` in `old_values.yaml` file with MinIO image tag you want to use. Now update the chart using

```bash
$ helm upgrade -f old_values.yaml my-release minio/minio
```

Default upgrade strategies are specified in the `values.yaml` file. Update these fields if you'd like to use a different strategy.

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
