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

### Updating MinIO configuration via Helm

[ConfigMap](https://kubernetes.io/docs/user-guide/configmap/) allows injecting containers with configuration data even while a Helm release is deployed.

To update your MinIO server configuration while it is deployed in a release, you need to

1. Check all the configurable values in the MinIO chart using `helm inspect values minio/minio`.
2. Override the `minio_server_config` settings in a YAML formatted file, and then pass that file like this `helm upgrade -f config.yaml minio/minio`.
3. Restart the MinIO server(s) for the changes to take effect.

You can also check the history of upgrades to a release using `helm history my-release`. Replace `my-release` with the actual release name.

### Installing certificates from third party CAs

MinIO can connect to other servers, including MinIO nodes or other server types such as NATs and Redis. If these servers use certificates that were not registered with a known CA, add trust for these certificates to MinIO Server by bundling these certificates into a Kubernetes secret and providing it to Helm via the `trustedCertsSecret` value. If `.Values.tls.enabled` is `true` and you're installing certificates for third party CAs, remember to include Minio's own certificate with key `public.crt`, if it also needs to be trusted.

For instance, given that TLS is enabled and you need to add trust for Minio's own CA and for the CA of a Keycloak server, a Kubernetes secret can be created from the certificate files using `kubectl`:

```
kubectl -n minio create secret generic minio-trusted-certs --from-file=public.crt --from-file=keycloak.crt
```

If TLS is not enabled, you would need only the third party CA:

```
kubectl -n minio create secret generic minio-trusted-certs --from-file=keycloak.crt
```

The name of the generated secret can then be passed to Helm using a values file or the `--set` parameter:

```
trustedCertsSecret: "minio-trusted-certs"

or

--set trustedCertsSecret=minio-trusted-certs
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
| `trustedCertsSecret`                             | Kubernetes secret with trusted certificates to be mounted on `{{ .Values.certsPath }}/CAs`                                              | `""`                             |
| `mode`                                           | MinIO server mode (`standalone` or `distributed`)                                                                                       | `standalone`                     |
| `extraArgs`                                      | Additional command line arguments to pass to the MinIO server                                                                           | `[]`                             |
| `replicas`                                       | Number of nodes (applicable only for MinIO distributed mode).                                                                           | `4`                              |
| `zones`                                          | Number of zones (applicable only for MinIO distributed mode).                                                                           | `1`                              |
| `drivesPerNode`                                  | Number of drives per node (applicable only for MinIO distributed mode).                                                                 | `1`                              |
| `existingSecret`                                 | Name of existing secret with access and secret key.                                                                                     | `""`                             |
| `accessKey`                                      | Default access key (5 to 20 characters)                                                                                                 | random 20 chars                  |
| `secretKey`                                      | Default secret key (8 to 40 characters)                                                                                                 | random 40 chars                  |
| `certsPath`                                      | Default certs path location                                                                                                             | `/etc/minio/certs`               |
| `configPathmc`                                   | Default config file location for MinIO client - mc                                                                                      | `/etc/minio/mc`                  |
| `mountPath`                                      | Default mount location for persistent drive                                                                                             | `/export`                        |
| `bucketRoot`                                     | Directory from where minio should serve buckets.                                                                                        | Value of `.mountPath`            |
| `clusterDomain`                                  | domain name of kubernetes cluster where pod is running.                                                                                 | `cluster.local`                  |
| `service.type`                                   | Kubernetes service type                                                                                                                 | `ClusterIP`                      |
| `service.port`                                   | Kubernetes port where service is exposed                                                                                                | `9000`                           |
| `service.externalIPs`                            | service external IP addresses                                                                                                           | `nil`                            |
| `service.annotations`                            | Service annotations                                                                                                                     | `{}`                             |
| `serviceAccount.create`                          | Toggle creation of new service account                                                                                                  | `true`                           |
| `serviceAccount.name`                            | Name of service account to create and/or use                                                                                            | `""`                             |
| `persistence.enabled`                            | Use persistent volume to store data                                                                                                     | `true`                           |
| `persistence.size`                               | Size of persistent volume claim                                                                                                         | `500Gi`                          |
| `persistence.existingClaim`                      | Use an existing PVC to persist data                                                                                                     | `nil`                            |
| `persistence.storageClass`                       | Storage class name of PVC                                                                                                               | `nil`                            |
| `persistence.accessMode`                         | ReadWriteOnce or ReadOnly                                                                                                               | `ReadWriteOnce`                  |
| `persistence.subPath`                            | Mount a sub directory of the persistent volume if set                                                                                   | `""`                             |
| `resources.requests.memory`                      | Memory resource requests                                                                                                                | Memory: `4Gi`                    |
| `priorityClassName`                              | Pod priority settings                                                                                                                   | `""`                             |
| `securityContext.enabled`                        | Enable to run containers as non-root. NOTE: if `persistence.enabled=false` then securityContext will be automatically disabled          | `true`                           |
| `securityContext.runAsUser`                      | User id of the user for the container                                                                                                   | `1000`                           |
| `securityContext.runAsGroup`                     | Group id of the user for the container                                                                                                  | `1000`                           |
| `securityContext.fsGroup`                        | Group id of the persistent volume mount for the container                                                                               | `1000`                           |
| `nodeSelector`                                   | Node labels for pod assignment                                                                                                          | `{}`                             |
| `affinity`                                       | Affinity settings for pod assignment                                                                                                    | `{}`                             |
| `tolerations`                                    | Toleration labels for pod assignment                                                                                                    | `[]`                             |
| `podAnnotations`                                 | Pod annotations                                                                                                                         | `{}`                             |
| `podLabels`                                      | Pod Labels                                                                                                                              | `{}`                             |
| `tls.enabled`                                    | Enable TLS for MinIO server                                                                                                             | `false`                          |
| `tls.certSecret`                                 | Kubernetes Secret with `public.crt` and `private.key` files.                                                                            | `""`                             |
| `defaultBucket.enabled`                          | If set to true, a bucket will be created after MinIO install                                                                            | `false`                          |
| `defaultBucket.name`                             | Bucket name                                                                                                                             | `bucket`                         |
| `defaultBucket.policy`                           | Bucket policy                                                                                                                           | `none`                           |
| `defaultBucket.purge`                            | Purge the bucket if already exists                                                                                                      | `false`                          |
| `defaultBucket.versioning`                       | Enable / Suspend versioning for bucket                                                                                                  | `nil`                            |
| `buckets`                                        | List of buckets to create after MinIO install                                                                                           | `[]`                             |
| `environment`                                    | Set MinIO server relevant environment variables in `values.yaml` file. MinIO containers will be passed these variables when they start. | `MINIO_STORAGE_CLASS_STANDARD: EC:4"` |

Some of the parameters above map to the env variables defined in the [MinIO DockerHub image](https://hub.docker.com/r/minio/minio/).

You can specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```bash
$ helm install --name my-release --set persistence.size=1Ti minio/minio
```

The above command deploys MinIO server with a 1Ti backing persistent volume.

Alternately, you can provide a YAML file that specifies parameter values while installing the chart. For example,

```bash
$ helm install --name my-release -f values.yaml minio/minio
```

> **Tip**: You can use the default [values.yaml](minio/values.yaml)

Distributed MinIO
-----------

This chart provisions a MinIO server in standalone mode, by default. To provision MinIO server in [distributed mode](https://docs.minio.io/docs/distributed-minio-quickstart-guide), set the `mode` field to `distributed`,

```bash
$ helm install --set mode=distributed minio/minio
```

This provisions MinIO server in distributed mode with 4 nodes. To change the number of nodes in your distributed MinIO server, set the `replicas` field,

```bash
$ helm install --set mode=distributed,replicas=8 minio/minio
```

This provisions MinIO server in distributed mode with 8 nodes. Note that the `replicas` value should be a minimum value of 4, there is no limit on number of servers you can run.

You can also expand an existing deployment by adding new zones, following command will create a total of 16 nodes with each zone running 8 nodes.

```bash
$ helm install --set mode=distributed,replicas=8,zones=2 minio/minio
```

### StatefulSet [limitations](http://kubernetes.io/docs/concepts/abstractions/controllers/statefulsets/#limitations) applicable to distributed MinIO

1. StatefulSets need persistent storage, so the `persistence.enabled` flag is ignored when `mode` is set to `distributed`.
2. When uninstalling a distributed MinIO release, you'll need to manually delete volumes associated with the StatefulSet.

Persistence
-----------

This chart provisions a PersistentVolumeClaim and mounts corresponding persistent volume to default location `/export`. You'll need physical storage available in the Kubernetes cluster for this to work. If you'd rather use `emptyDir`, disable PersistentVolumeClaim by:

```bash
$ helm install --set persistence.enabled=false minio/minio
```

> *"An emptyDir volume is first created when a Pod is assigned to a Node, and exists as long as that Pod is running on that node. When a Pod is removed from a node for any reason, the data in the emptyDir is deleted forever."*

Existing PersistentVolumeClaim
------------------------------

If a Persistent Volume Claim already exists, specify it during installation.

1. Create the PersistentVolume
2. Create the PersistentVolumeClaim
3. Install the chart

```bash
$ helm install --set persistence.existingClaim=PVC_NAME minio/minio
```

NetworkPolicy
-------------

To enable network policy for MinIO,
install [a networking plugin that implements the Kubernetes
NetworkPolicy spec](https://kubernetes.io/docs/tasks/administer-cluster/declare-network-policy#before-you-begin),
and set `networkPolicy.enabled` to `true`.

For Kubernetes v1.5 & v1.6, you must also turn on NetworkPolicy by setting
the DefaultDeny namespace annotation. Note: this will enforce policy for _all_ pods in the namespace:

    kubectl annotate namespace default "net.beta.kubernetes.io/network-policy={\"ingress\":{\"isolation\":\"DefaultDeny\"}}"

With NetworkPolicy enabled, traffic will be limited to just port 9000.

For more precise policy, set `networkPolicy.allowExternal=true`. This will
only allow pods with the generated client label to connect to MinIO.
This label will be displayed in the output of a successful install.

Existing secret
---------------

Instead of having this chart create the secret for you, you can supply a preexisting secret, much
like an existing PersistentVolumeClaim.

First, create the secret:
```bash
$ kubectl create secret generic my-minio-secret --from-literal=accesskey=foobarbaz --from-literal=secretkey=foobarbazqux
```

Then install the chart, specifying that you want to use an existing secret:
```bash
$ helm install --set existingSecret=my-minio-secret minio/minio
```

The following fields are expected in the secret:

| .data.<key> in Secret      | Corresponding variable  | Description                                                                       |
|:---------------------------|:------------------------|:----------------------------------------------------------------------------------|
| `accesskey`                | `accessKey`             | Access key ID. Mandatory.                                                         |
| `secretkey`                | `secretKey`             | Secret key. Mandatory.                                                            |

All corresponding variables will be ignored in values file.

Configure TLS
-------------

To enable TLS for MinIO containers, acquire TLS certificates from a CA or create self-signed certificates. While creating / acquiring certificates ensure the corresponding domain names are set as per the standard [DNS naming conventions](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#pod-identity) in a Kubernetes StatefulSet (for a distributed MinIO setup). Then create a secret using

```bash
$ kubectl create secret generic tls-ssl-minio --from-file=path/to/private.key --from-file=path/to/public.crt
```

Then install the chart, specifying that you want to use the TLS secret:

```bash
$ helm install --set tls.enabled=true,tls.certSecret=tls-ssl-minio minio/minio
```

Pass environment variables to MinIO containers
----------------------------------------------

To pass environment variables to MinIO containers when deploying via Helm chart, use the below command line format

```bash
$ helm install --set environment.MINIO_BROWSER=on,environment.MINIO_DOMAIN=domain-name minio/minio
```

You can add as many environment variables as required, using the above format. Just add `environment.<VARIABLE_NAME>=<value>` under `set` flag.

Create buckets after install
---------------------------

Install the chart, specifying the buckets you want to create after install:

```bash
$ helm install --set buckets[0].name=bucket1,buckets[0].policy=none,buckets[0].purge=false minio/minio
```

Description of the configuration parameters used above -

- `buckets[].name` - name of the bucket to create, must be a string with length > 0
- `buckets[].policy` - can be one of none|download|upload|public
- `buckets[].purge` - purge if bucket exists already
