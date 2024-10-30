---
sidebar:
  order: 2
title: Frequently Asked Questions (FAQ)
---

:::caution[Work In Progress]

This program, all its features and its general design, are all a Work-In-Progress. It is not done and not widely available.

All code and docs are considered Pre-Beta drafts

:::


## Does ClusterTool include storage

By default ClusterTool ships with a single-node Longhorn setup pre-configured on the system-drive.
Its storageClass gets used by any PVC by default

## What are the network requirements of ClusterTool

- All nodes are expected to be in the same local-area network.
- While we technically do support non-/24 subnets, we heavily advice a /24 subnet
- We do not support nodes directly on a WAN-IP or kube-span related setups

## How do I alter the default config to a multi-node setup?

- Add more masternodes to talconfig
- Add more MASTER_IPs to ClusterEnv
- Alter the Longhorn replicas to 2 or 3

## How do I seperate Masters from Slave nodes?

- Set `allowSchedulingOnControlPlanes: false` in talconfig.yaml
- On the metallb helmrelease, set `ignoreExcludeLB: false`

## There are Pending pods for Cillium

We ship cillium pre-configured for multi-node, this means that on a single node they inherently keep a few pods pending

## What commands do I need to run after updating clustertool?

init, genconfig and, preferably, apply (after checking the configuration changes)

## What do I need to do to get automatic updates?

We've setup a lot for you already.
However, to get updates to propagate we advice the use of FluxCD

## Do I need to use FluxCD?

While its not *technically* required, we HEAVILY advice using FluxCD.

## Can I remove helm-charts installed by default?

We HEAVILY adviced against it, the charts in the default stack all get loaded for cluster stability.
In some cases, like kubernetes, you can disable the workloads or services in the charts themselves instead.

## Can I alter the helmrelease files for default installed charts?

Yes you can!
While we advice sticking with the defaults where possible, we fully support altering the included helm-charts to fit your usecase.
However, any issues after alterations are not within our scope for support.

## I get this error:  failed to pull chart cilium: no cached repo found.

You need to remove all http helm repositories from the system you're using clustertool on.
Please check the Helm docs on how to do this.

## I added Volsync to all charts on TrueNAS SCALE, but no data is in the bucket.

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
