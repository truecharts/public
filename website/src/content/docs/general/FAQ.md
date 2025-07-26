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

Linux has a limited count of "open" or "read" files, that you might need to increase as follows:

- `fs.inotify.max_user_watches = 524288`
- `fs.inotify.max_user_instances = 512`

Clustertool already includes these sysctl values by default.

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

### Why don't you advise users to enable `Host-Networking`?

"When using host networking, a port is linked to the pod. Sadly enough, those ports are NOT correctly freed when HostNetworking is disabled in the future", see [discussion](https://github.com/k3s-io/k3s/discussions/7382).

## My Chart is asking for a default password, what is it?

We use upstream containers. If the password is not on our website, please refer to the upstream container sources we list on the website instead.

## My Chart application has had an upstream update, but the Chart is not updated yet?

It can sometimes take a few days for our automation tools to pick up updates, please sit tight. Please only report missed updates via a [GitHub issue](https://github.com/trueforge-org/truecharts/issues/new/choose) when 7 days have passed *after the new upstream*container\* has become available.

## Isn't there more documentation for a chart?

If it's not on our website or the Discord, we (sadly) do not have documentation available. There might be other sources for documentation however!

If you'd like to create a guide for the website, please submit a PR as demonstrated in the [Contribution Example](/development/contibuting-example/).

## I would like another application to be added, how do I do this?

Build the chart yourself (or have someone build it for you) and request to have it added to the project via a Github PR. You can check the **#development** channel of our [Discord](/s/discord) and create a thread if you'd like information about this.

An easy way to build your own chart is to use our `app-template` which provides an empty chart which you can use on your local cluster to build your own helm-chart.

The exception to the above are more complex Kubernetes ecosystem changes e.g. Kubernetes extensions, new metrics opens, databases, etc. You're still free to discuss these in the **#development** channel of our Discord linked above.

## How do I know if there are Breaking Changes?

TrueCharts uses Semantic Versioning on the aspects of the chart that TrueCharts has changed. Some upstream **containers** use `latest` tags or poor versioning schemes so updates aren't always clear if they contain breaking changes. Be sure to check the **changelog** for each chart before updating.

## How do I tell that this update is a major and potentially breaking change?

You should always check **BOTH** `chart` version **AND** `container` version as both could have breaking changes on major updates independently. Major changes are marked by a change in the first digit of the version. eg. 13.2.1 → 14.0.0.

## What to do before trying a breaking change update?

Check Changelog to see possible changes and include upstream changes

## Do you offer support for breaking changes?

### Breaking change in chart

We try to help on a best effort basis, but support will be limited as they are expected to be more-or-less breaking and we cannot control all scenarios.

### Breaking change in container

We can try to look at your setup/logs and see if there is anything obvious, but apart from that we can't offer support for a product that we did not develop. You most likely will have to reach to the upstream support channels for that.

## Why is my OpenVPN password not working?

Don't use `$` in your passwords, it won't work due to an upstream [bug](https://github.com/dperson/openvpn-client/issues/376) in the OpenVPN container.

## Why is a beta-only container in the stable train?

The `stable` train refers to the stability of our chart, not the container itself. However, if the container exhibits significant bugs or regularly introduces breaking changes, our chart may be reverted back to `incubator` until these issues are resolved.

## General Errors

### cannot patch "APPNAME-redis" with kind StatefulSet

`[EFAULT] Failed to update App: Error: UPGRADE FAILED: cannot patch "APPNAME-redis" with kind StatefulSet: StatefulSet.apps "APPNAME-redis" is invalid: spec: Forbidden: updates to statefulset spec for fields other than 'replicas', 'ordinals', 'template', 'updateStrategy', 'persistentVolumeClaimRetentionPolicy' and 'minReadySeconds' are forbidden`

The solution: Check which apps have statefulsets by running:

```bash
kubectl get statefulsets -A
```

Then, to delete the statefulset:

```bash
kubectl delete statefulset STATEFULSETNAME -n namespace
```

Example:

```bash
kubectl delete statefulset nextcloud-redis -n nextcloud
```

Once deleted you can attempt the update (or if you were already updated to latest versions, then edit and save without any changes).

## Operator-Related

Truecharts charts usually require a certain set of "operators" to properly work and function. Usually missing operators will lead to errors.
All required and recommended operators are listed in our [quick-start guide](/guides/)

### "monitoring.coreos.com/v1" ensure CRDs are installed first

`[EFAULT] Failed to update App: Error: UPGRADE FAILED: unable to build kubernetes objects from current release manifest: resource mapping not found for name: "APPNAME" namespace: "APPNAME" from "": no matches for kind "PodMonitor" in version "monitoring.coreos.com/v1" ensure CRDs are installed first`

The solution:

- Install `kube-prometheus-stack` first, then go back and install the app you were trying to install

#### addresspools.metallb.io

`[EFAULT] Failed to install App: Error: INSTALLATION FAILED: rendered manifests contain a resource that already exists. Unable to continue with install: CustomResourceDefinition "addresspools.metallb.io" in namespace "" exists and cannot be imported into the current release: invalid ownership metadata; label validation error: missing key "app.kubernetes.io/managed-by": must be set to "Helm"; annotation validation error: missing key "meta.helm.sh/release-name": must be set to "metallb"; annotation validation error: missing key "meta.helm.sh/release-namespace": must be set to "ix-metallb"`

The solution: The **Metallb chart** is required for the use of MetalLB to have each chart utilize a unique IP address.

#### alertmanagerconfigs.monitoring.coreos.com

`[EFAULT] Failed to install chart release: Error: INSTALLATION FAILED: rendered manifests contain a resource that already exists. Unable to continue with install: CustomResourceDefinition "alertmanagerconfigs.monitoring.coreos.com" in namespace "" exists and cannot be imported into the current release: invalid ownership metadata; label validation error: missing key "app.kubernetes.io/managed-by": must be set to "Helm"; annotation validation error: missing key "meta.helm.sh/release-name": must be set to "prometheus-operator"; annotation validation error: missing key "meta.helm.sh/release-namespace": must be set to "ix-prometheus-operator"`

The solution: The **Prometheus crds** are required for the use of Prometheus metrics and for any charts that utilize CloudNative Postgresql (CNPG).

### Operator [traefik] has to be installed first

`Failed to install App: Operator [traefik] has to be installed first`

The solution: If this error appears while installing Traefik, install Traefik with its own ingress disabled first. Once it's installed you can enable ingress for traefik.

### Operator [cloudnative-pg] has to be installed first

`Failed to install App: Operator [cloudnative-pg] has to be installed first`

The solution: Install `Cloudnative-PG`.

### Can't upgrade between ghcr.io/cloudnative-pg/postgresql

`[EFAULT] Failed to update App: Error: UPGRADE FAILED: cannot patch "APPNAME-cnpg-main" with kind Cluster: admission webhook "vcluster.cnpg.io" denied the request: Cluster.cluster.cnpg.io "APPNAME-cnpg-main" is invalid: spec.imageName: Invalid value: "ghcr.io/cloudnative-pg/postgresql:16.2": can't upgrade between ghcr.io/cloudnative-pg/postgresql:15.2 and ghcr.io/cloudnative-pg/postgresql:16.2`

The solution: In the Postgresql section of the chart config, change `Postgres Version` from 16 to 15

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
