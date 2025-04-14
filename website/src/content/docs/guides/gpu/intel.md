---
title: Intel-GPU
---

:::caution[Charts]

Adding a GPU to your Cluster isn't covered by the Support Policy.
Feel free to open a thread in the appropiate Channel in our Discord server.

:::

## Prerequisites

- Having your GPU isolated when using a VM
- Passed the GPU to your Talos Machine when using a VM
- Node Feature Discovery added to your cluster

## Extensions for Talhelper/Clustertool

:::caution[Charts]

This Section assumes you are using Clustertool or Talhelper for your talos cluster. The steps may differ otherwise.

:::

Its important to add the following Extensions to your `talconfig.yaml` for bootstrap:

```yaml

schematic:
    customization:
        systemExtensions:
            officialExtensions:
                - siderolabs/i915
                - siderolabs/intel-ucode
                - siderolabs/mei

```

## Adding it to your cluster

If its a fresh bootstrap you can simply follow the clustertool guide on how to bootstrap your cluster.
If it is a existing cluster you will need to run `clustertool talos upgrade` to add the extensions to your cluster.

## Adding Intel Repo for required Charts

Add the following repo to your cluster if using fluxcd:

```yaml

---
# yaml-language-server: $schema=https://kubernetes-schemas.pages.dev/source.toolkit.fluxcd.io/helmrepository_v1.json
apiVersion: source.toolkit.fluxcd.io/v1
kind: HelmRepository
metadata:
  name: home-ops-mirror
  namespace: flux-system
spec:
  type: oci
  interval: 2h
  url: oci://ghcr.io/home-operations/charts-mirror

```

## Add intel-device-plugin-operator

Add the intel-device-plugin-operator to your cluster
Example helm-release configuration:

```yaml

---
# yaml-language-server: $schema=https://kubernetes-schemas.pages.dev/helm.toolkit.fluxcd.io/helmrelease_v2.json
apiVersion: helm.toolkit.fluxcd.io/v2
kind: HelmRelease
metadata:
  name: intel-device-plugin-operator
  namespace: system
spec:
  interval: 30m
  chart:
    spec:
      chart: intel-device-plugins-operator
      version: 0.32.0
      sourceRef:
        kind: HelmRepository
        name: home-ops-mirror
        namespace: flux-system
  install:
    crds: CreateReplace
    remediation:
      retries: 3
  upgrade:
    cleanupOnFail: true
    crds: CreateReplace
    remediation:
      strategy: rollback
      retries: 3
  dependsOn:
    - name: node-feature-discovery
      namespace: kube-system
  values:
    controllerExtraArgs: |
      - --devices=gpu

```

## Add intel-device-plugin-gpu

Add the intel-device-plugin-gpu to your cluster
Example helm-release configuration:

```yaml

---
# yaml-language-server: $schema=https://kubernetes-schemas.pages.dev/helm.toolkit.fluxcd.io/helmrelease_v2.json
apiVersion: helm.toolkit.fluxcd.io/v2
kind: HelmRelease
metadata:
  name: intel-device-plugin-gpu
  namespace: system
spec:
  interval: 30m
  chart:
    spec:
      chart: intel-device-plugins-gpu
      version: 0.32.0
      sourceRef:
        kind: HelmRepository
        name: home-ops-mirror
        namespace: flux-system
  install:
    remediation:
      retries: 3
  upgrade:
    cleanupOnFail: true
    remediation:
      strategy: rollback
      retries: 3
  dependsOn:
    - name: intel-device-plugin-operator
      namespace: system
  values:
    name: intel-gpu-plugin
    sharedDevNum: 5
    nodeFeatureRule: true

```

## Check if GPU is schedulable

```bash

kubectl get nodes -o=jsonpath="{range .items[*]}{.metadata.name}{'\n'}{' i915: '}{.status.allocatable.gpu\.intel\.com/i915}{'\n'}"

```

## Example of GPU Assignment

The following shows an example on how to add the GPU to a chart. Depending on the chart you may need to adapt the workload-name.

```yaml
resources:
    limits:
      gpu.intel.com/i915: 1
```
