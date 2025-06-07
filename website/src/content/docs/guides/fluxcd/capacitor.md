---
sidebar:
  order: 2
title: FluxCD Capacitor
---

:::caution[Disclaimer]

This guide isnt covered by the Support Policy and is considered more advanced.
If you face issues feel free to open a thread in the appropiate Channel in our Discord server.

:::

:::note[Note]

[Capacitor](https://fluxcd.io/blog/2024/02/introducing-capacitor/) was created by FluxCD the repo and Kustomization file were pulled from that link. Please reference that document to gain more contenxt and understanding of how it works.

:::

## Prerequisites

- Having a running Kubernetes cluster
- Bootstrapped fluxcd
- Knowledge on how to add charts/kubernetes resources with fluxcd
- Usage of an ingress to make the webhook accessible from outside your network

## Initial Setup

- Create a new folder called `capacitor` inside the `flux-system` folder.
- Update the `kustomization.yaml` file in `flux-system` with `- capacitor`
- Next we will need 3 files inside the capacitor folder:


```yaml
//capacitor.yaml

apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: capacitor
  namespace: flux-system
spec:
  targetNamespace: flux-system
  interval: 1h
  retryInterval: 2m
  timeout: 5m
  wait: true
  prune: true
  path: "./"
  sourceRef:
    kind: OCIRepository
    name: capacitor
```

```yaml
//ingress.yaml

apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: capacitor
  namespace: flux-system
  annotations:
    cert-manager.io/cluster-issuer: domain-0-le-prod # use what you have configured for your ingress
    cert-manager.io/private-key-rotation-policy: Always
spec:
  ingressClassName: internal
  rules:
  - host: capacitor.${DOMAIN_0} # use what you have configured for your ingress
    http:
      paths:
      - pathType: Prefix
        path: /
        backend:
          service:
            name: capacitor
            port:
              number: 9000
  tls:
    - hosts:
      - capacitor.${DOMAIN_0} # use what you have configured for your ingress
      secretName: capacitor-tls-0 # use what you have configured for your ingress
```

``` yaml
//kustomization.yaml

apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - capacitor.yaml
  - ingress.yaml
```

## Add The Repository

Go to your `Reponsitories/oci` directory and create this file.

``` yaml
//capacitor-manifests.yaml

apiVersion: source.toolkit.fluxcd.io/v1
kind: OCIRepository
metadata:
  name: capacitor
  namespace: flux-system
spec:
  interval: 12h
  url: oci://ghcr.io/gimlet-io/capacitor-manifests
  ref:
    semver: ">=0.1.0"
```

Update the kustomization.yaml in oci to include `- capacitor-manifests.yaml`

## Finishing Steps

Reoncile your cluster.

  ``` shell
  flux reconcile source git cluster
  ```
