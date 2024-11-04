---
sidebar:
  order: 4
title: Frequently Asked Questions (FAQ)
---

TrueCharts Frequently Asked Questions

*For the ClusterTool FAQ, see the ClusterTool section*

## Why PVC is recommended over HostPath?

We recommend using PVC for app "config" storage, as it provides an easy way to roll back your application in case of a failed update. Furthermore, we currently only offer active support for this storage option. You can still use HostPath for your media and other files.

:::tip

To share data, create an `NFS` share and select `NFS Share` for the "Type of Storage" in the "Additional App Storage" settings. You can create an `SMB` share on the same mount point if needed.

:::

## How can I access data inside PVCs?

You can use [HeavyScript](https://github.com/Heavybullets8/heavy_script) to mount the PVC and un-mount once you finish. Use your preferred editor/explorer to do any changes you want. You need to make sure permissions stay the same, or the app might not be able to access the files.

## Do we support ACLs for HostPath storage?

While it is technically feasible to use Access Control Lists (ACLs) for HostPath storage in **_most_** Charts/Apps, we strongly advise against it. We are unable to provide individual guidance to every user for setting up their ACLs for each chart. Apart from a few exceptions, user 568 (apps) must have access to their HostPath storage.

## Are there Ingress requirements for certain apps?

Certain applications require ingress to work correctly for security reasons.
Some examples are:

- Authelia
- Authentik
- VaultWarden
- NextCloud
- Monica
- Recipes

## Inotify Issues

Linux, including TrueNAS SCALE, has a limited count of "open" or "read" files, that you might need to increase as follows:

### Set Inotify on TrueNAS Scale

System settings > Advanced > Sysctl section. It should be noted that adjusting these values will slightly increase RAM usage, and you need to reboot SCALE for them to take effect after being added. Good values to start with would be:

- `fs.inotify.max_user_watches = 524288`
- `fs.inotify.max_user_instances = 512`

## Date-Time Issues

Any modern operating system can have issues with time and date synchronization. However, accurate date time is absolutely crucial for a lot of applications, HTTPS/TLS, backup and synchronization of databases.

Fortunately you can often easily check this on Linux using the command:

```bash
date
```

If the time/date does match then proceed to run the following commands:

```bash
sudo systemctl stop ntp && sudo ntpd -gq && sudo systemctl start ntp && date
```

The command will stop NTP, sync the clock with NTP server, start the NTP service and print the date afterwards.

_If the output of the "date" command matches the current local time for your system, then the time issue is resolved. However, if the output does not match, repeat the above steps until the system clock is properly synchronized._

## Can I use another Load Balancer in front of Traefik?

Technically, yes, you can. But keep in mind this is out of our support scope.

## Do we support other proxies and Load Balancers in front of Traefik?

Not supported for standard support channels. This includes CloudFlare proxy.

## What is the meaning of Advanced/Expert Checkboxes (Networking, Storage, etc)?

These options are intended for experienced individuals and are beyond the scope of basic support. If you select these checkboxes or enable features such as Host Networking, it could potentially break your app and require a reinstall to restore functionality.

### Why don't you advise users to enable `Host-Networking`?

"When using host networking, a port is linked to the pod. Sadly enough, those ports are NOT correctly freed when HostNetworking is disabled in the future", see [discussion](https://github.com/k3s-io/k3s/discussions/7382).

## My Chart is asking for a default password, what is it?

We use upstream containers. If the password is not on our website, please refer to the upstream container sources we list on the website instead.

## My Chart application has had an upstream update, but the Chart is not updated yet?

It can sometimes take a few days for our automation tools to pick up updates, please sit tight. Please only report missed updates via a [GitHub issue](https://github.com/truecharts/containers/issues/new/choose) when 7 days have passed *after the new upstream*container\* has become available.

## Isn't there more documentation for a chart?

If it's not on our website or the Discord, we (sadly) do not have documentation available. There might be other sources for documentation however!

If you'd like to create a guide for the website, please submit a PR as demonstrated in the [Contribution Example](/development/contibuting-example/).

## I would like another application to be added, how do I do this?

There are two ways to do this:

~~1. Place a chart request bounty using the page on [Open Collective](https://opencollective.com/truecharts-bounties/contribute/request-chart-bounty-72004). Reach out to us on Discord or email orders@truecharts.org if you'd like to discuss further. ~~ Temporarily suspended.

2. Build the app yourself (or have someone build it for you) and request to have it added to the project via a Github PR. You can check the **#development** channel of our [Discord](/s/discord) and create a thread if you'd like information about this.

The exception to the above are more complex Kubernetes ecosystem changes e.g. Kubernetes extensions, new metrics opens, databases, etc. You're still free to discuss these in the **#development** channel of our Discord linked above.

## How do I know if there are Breaking Changes?

TrueCharts uses Semantic Versioning on the aspects of the chart that TrueCharts has changed. Some upstream **containers** use `latest` tags or poor versioning schemes so updates aren't always clear if they contain breaking changes. Be sure to check the **changelog** for each chart before updating.

## How do I tell that this update is a major and potentially breaking change?

You should always check **BOTH** `chart` version **AND** `container` version as both could have breaking changes on major updates independently. Major changes are marked by a change in the first digit of the version. eg. 13.2.1 → 14.0.0.

## What to do before trying a breaking change update?

Take backups beforehand with [HeavyScript](https://github.com/Heavybullets8/heavy_script).

## Does HeavyScript auto-update major changes?

It depends on the flags you used. We recommend **NOT** using the `-a` flag, as this will update to major version changes which may include breaking changes.

## Do you offer support for breaking changes?

### Breaking change in chart

We try to help on a best effort basis, but support will be limited as they are expected to be more-or-less breaking and we cannot control all scenarios.

### Breaking change in container

We can try to look at your setup/logs and see if there is anything obvious, but apart from that we can't offer support for a product that we did not develop. You most likely will have to reach to the upstream support channels for that.

## Why is my OpenVPN password not working?

Don't use `$` in your passwords, it won't work due to an upstream [bug](https://github.com/dperson/openvpn-client/issues/376) in the OpenVPN container.

## Why is a beta-only container in the stable train?

The `stable` train refers to the stability of our chart, not the container itself. However, if the container exhibits significant bugs or regularly introduces breaking changes, our chart may be reverted back to `incubator` until these issues are resolved.

## My app stays stopped even after clicking the start button multiple times.

The following apps do not have active services running under an `ix` namespace, and as a result, they will always appear as "Stopped" in the SCALE UI:

- `External-Service`
- `MetalLB-Config`
- `ClusterIssuer`
- `PostgreSQL`
- `VolumeSnapshots`

## How do I stop a TrueCharts App? (**TrueNAS SCALE Only**)

:::note

For reasons why this is necessary please see [Known Issues](/news/updates-recontinued#known-issues)

:::

:::caution

Do **NOT** hit the `Stop` button in the SCALE GUI **_UNLESS_** you are certain the App does not use [CloudNativePG (CNPG)](https://cloudnative-pg.io/).

:::

### How do I know if an App uses CNPG?

Here's a list of Apps in the stable and premium trains that use CNPG (up to date as of 3rd May 2023):

`airsonic-advanced`
`authelia`
`authentik`
`babybuddy`
`baserow`
`blog`
`commento-plusplus`
`discordgsm`
`dsmr-reader`
`etherpad`
`ferdi-server`
`fireflyiii`
`firefox-syncserver`
`focalboard`
`gitea`
`gotify`
`grist`
`guacamole-client`
`hedgedoc`
`home-assistant`
`immich`
`inventree`
`invidious`
`joplin-server`
`kanboard`
`kutt`
`librephotos`
`linkwarden`
`lychee`
`mattermost`
`mealie`
`miniflux`
`n8n`
`nextcloud`
`nocodb`
`odoo`
`onlyoffice-document-server`
`openkm`
`outline`
`paperless-ngx`
`penpot`
`photoview`
`postgresql`
`quassel-core`
`recipes`
`redmine`
`shiori`
`shlink`
`spotweb`
`statping-ng`
`strapi`
`synapse`
`teedy`
`traccar`
`tt-rss`
`vaultwarden`
`vikunja`
`weblate`
`wger`
`wikijs`
`xwiki`

:::tip

You can also click the App and check the Container Images for references to either `tccr.io/truecharts/postgresql` or `ghcr.io/cloudnative-pg`.

:::

If the App does not use CNPG, you have several options to stop an App:

- 1. Press the Stop button in the Scale GUI.

- 2. Enter the following command in the Shell (replace `<app-name>` with the name of the App):
     `k3s kubectl scale deploy <app-name> -n ix-<app-name> --replicas=0`

- 3. Use [HeavyScript](https://github.com/Heavybullets8/heavy_script).

### What If I've already pressed the Stop button on an App that uses CNPG?

To recover from the App being in an unstable state enter this command in the Shell to restart the middleware service:

```bash
sudo service middlewared restart
```

OR

```bash
sudo systemctl restart middlewared
```

### So, how do I stop an App that uses CNPG?

**NEVER** use the `Stop` button!

Use option 2 above or use the Heavyscript `args` functions.

To stop:

```bash
heavyscript app --stop APPNAME
```

To start:

```bash
heavyscript app --start APPNAME
```

:::note

The application state in the web GUI will be `Started` since there is still a CNPG deployment running.

:::

:::danger

**NEVER EVER** try to stop any CNPG related pods.

:::

## Operators

TrueCharts has always required operators for many charts to work. Prior to 01 July 2023, these prerequisites were installed automatically and were not visible to the end user. TrueCharts now requires that these system be installed by the end user and the previous automatically installed operators to be removed. These operators are located on the [system TrueCharts train](/. Any users who just started the use of TrueCharts after 01 July 2023 will not have the old operator prerequisites installed and can proceed with the installation of the new ones from the operator train per our [Getting Started guide](/.

### Prometheus-Operator

This operator is required for the use of Prometheus metrics and for any charts that utilize CloudNative PostgreSQL (CNPG).

To remove the previous automatically installed operator run this in the system shell as **root**: `k3s kubectl delete  --grace-period 30 --v=4 -k https://github.com/truecharts/manifests/delete3`

### Cloudnative-PG

This operator is required for the use of any charts that utilize CloudNative PostgreSQL (CNPG).

:::caution[DATA LOSS]

The following command is destructive and will delete any existing CNPG databases.

Run the following command in system shell as **root** to see if you have any current CNPG databases to migrate: `k3s kubectl get pods -A | grep cnpg`

Follow [this guide](/ to safely migrate any existing CNPG databases.

:::

To remove the previous automatically installed operator run this in the system shell as **root**: `k3s kubectl delete  --grace-period 30 --v=4 -k https://github.com/truecharts/manifests/delete2`

### Cert-Manager

This operator is required for the use of Cert-Manager (Clusterissuer) to issue certificates for chart ingress.

To remove the previous automatically installed operator run this in the system shell as **root**: `k3s kubectl delete  --grace-period 30 --v=4 -k https://github.com/truecharts/manifests/delete4`

### MetalLB

This operator is required for the use of MetalLB to have each chart utilize a unique IP address.

:::caution[LOSS OF CONNECTIVITY]

Installing the MetalLB operator will prevent the use of the TrueNAS Scale integrated load balancer. Only install this operator if you intend to use MetalLB.

:::

To remove the previous automatically installed operator run this in the system shell as **root**: `k3s kubectl delete  --grace-period 30 --v=4 -k https://github.com/truecharts/manifests/delete`

### Traefik

This operator is required for the use of ingress to access apps using a fully qualified domain name (FQDN). This is also the chart for the Traefik dashboard and is located on the [premium TrueCharts train](/.

## General Errors

### nil pointer evaluating interface {}.mode

`[EFAULT] Failed to install chart release: Error: INSTALLATION FAILED: template: APPNAME/templates/common.yaml:1:3: executing "APPNAME/templates/common.yaml" at : error calling include: template: APPNAME/charts/common/templates/loader/_all.tpl:6:6: executing "tc.v1.common.loader.all" at : error calling include: template: APPNAME/charts/common/templates/loader/_apply.tpl:47:6: executing "tc.v1.common.loader.apply" at : error calling include: template: APPNAME/charts/common/templates/spawner/_pvc.tpl:25:10: executing "tc.v1.common.spawner.pvc" at : error calling include: template: APPNAME/charts/common/templates/lib/storage/_validation.tpl:18:43: executing "tc.v1.common.lib.persistence.validation" at <$objectData.static.mode>: nil pointer evaluating interface {}.mode`

The issue: This error is due to old version of Helm. Helm > 3.9.4 is required.

The solution: Upgrade to TrueNAS SCALE Cobia (23.10.x) or newer. System Settings -> Update -> Select Cobia from the dropdown. SCALE Bluefin and Angelfish releases are no longer supported.

[See our Support Policy](/

---

### cannot patch "APPNAME-redis" with kind StatefulSet

`[EFAULT] Failed to update App: Error: UPGRADE FAILED: cannot patch "APPNAME-redis" with kind StatefulSet: StatefulSet.apps "APPNAME-redis" is invalid: spec: Forbidden: updates to statefulset spec for fields other than 'replicas', 'ordinals', 'template', 'updateStrategy', 'persistentVolumeClaimRetentionPolicy' and 'minReadySeconds' are forbidden`

The solution: Check which apps have statefulsets by running:

```bash
k3s kubectl get statefulsets -A | grep "ix-"
```

Then, to delete the statefulset:

```bash
k3s kubectl delete statefulset STATEFULSETNAME -n ix-APPNAME
```

Example:

```bash
k3s kubectl delete statefulset nextcloud-redis -n ix-nextcloud
```

Once deleted you can attempt the update (or if you were already updated to latest versions, then edit and save without any changes).

## Operator-Related Errors

### service "cnpg-webhook-service" not found

`[EFAULT] Failed to update App: Error: UPGRADE FAILED: cannot patch "APPNAME-cnpg-main" with kind Cluster: Internal error occurred: failed calling webhook "mcluster.cnpg.io": failed to call webhook: Post "https://cnpg-webhook-service.ix-cloudnative-pg.svc/mutate-postgresql-cnpg-io-v1-cluster?timeout=10s": service "cnpg-webhook-service" not found`

The solution:

- Enter the following command

```bash
k3s kubectl delete deployment.apps/cloudnative-pg --namespace ix-cloudnative-pg
```

- Update `Cloudnative-PG` to the latest version, or if you already on the latest version, edit `cCloudnative-PG` and save/update it again without any changes.
- If the app remains stopped, hit the start button in the UI for `Cloudnative-PG`.

### "monitoring.coreos.com/v1" ensure CRDs are installed first

`[EFAULT] Failed to update App: Error: UPGRADE FAILED: unable to build kubernetes objects from current release manifest: resource mapping not found for name: "APPNAME" namespace: "ix-APPNAME" from "": no matches for kind "PodMonitor" in version "monitoring.coreos.com/v1" ensure CRDs are installed first`

The solution:

- Install `Prometheus-Operator` first, then go back and install the app you were trying to install
- If you see this error with Prometheus-Operator already installed, delete it and reinstall
- While deleting Prometheus-{o}perator, if you encounter the error:

`Error: [EFAULT] Unable to uninstall 'prometheus-operator' chart release: b'Error: failed to delete release: prometheus-operator\n'`

Run the following command from the TrueNAS SCALE shell as root:

```bash
k3s kubectl delete namespace ix-prometheus-operator
```

Then install `Prometheus-Operator` again. It will fail on the first install attempt, but the second time it will work.

### Rendered manifests contain a resource that already exists

#### certificaterequests.cert-manager.io

`[EFAULT] Failed to install App: Error: INSTALLATION FAILED: rendered manifests contain a resource that already exists. Unable to continue with install: CustomResourceDefinition "certificaterequests.cert-manager.io" in namespace "" exists and cannot be imported into the current release: invalid ownership metadata; label validation error: missing key "app.kubernetes.io/managed-by": must be set to "Helm"; annotation validation error: missing key "meta.helm.sh/release-name": must be set to "cert-manager"; annotation validation error: missing key "meta.helm.sh/release-namespace": must be set to "ix-cert-manager"`

The solution: The **Cert-Manager operator** is required for the use of Cert-Manager and Clusterissuer to issue certificates for chart ingress.

To remove the previous automatically installed operator run this in the system shell as **root**:

```bash
k3s kubectl delete  --grace-period 30 --v=4 -k https://github.com/truecharts/manifests/delete4
```

[See more here](/general/faq#cert-manager)

#### backups.postgresql.cnpg.io

`[EFAULT] Failed to install App: Error: INSTALLATION FAILED: rendered manifests contain a resource that already exists. Unable to continue with install: CustomResourceDefinition "backups.postgresql.cnpg.io" in namespace "" exists and cannot be imported into the current release: invalid ownership metadata; label validation error: missing key "app.kubernetes.io/managed-by": must be set to "Helm"; annotation validation error: missing key "meta.helm.sh/release-name": must be set to "cloudnative-pg"; annotation validation error: missing key "meta.helm.sh/release-namespace": must be set to "ix-cloudnative-pg"`

The solution: The **Cloudnative-PG operator** is required for the use of any charts that utilize CloudNative Postgresql (CNPG).

:::danger[DATA LOSS]

The following command is destructive and will delete any existing CNPG databases.

Run the following command in system shell as **root** to see if you have any current CNPG databases to migrate:

```bash
k3s kubectl get cluster -A
```

Follow [this guide](/ to safely migrate any existing CNPG databases.

:::

To remove the previous automatically installed operator run this in the system shell as **root**:

```bash
k3s kubectl delete  --grace-period 30 --v=4 -k https://github.com/truecharts/manifests/delete2
```

[See more here](/general/faq#cloudnative-pg)

#### addresspools.metallb.io

`[EFAULT] Failed to install App: Error: INSTALLATION FAILED: rendered manifests contain a resource that already exists. Unable to continue with install: CustomResourceDefinition "addresspools.metallb.io" in namespace "" exists and cannot be imported into the current release: invalid ownership metadata; label validation error: missing key "app.kubernetes.io/managed-by": must be set to "Helm"; annotation validation error: missing key "meta.helm.sh/release-name": must be set to "metallb"; annotation validation error: missing key "meta.helm.sh/release-namespace": must be set to "ix-metallb"`

The solution: The **Metallb operator** is required for the use of MetalLB to have each chart utilize a unique IP address.

:::danger[LOSS OF CONNECTIVITY]

Installing the MetalLB operator will prevent the use of the TrueNAS Scale integrated load balancer. Only install this operator if you intend to use MetalLB.

:::

To remove the previous automatically installed operator run this in the system shell as **root**:

```bash
k3s kubectl delete  --grace-period 30 --v=4 -k https://github.com/truecharts/manifests/delete
```

[See more here](/general/faq#metallb)

#### alertmanagerconfigs.monitoring.coreos.com

`[EFAULT] Failed to install chart release: Error: INSTALLATION FAILED: rendered manifests contain a resource that already exists. Unable to continue with install: CustomResourceDefinition "alertmanagerconfigs.monitoring.coreos.com" in namespace "" exists and cannot be imported into the current release: invalid ownership metadata; label validation error: missing key "app.kubernetes.io/managed-by": must be set to "Helm"; annotation validation error: missing key "meta.helm.sh/release-name": must be set to "prometheus-operator"; annotation validation error: missing key "meta.helm.sh/release-namespace": must be set to "ix-prometheus-operator"`

The solution: The **Prometheus-operator** is required for the use of Prometheus metrics and for any charts that utilize CloudNative Postgresql (CNPG).

To remove the previous automatically installed operator run this in the system shell as **root**:

```bash
k3s kubectl delete  --grace-period 30 --v=4 -k https://github.com/truecharts/manifests/delete3
```

[See more here](/general/faq#prometheus-operator)

### Operator [traefik] has to be installed first

`Failed to install App: Operator [traefik] has to be installed first`

The solution: If this error appears while installing Traefik, install Traefik with its own ingress disabled first. Once it's installed you can enable ingress for traefik.

### Operator [cloudnative-pg] has to be installed first

`Failed to install App: Operator [cloudnative-pg] has to be installed first`

The solution: Install `Cloudnative-PG`.

:::tip

Ensure the system train is enabled in the Truecharts catalog under Apps -> Discover Apps -> Manage Catalogs.

:::

### Operator [Prometheus-operator] has to be installed first

`Failed to install App: Operator [rometheus-operator] has to be installed first`

The solution: Install `Prometheus-operator`.

:::tip

Ensure the system train is enabled in the Truecharts catalog under Apps -> Discover Apps -> Manage Catalogs.

:::

### Can't upgrade between ghcr.io/cloudnative-pg/postgresql

`[EFAULT] Failed to update App: Error: UPGRADE FAILED: cannot patch "APPNAME-cnpg-main" with kind Cluster: admission webhook "vcluster.cnpg.io" denied the request: Cluster.cluster.cnpg.io "APPNAME-cnpg-main" is invalid: spec.imageName: Invalid value: "ghcr.io/cloudnative-pg/postgresql:16.2": can't upgrade between ghcr.io/cloudnative-pg/postgresql:15.2 and ghcr.io/cloudnative-pg/postgresql:16.2`

The solution: In the Postgresql section of the app config, change `Postgres Version` from 16 to 15

## ClusterTool related questions

### Does ClusterTool include storage

By default ClusterTool ships with a single-node Longhorn setup pre-configured on the system-drive.
Its storageClass gets used by any PVC by default

### What are the network requirements of ClusterTool

- All nodes are expected to be in the same local-area network.
- While we technically do support non-/24 subnets, we heavily advice a /24 subnet
- We do not support nodes directly on a WAN-IP or kube-span related setups

### How do I alter the default config to a multi-node setup?

- Add more masternodes to talconfig
- Add more MASTER_IPs to ClusterEnv
- Alter the Longhorn replicas to 2 or 3

### How do I seperate Masters from Slave nodes?

- Set `allowSchedulingOnControlPlanes: false` in talconfig.yaml
- On the metallb helmrelease, set `ignoreExcludeLB: false`

### There are Pending pods for Cillium

We ship cillium pre-configured for multi-node, this means that on a single node they inherently keep a few pods pending

### What commands do I need to run after updating clustertool?

init, genconfig and, preferably, apply (after checking the configuration changes)

### What do I need to do to get automatic updates?

We've setup a lot for you already.
However, to get updates to propagate we advice the use of FluxCD

### Do I need to use FluxCD?

While its not *technically* required, we HEAVILY advice using FluxCD.

### Can I remove helm-charts installed by default?

We HEAVILY adviced against it, the charts in the default stack all get loaded for cluster stability.
In some cases, like kubernetes, you can disable the workloads or services in the charts themselves instead.

### Can I alter the helmrelease files for default installed charts?

Yes you can!
While we advice sticking with the defaults where possible, we fully support altering the included helm-charts to fit your usecase.
However, any issues after alterations are not within our scope for support.

### I get this error:  failed to pull chart cilium: no cached repo found.

You need to remove all http helm repositories from the system you're using clustertool on.
Please check the Helm docs on how to do this.

### I added Volsync to all charts on TrueNAS SCALE, but no data is in the bucket.

Do you get this error:
```yaml
waiting for PersistentVolumeClaim/... to bind; check StorageClass name and CSI driver capabilities
```
If not make sure your credentials are correct. If you do get the error try the following:

- Make sure you added Volsync to all SCALE apps you want to backup
- Wait atleast 30 minutes
- If still no data is propagated run the following script on your TrueNAS SCALE system:

```bash
#!/bin/bash

# Get all replicationsource names and namespaces
replicationsources=$(k3s kubectl get replicationsource -A -o jsonpath='{range .items[*]}{.metadata.namespace}{" "}{.metadata.name}{"\n"}{end}')

# Loop through each replicationsource and apply the patch
while IFS= read -r line; do
    namespace=$(echo $line | awk '{print $1}')
    name=$(echo $line | awk '{print $2}')
    echo "Patching replicationsource $name in namespace $namespace..."
    k3s kubectl patch replicationsource ${name} -n ${namespace} --type='merge' -p '{"spec":{"restic":{"copyMethod":"Direct"}, "trigger":{"manual":"{{.now}}"}}}'
done <<< "$replicationsources"

```
