---
title: TopoLVM
---

TopoLVM is a CSI plugin using LVM for Kubernetes. It can be considered as a specific implementation of local persistent volumes using CSI and LVM.

Their repo and helm chart are available at: https://github.com/topolvm/topolvm

Nothing in this guide is specific to TrueCharts. There are some Talos-specific steps, but they can be completed even more simply on other OSs.

## Requirements

TopoLVM requires it's own LVM Volume Group to provision storage from. In this guide we'll assume you're accomplishing this by providing a separate drive (or virtual disk) specifically for TopoLVM to keep it more simple.

### LVM Prep

In this guide we are preparing LVM to use in a clustertool environment. Also the configuration is done in a way it can be used by e.g. volsync for backup/restore functionalities.
Complete preparation is based upon:
- https://github.com/topolvm/topolvm/blob/main/docs/getting-started.md
- https://github.com/topolvm/topolvm/blob/main/docs/snapshot-and-restore.md

Most important highlights of above are the:

- Use of cert-manager
- Correctly labeled namespaces
- Installation of CRDs and the controller for volume snapshots

All are implemented and setup in Clustertool for your convenience.

To prepare the disk for a thin pool, use TrueCharts' LVM_disk_watcher chart and container, which can do these steps to a disk you configure.
Chart information at: https://truecharts.org/charts/system/lvm-disk-watcher/

Find the name of the disk you want to use for TopoLVM. With Talos OS, use `talosctl disks` to list the names of the available disks. You may need to install another disk to your VM or your bare-metal server.

## Install Lvm_Disk

Create the namespace with these labels:

```yaml
apiVersion: v1
kind: Namespace
metadata:
    name: lvm-disk-watcher
    labels:
        pod-security.kubernetes.io/enforce: privileged
        topolvm.io/webhook: ignore
```

Example of deployment:

```yaml
apiVersion: helm.toolkit.fluxcd.io/v2
kind: HelmRelease
metadata:
    name: lvm-disk-watcher
    namespace: lvm-disk-watcher
spec:
    interval: 5m
    releaseName: lvm-disk-watcher
    chart:
        spec:
            chart: lvm-disk-watcher
            version: 1.1.0                 
            sourceRef:
                kind: HelmRepository
                name: truecharts
                namespace: flux-system
    install:
        createNamespace: true
        crds: CreateReplace
        remediation:
            retries: 3
    upgrade:
        crds: CreateReplace
        remediation:
            retries: 3
    values: {}
```

## Install TopoLVM

Now that you've completed your prep on the node to create volumes for TopoLVM to use, we can install TopoLVM.
The reference Values and their explanations could be find here:
https://github.com/topolvm/topolvm/blob/main/charts/topolvm/values.yaml

### Helm Values

The key things to update are adding a device-class that will use your thin pool, and adding a storage class that will use that device-class. Read their helm chart for more options.
The following example can be used and adjust where necesarry.

```yaml
  values:
    lvmd:
      managed: false
      env:
        - name: LVM_SYSTEM_DIR
          value: /tmp
      deviceClasses:
        - name: thin
          volume-group: topolvm_vg                     # Volume Group name used in LVM_Disk_Watcher
          default: true
          spare-gb: 10
          type: thin
          thin-pool:
            name: topolvm_thin                         # Logical Volume name used in LVM_Disk_Watcher
            overprovision-ratio: 10.0                  # Adjust to your convenience
    storageClasses:
      - name: topolvm-thin-provisioner
        storageClass:
          fsType: xfs
          isDefaultClass: true                         # If don't want to have this as your Default Storage Class in your cluster, set to false.
          volumeBindingMode: WaitForFirstConsumer
          allowVolumeExpansion: true
          additionalParameters:
            "topolvm.io/device-class": "thin"
    node:
      lvmdEmbedded: true

## Optional setting for a single node cluster:
    # controller:
    #   replicaCount: 1
```

## Kernel Modules

Add these two kernel modules. Use modprobe for typical linux installs or add them to your talconfig.yaml if using TalHelper or ClusterTool as shown below:

```yaml
#talconfig.yaml
nodes:
  - hostname: k8s-control-1
    kernelModules:
      - name: dm_thin_pool
      - name: dm_mod
```

### Manually add disks

:::danger[Data Loss]

These steps could lead to data loss if done on the wrong disks.

:::

These commands set up a Volume Group and Thin Pool for TopoLVM to use. The names of these will need to be put into your TopoLVM Helm Values. The name of the disk may vary depending on your setup.

Create a Physical Volume

```bash
pvcreate /dev/vdb
```

Create a Volume Group

```bash
vgcreate topolvm_vg /dev/vdb
```

Create a Thin Pool

```bash
lvcreate -l 100%FREE --chunksize 256 -T -A n -n topolvm_thin topolvm_vg
```

## Create Privilaged Namespace

Create the namespace with these labels:

```yaml
apiVersion: v1
kind: Namespace
metadata:
    name: topolvm-system
    labels:
        pod-security.kubernetes.io/enforce: privileged
        topolvm.io/webhook: ignore
```

## Other references

Other resource for guidance: https://github.com/topolvm/topolvm/blob/main/docs/proposals/thin-volumes.md
