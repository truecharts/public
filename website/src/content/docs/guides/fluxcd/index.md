---
sidebar:
  order: 1
title: FluxCD Basics
---

fluxcd is a so-called gitops tool.
It allows users to define their cluster in a git repository and automatically syncs said configuration with the actual cluster

:::tip

Please, always remember to check the content specific to the chart.

:::

## How to Configure

Configuration should be done "The Helm Way" via editing HelmRelease objects in the git repository.
Values of which can be used like normal on helm.

This can be done following the [Helm Guides](/general/)

and checking all the many options available in our [Common Library Chart](/common/)

### Example Helm-Release object

```yaml
---
# yaml-language-server: $schema=https://kubernetes-schemas.pages.dev/helm.toolkit.fluxcd.io/helmrelease_v2.json
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
