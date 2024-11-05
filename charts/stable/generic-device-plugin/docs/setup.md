---
title: Setup
---

This chart requires a privileged namespace.

After adding this chart you can add your tun device to charts like this:

```yaml
resources:
  limits:
    kernel.org/tun: 1
```

For addons like our gluetun addon you can add it like this if you are using fluxcd:

```yaml
apiVersion: helm.toolkit.fluxcd.io/v2
kind: HelmRelease
metadata:
    name: chart
    namespace: namespace
spec:
    postRenderers:
    - kustomize:
        patches:
          - target:
              version: v1
              kind: Deployment
              name: qbittorrent
            patch: |
              - op: add
                path: /spec/template/spec/containers/1/resources/limits/truecharts.org~1tun
                value: 1
    interval: 5m
    chart:
```
