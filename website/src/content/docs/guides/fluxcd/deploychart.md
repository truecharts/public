---
sidebar:
  order: 3
title: Deploy a chart with Flux on your Clustertool Cluster
---

This guide will explain briefly how to deploy a chart on your brand new Clustertool Cluster using Flux.

## Create the files

- Your charts can be placed in the folder `clusters/main/kubernetes/apps/`.
- There will make a folder for your `chart` and inside that folder an `app` folder.
- In this guide we will use as example `librespeed`
- So it will be like: `clusters/main/kubernetes/apps/librespeed/app/`
- In this folder we will create two files, `helm-release.yaml` and `namespace.yaml`.

:::note[Folder Structure]

You are not limited to only use the `clusters/main/kubernetes/apps` folder. You can make any folder with subfolders in `clusters/main/kubernetes/` to organize your charts.

:::

```yaml
// namespace.yaml

apiVersion: v1
kind: Namespace
metadata:
  name: librespeed
## Add this part when you need a privileged namespace
#  labels:
#    pod-security.kubernetes.io/enforce: privileged

```

:::warning[Privileged Namespace]

Add the label for pod-security only when it is really needed. After deploying the chart and this part will be needed you will see this in your event logs.

:::

```yaml
// helm-release.yaml
---
apiVersion: helm.toolkit.fluxcd.io/v2
kind: HelmRelease
metadata:
  name: librespeed
  namespace: librespeed
spec:
  interval: 15m
  chart:
    spec:
      chart: librespeed
      version: 15.6.1
      sourceRef:
        kind: HelmRepository
        name: truecharts
        namespace: flux-system
      interval: 15m
  timeout: 20m
  maxHistory: 3
  driftDetection:
    mode: warn
  install:
    createNamespace: true
    remediation:
      retries: 3
  upgrade:
    cleanupOnFail: true
    remediation:
      retries: 3
  uninstall:
    keepHistory: false
  values:
    # Add here your chart specific values
```

## Generate and deploy

:::note[Kustomizations]

When not using clustertool, you need to add the kustomizations yourself.

:::

- Run `clustertool genconfig`. This will creates `kustomization.yaml` and `ks.yaml` files.
- Also this will update the `kustomization.yaml` in the folder above.
- Push to git
- Wait for flux to get it deployed. This can be taken up to 30 minutes. Another option you can do is run [flux reconcile](/guides/cheatsheet) or configure a flux [webhook](/guides/fluxcd/webhook).
