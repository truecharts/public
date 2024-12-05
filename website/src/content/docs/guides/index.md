---
title: Quick-Start
sidebar:
  order: 1
---

:::note[Clustertool]

Clusters created using Clustertool come pre-packed with most of these charts pre-installed.

:::

## Minimal Getting Started Setup

Install the following charts with **default** values.yaml if not already installed:

- Install `cloudnative-pg` -> [Cloudnative-PG Installation](#prometheus-and-cnpg-system-app-installations)
- Install `prometheus-operator` -> [Prometheus-Operator Installation](#prometheus-and-cnpg-system-app-installations)
- Install `cert-manager` -> [Certificate Management with Cert-Manager](#cert-manager-operator-and-clusterissuer-installation-for-certificate-management)
- Install `volsync` which is used to configure Backups-> [PVC Backup Guide](/guides/volsync-backup-restore)
- `metallb` or another loadBalancer is required if you do not have a loadBalancer yet

To configure MetalLB, you will need to also add `metallb-config` and adapt it to your own needs.

## Getting started using Charts with your own Domain

- Steps Above -> [Minimal Getting Started](#minimal-getting-started-setup)
- Install the `traefik-crds` chart
- Install `traefik` chart
- Use CloudFlare for DNS and create an API token -> [Guide](/charts/premium/clusterissuer/how-to#configure-acme-issuer)
- Install `Clusterissuer` and configure it for your needs -> [Clusterissuer How-to](/charts/premium/clusterissuer/how-to)
- Add `Blocky` and configure it with k8s-gateway enabled -> [Blocky Setup Guide](/charts/premium/blocky/setup-guide)
- Setup ingress on each Chart you want to expose -> [Configure Ingress using Clusterissuer certs](/charts/premium/clusterissuer/how-to/#configure-ingress-using-clusterissuer)

---

## Important Charts

### MetalLB installation

![MetalLB](./img/icons/metallb.png)

This step is mandatory if you don't intend to use another LoadBalancer. We have a full guide explaining the setup on the [MetalLB-Config Setup Guide](/charts/premium/metallb-config/setup-guide) page on how to setup MetalLB. Please refer to that page for more info before continuing.

### Prometheus and CNPG system app installations

![Prometheus](./img/icons/prometheus-operator.png) ![CNPG](./img/icons/cnpg.png)

Many of the popular TrueCharts charts rely on `Prometheus Operator` and `Cloudnative-PG Operator` to be installed **PRIOR** to installing another chart that may rely on functionality these operators provide. If you're unsure if you're using any TrueCharts charts that require Prometheus or CNPG functionality, we advise you install these charts first anyway before attempting to then install any other charts.

[Here](/general/faq#how-do-i-know-if-an-app-uses-cnpg) is a list of charts that rely on CNPG functionality. If you intend to deploy any of these charts, you **must** install the `Cloudnative-PG Operator` chart first as above.

### Traefik installation for Ingress / Reverse-Proxy support with TrueCharts Charts

![Traefik](./img/icons/traefik.png)

`Traefik` is our "ingress" or "reverse-proxy" solution of choice and is integrated into all our charts in order to make it as easy as possible to secure your charts. To support this, we supply a separate Traefik "ingress" app, which has been pre-configured to provide secure and fast connections.

An optional but extra function enabled by Traefik and supported by many Truecharts Charts like `Nextcloud`, is the ability to use a `middleware` to use your charts remotely. You can setup a basicAuth middleware using our guide [Add Traefik Basic Auth to Charts](/charts/premium/traefik/traefik-basicauth-middleware/).

### Cert-Manager (operator) and Clusterissuer installation for certificate management

![Cert-Manager](./img/icons/cert-manager.png)

TrueCharts only supports the usage of `Cert-Manager` (both the operator portion and the main `clusterissuer`) for certificate management inside charts. We highly recommend setting up `clusterissuer` using our [clusterissuer setup-guide](/charts/premium/clusterissuer/how-to) before adding `Ingress` to your applications.

### Blocky DNS provider for split-DNS installation and guide

![Blocky](./img/icons/blocky.png)

Blocky is the optional, but preferred DNS solution for TrueCharts. It's a DNS proxy, DNS enhancer and ad-blocker which supports "split-DNS" through `K8S-Gateway` and is highly-available. The [Blocky Setup-Guide](/charts/premium/blocky/setup-guide) will cover basic setup options which will get you up and running and is not all inclusive.
