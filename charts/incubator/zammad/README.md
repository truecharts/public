# Zammad Helm Chart

This directory contains a Kubernetes chart to deploy [Zammad](https://zammad.org/) ticket system.

## Prerequisites Details

- Kubernetes 1.19+
- Helm 3.x
- Cluster with at least 4GB of free RAM

## Chart Details

This chart will do the following:

- Install Zammad statefulset
- Install Elasticsearch, Memcached, PostgreSQL & Redis as requirements

## Installing the Chart

To install the chart use the following:

```console
helm repo add zammad https://zammad.github.io/zammad-helm
helm upgrade --install zammad zammad/zammad --namespace zammad
```

## Configuration

See [Customizing the Chart Before Installing](https://helm.sh/docs/intro/using_helm/#customizing-the-chart-before-installing). To see all configurable options with detailed comments, visit the chart's [values.yaml](./values.yaml), or run these configuration commands:

```console
helm show values zammad/zammad
```

### Important note for NFS filesystems

For persistent volumes, NFS filesystems should work correctly for **Elasticsearch** and **PostgreSQL**; however, errors will occur if Zammad itself uses an NFS-based persistent volume. Websockets will break completely. This is particularly bad news for receiving notifications from the application and using the Chat module.

Don't use an NFS-based storage class for Zammad's persistent volume.

This is relevant to **EFS** for AWS users, as well.

### OpenShift

To run OpenShift unprivileged and with [arbitrary UIDs and GIDs](https://cloud.redhat.com/blog/a-guide-to-openshift-and-uids):

- Add the extraRsyncParams `--no-perms --omit-dir-times`.
- [Delete the default key](https://helm.sh/docs/chart_template_guide/values_files/#deleting-a-default-key)  `securityContext` and `zammadConfig.initContainers.zammad.securityContext.runAsUser` with `null`.
- Disable if used:
  - also `podSecurityContext` in all subcharts.
  - the privileged [sysctlImage](https://github.com/bitnami/charts/tree/main/bitnami/elasticsearch#default-kernel-settings) in elasticsearch subchart.

```yaml
securityContext: null

zammadConfig:
  initContainers:
    zammad:
      extraRsyncParams: "--no-perms --omit-dir-times"
      securityContext:
        runAsUser: null
  railsserver:
    tmpdir: "/opt/zammad/var/tmp"


initContainers:
  - name: railsserver-tmp-init
    image: "alpine:3.18.2"
    command:
      - /bin/sh
      - -cx
      - |
        mkdir -p /opt/zammad/var/tmp && chmod +t /opt/zammad/var/tmp
    volumeMounts:
      - name: zammad-var
        mountPath: /opt/zammad/var

elasticsearch:
  sysctlImage:
    enabled: false
  master:
    podSecurityContext:
      enabled: false
    containerSecurityContext:
      enabled: false

memcached:
  podSecurityContext:
    enabled: false
  containerSecurityContext:
    enabled: false

redis:
  master:
   podSecurityContext:
     enabled: false
   containerSecurityContext:
     enabled: false
  replica:
    podSecurityContext:
      enabled: false
    containerSecurityContext:
      enabled: false
```

## Using zammad

Once the zammad pod is ready, it can be accessed using the ingress or port forwarding.
To use port forwarding:

```console
kubectl -n zammad port-forward service/zammad 8080
```

Open your browser on <http://localhost:8080>

## Upgrading

### From chart version 8.x to 9.0.0

- Zammads PVC changed to only hold contents of /opt/zammad/var & /opt/zammad/storage instead of the whole Zammad content
  - A new PVC `zammad-var` is created for this
  - the old zammad PVC is kept in case you need data from there (for example if you used filesystem storage)
    - you need to copy the contents of /opt/zammad/storage to the new volume manually or restore them from a backup
  - to update Zammad you have to delete the Zammad StatefulSet first, as the immutable volume config is changed
    - `kubectl delete sts zammad`
    - `helm upgrade zammad zammad/zammad`
- Zammads initContainer rsync step is no longer needed and therfore removed
- DB config is now done via `DATABASE_URL` env var instead of creating a database.yml in the config directory
- Zammads pod securityContext has a new default setting for "seccompProfile:" with value "type: RuntimeDefault"
- Docker registry changed to ghcr.io/zammad/zammad
- auto_wizard.json is placed into /opt/zammad/var directory now
- All subcharts have been updated

### From chart version 7.x to 8.0.0

SecurityContexts of pod and containers are configurable now.
We also changed the default securitycontexts, to be a bit more restrictive, therefore the major version upgrade of the chart.

On the pod level the following defaults are used:

```yaml
securityContext:
  fsGroup: 1000
  runAsUser: 1000
  runAsNonRoot: true
  runAsGroup: 1000
```

On the containerlevel the following settings are used fo all zammad containers now (some init containers may run as root though):

```yaml
    securityContext:
      allowPrivilegeEscalation: false
      capabilities:
        drop:
          - ALL
      readOnlyRootFilesystem: true
      privileged: false
```

As `readOnlyRootFilesystem: true` is set for all Zammad containers, the Nginx container writes its PID and tmp files to `/tmp`.
The `/tmp` volume can be configured via `zammadConfig.tmpDirVolume`. Currently a 100Mi emptyDir is used for that.
The nginx config in `/etc/nginx/nginx.conf` is now populated from the Nginx configmap too.

If the volumpermissions initContainer is used, the username and group are taken from the `securityContext.runAsUser` & `securityContext.runAsGroup` variables.

The rsync command in the zammad-init container has been changed to not use "--no-perms --no-owner --no-group --omit-dir-times".
If you wan't the old behaviout use the new `.Values.zammadConfig.initContainers.zammad.extraRsyncParams` variable, to add these options again.

We've also set the Elasticsearch master heapsize to "512m" by default.

### From chart version 6.x to 7.0.0

- Bitnami Elasticsearch chart is used now as Elastic does not support the old chart anymore in favour of ECK operator
  - reindexing of all data is needed so get sure "zammadConfig.elasticsearch.reindex" is set to "true"
- Memchached was updated from 6.0.16 to 6.3.0
- PostgreSql chart was updated from 10.16.2 to 12.1.0
  - this includes major version change of Postgres DB version too
  - backup / restore is needed to update
  - postgres password settings were changed
  - see also upgrading [PostgreSql upgrading notes](https://github.com/bitnami/charts/tree/main/bitnami/postgresql#upgrading)
- Redis chart is updated from 16.8.7 to 17.3.7
  - see [Redis upgrading notes](https://github.com/bitnami/charts/tree/main/bitnami/redis#to-1700)
- Zammad
  - Pod Security Policy settings were removed as these are [deprecated in Kubernetes 1.25](https://kubernetes.io/docs/concepts/security/pod-security-policy/)
  - Docker image tag is used from Chart.yaml "appVersion" field by default
  - Replicas can be configured (needs ReadWriteMany volume if replica > 1!)
  - livenessProbes and readinessProbe have been adjusted to not be the same
  - config values has been removed from chart readme as it's easier to maintain them at a single place

### From chart version 6.0.4 to 6.0.x

- minimum helm version now is 3.2.0+
- minimum Kubernetes version now is 1.19+

### From chart version 5.x to 6.x

- `envConfig` variable was replaced with `zammadConfig`
- `nginx`, `rails`, `scheduler`, `websocket` and `zammad` vars has been merged into `zammadConfig`
- Chart dependency vars have changed (reside in `zammadConfig` too now), so if you've disabled any of them you have to adapt to the new values from the Chart.yaml
- `extraEnv` var is a list now

### From chart version 4.x to 5.x

- health checks have been extended from boolean flags that simply toggle readinessProbes and livenessProbes on the containers to templated
  ones: .zammad.{nginx,rails,websocket}.readinessProbe and .zammad.{nginx,rails,websocket}.livenessProbe have been removed in favor of livenessProbe/readinessProbe
  templates at .{nginx,railsserver,websocket}. You can customize those directly in your overriding values.yaml.
- resource constraints have been grouped under .{nginx,railsserver,websocket} from above. They are disabled by default (same as prior versions), but in your overrides, make sure
  to reflect those changes.

### From chart version 1.x

This has changed:

- requirement chart condition variable name was changed
- the labels have changed
- the persistent volume claim was changed to persistent volume claim template
  - import your filebackup here
- all requirement charts has been updated to the latest versions
  - Elasticsearch
    - docker image was changed to elastic/elasticsearch
    - version was raised from 5.6 to 7.6
    - reindexing will be done automatically
  - Postgres
    - bitnami/postgresql chart is used instead of stable/postgresql
    - version was raised from 10.6.0 to 11.7.0
    - there is no automated upgrade path
    - you have to import a backup manually
  - Memcached
    - bitnami/memcached chart is used instead of stable/memcached
    - version was raised from 1.5.6 to 1.5.22
    - nothing to do here

**Before the update backup Zammad files and make a PostgreSQL backup, as you will need these backups later!**

- If your helm release was named "zammad" and also installed in the namespace "zammad" like:

```bash
helm upgrade --install zammad zammad/zammad --namespace=zammad --version=1.2.1
```

- Do the upgrade like this:

```bash
helm delete --purge zammad
kubectl -n zammad delete pvc data-zammad-postgresql-0 data-zammad-elasticsearch-data-0 data-zammad-elasticsearch-master-0
helm upgrade --install zammad zammad/zammad --namespace=zammad --version=2.0.3
```

- Import your file and SQL backups inside the Zammad & Postgresql containers

### From Zammad 2.6.x to 3.x

As Helm 2.x was deprecated Helm 3.x is needed now to install Zammad Helm chart.
Minimum Kubernetes version is 1.16.x now.

As Porstgresql dependency Helm chart was updated to, have a look at the upgrading instructions to 9.0.0 and 10.0.0 of the Postgresql chart:

- <https://artifacthub.io/packages/helm/bitnami/postgresql#to-9-0-0>
- <https://artifacthub.io/packages/helm/bitnami/postgresql#to-10-0-0>

### From Zammad 3.5.x to 4.x

Ingress config has been updated to the default of charts created with Helm 3.6.0 so you might need to adapt your ingress config.
