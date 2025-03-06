---
title: Quick-Start
sidebar:
  order: 1
---

:::note[Clustertool]

Clusters created using Clustertool come pre-packed with most of these charts pre-installed.

:::

## Prerequisites

- Running Kubernetes Cluster
- Container Storage Interface (CSI)
- LoadBalancer like Metallb

## Required Charts for most Truecharts Charts

Install the following charts if not already installed:

- [Cert-Manager](https://cert-manager.io/)
- [Cloudnative-PG](https://cloudnative-pg.io/)
- [Prometheus-Operator](https://truecharts.org/charts/system/prometheus-operator/)

---

## Recommended Charts

- [Blocky](https://truecharts.org/charts/premium/blocky/): Local DNS Resolving with k8s-gateway
- [Clusterissuer](https://truecharts.org/charts/premium/clusterissuer/): Configuring Cert-Manager
- [Kubernetes-Reflector](https://truecharts.org/charts/system/kubernetes-reflector/): Reflect Resources across Namespaces
- [Metallb](https://metallb.io/) with [Metallb-Config](https://truecharts.org/charts/premium/metallb-config/) as LoadBalancer
- [Snapshot-Controller](https://truecharts.org/charts/system/snapshot-controller/): Required for Volsync
- [Volsync](https://truecharts.org/charts/system/volsync/): For Backup and Restore of PVCs
- [Traefik-CRDS](https://truecharts.org/charts/system/traefik-crds/) & [Traefik](https://traefik.io/traefik/): For Ingress and Reverse Proxying
