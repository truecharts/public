---
title: FluxCD Support Policy
---

fluxcd is a so-called gitops tool.
It allows users to define their cluster in a git repository and automatically syncs said configuration with the actual cluster

:::tip

Please, always remember to check the content specific to the chart.

:::

## Tier

fluxcd is what we call a "Tier 2" deployment options.
This means that we expect it to work smoothly, all options being technically available and we've enough staff available to help-out.

With Tier 2 options, you should not have to expect issues caused by the deployment option.

## TrueCharts on FluxCD

TrueCharts aims to always support the latest version of FluxCD.
However, sometimes new versions of either TrueNAS or TrueCharts introduces breaking changes.
This document highlights which versions of TrueCharts (or rather branches), support which versions of FluxCD.

We also document which versions of TrueNAS will receive TrueCharts updates and for which versions we are accepting bug reports.

### Supported Versions of FluxCD

| FluxCD version | Branch   | Supported with updates | Accepting Support tickets | Accepting Bug Reports | Notes |
| -------------- | -------- | ---------------------- | ------------------------- | --------------------- | ----- |
| 1.2.1 or prior | `master` | ✅                     | ❌                        | ❌                    |       |

## Project Scope

For more info on what to expect from TrueCharts Apps, be sure to also read the [Project Scope documentation](/general/scope)

## How to Configure

Configuration should be done "The Helm Way" via editing HelmRelease objects in the git repository.
Values of which can be used like normal on helm.

This can be done following the [Helm Guides](/general/)

and checking all the many options available in our [Common Library Chart](/common/)

### Example Helm-Release object

```yaml
---
# yaml-language-server: $schema=https://kubernetes-schemas.zinn.ca/helm.toolkit.fluxcd.io/helmrelease_v2beta1.json
apiVersion: helm.toolkit.fluxcd.io/v2beta2
kind: HelmRelease
metadata:
  name: sonarr
  namespace: media
spec:
  interval: 15m
  chart:
    spec:
      chart: sonarr
      version: 21.5.7
      sourceRef:
        kind: HelmRepository
        name: truechartsoci
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
    ingress:
      main:
        enabled: true
        integrations:
          traefik:
            enabled: true
            middlewares:
              - name: auth
                namespace: traefik
          certManager:
            enabled: true
            certificateIssuer: ks-le-prod
        hosts:
          - host: sonarr.${BASE_DOMAIN}
            paths:
              - path: /
                pathType: Prefix
```
