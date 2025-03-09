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

- [Cert-Manager](#cert-manager)
- [Cloudnative-PG](#cloudnative-pg)
- [Prometheus](#prometheus)

---

## Recommended Charts

- [Blocky](https://truecharts.org/charts/premium/blocky/): Local DNS Resolving with k8s-gateway
- [Clusterissuer](https://truecharts.org/charts/premium/clusterissuer/): Configuring Cert-Manager
- [Kubernetes-Reflector](https://truecharts.org/charts/system/kubernetes-reflector/): Reflect Resources across Namespaces
- [Metallb](https://metallb.io/) with [Metallb-Config](https://truecharts.org/charts/premium/metallb-config/) as LoadBalancer
- [Snapshot-Controller](https://truecharts.org/charts/system/snapshot-controller/): Required for Volsync
- [Volsync](https://truecharts.org/charts/system/volsync/): For Backup and Restore of PVCs
- [Traefik-CRDS](https://truecharts.org/charts/system/traefik-crds/) & [Traefik](https://traefik.io/traefik/): For Ingress and Reverse Proxying

## Upstream Operators

Truecharts relies on multiple Charts for functionality like Postgres Databases and Metrics.
Therefore we require certain Charts to be installed. Below you will find example configurations for most of them:

### Cert-Manager

Cert-Manager is used  together with our clusterissuer to create SSL certificates for ingress.
The chart installation can be found [here](https://cert-manager.io/docs/installation/helm/).

Example configuration:

```yaml

crds:
  enabled: true
dns01RecursiveNameservers: "1.1.1.1:53,1.0.0.1:53"
dns01RecursiveNameserversOnly: false
enableCertificateOwnerRef: true

```

### Cloudnative-PG

Cloudnative-PG is used for Postgres databases in many of our charts.
The chart can be found [here](https://cloudnative-pg.io/charts/).

Example configuration:

```yaml

crds:
  create: true

```

### Prometheus

Kube-promotheus-stack is used for metrics.
The chart can be found [here](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack).

As we provide our own grafana with included dashboard. We recommend to disable grafana in the kube-prometheus-stack:

```yaml
grafana:
  enabled: false
  forceDeployDashboards: true
  defaultDashboardsEnabled: true
```

We generally advice to run the full kube-prometheus-stack but as it is quite resource intensive you can run the minimum requirement which only requires to add the CRDs and Operator. This can be done like this:

```yaml
crds:
  enabled: true
prometheusOperator:
  enabled: false
## Everything down here, explicitly disables everything BUT the operator itself
global:
  rbac:
    create: true
defaultRules:
  create: false
windowsMonitoring:
  enabled: false
prometheus-windows-exporter:
  prometheus:
    monitor:
      enabled: false
alertmanager:
  enabled: false
grafana:
  enabled: false
  forceDeployDashboards: false
  defaultDashboardsEnabled: false
kubernetesServiceMonitors:
  enabled: true
kubeApiServer:
  enabled: false
kubelet:
  enabled: false
kubeControllerManager:
  enabled: false
coreDns:
  enabled: false
kubeDns:
  enabled: false
kubeEtcd:
  enabled: false
kubeScheduler:
  enabled: false
kubeProxy:
  enabled: false
kubeStateMetrics:
  enabled: false
nodeExporter:
  enabled: false
prometheus:
  enabled: false
thanosRuler:
  enabled: false
```
