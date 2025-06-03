---
slug: "news/clustertool-v2"
title: "Clustertool v2"
authors: [alfi0812, privatepuffin]
date: 2025-04-10
tags:
  - "2025"
---

Just one year ago we were fully dedicated to building TrueNAS SCALE Apps and were forced to move forward to greener pastures. Now, only a year later, we've moved to being fully compatible with nearly every Kubernetes platform out there while still offering a staggering amount of Helm Charts.

After long consideration, we've decided to stop providing forks/mirrors of complicated charts such as Traefik, Prometheus and so forth. With SCALE gone, we simply don't need to anymore and users are free to directly consume the upstream charts instead!

This has also allowed us to completely re-evaluate which software we're using to back the ClusterTool defaults. Hence, ClusterTool V2 is born!

## New Clustertool v2 Launches with NGINX Backend and Major Upgrades

The highly anticipated Clustertool v2 is officially released, bringing a host of improvements and a fundamental architectural shift including:
- a full move to an NGINX backend
- Designed for improved performance, cleaner configuration, and upstream alignment.

Clustertool v2 is a significant step forward for Kubernetes-based cluster management.

## What’s New in Clustertool v2?

The latest version comes with a comprehensive set of changes aimed at making the system more maintainable and future-ready. Key updates include:

- ✅ Migration to NGINX as the default ingress controller
- 📦 Inclusion of kube-prometheus-stack for metrics
- 📦 Upstream integration of many system charts
- 🧹 Indentation and formatting cleanups across configuration files
- 📥 Adoption of OCI Mirrors for chart management, boosting speed and reliability

## Changes for Existing Clusters

Clusters upgrading to v2 will need to account for several changes:

- 📦 Repository Adjustments:
  - Updated Repositories list:

    ```yaml
    //kustomization.yaml
    apiVersion: kustomize.config.k8s.io/v1beta1
    kind: Kustomization
    metadata:
      name: helm-repos
      namespace: flux-system
    resources:
      - bjw-s.yaml
      - cloudnative-pg.yaml
      - home-ops-mirror.yaml
      - jetstack.yaml
      - kustomization.yaml
      - prometheus-community.yaml
      - spegel.yaml
      - truecharts.yaml
    ```

  - Added home-operations [OCI mirror](https://github.com/home-operations/charts-mirror):

    ```yaml
    //home-ops-mirror.yaml
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

  - Please compare your [Repositories](https://github.com/truecharts/public/tree/master/clustertool/embed/generic/root/repositories/helm) with this template.
  - Charts such as Cilium, Metrics Server, Node-Feature-Discovery, Longhorn, Metallb, and OpenEBS are now
    pulled via an OCI mirror
- 🔥 Traefik Removal:
  - Both Traefik and traefik-crds are no longer included and need to be removed
  - [Ingress configurations](/guides/ingress/nginx/) now require annotation updates to work with NGINX
  - [ingressClassName](/guides/ingress/) is recommended to be set for all ingresses. Additionally, you will need to disable the traefik integration.
- 🔄 IngressClass Management:
  - New support for using either internal or external ingress classes
  - Clusterenv now includes:
    - `NGINX_INTERNAL_IP` has been added
    - `NGINX_EXTERNAL_IP` has been added
    - `TRAEFIK_IP` has been removed
- 🧪 Upstream Chart Migrations:
  - Charts such as CloudNativePG, Cert-Manager, and Kube-Prometheus-Stack are now managed upstream
  - 🧭 Check the [Quick Start Guide](/guides/) for integration examples

## Clustertool as a CI Platform for Chart Testing

With v2, Clustertool is now also being adopted internally as a replacement for the legacy ChartTool,
which was previously used to test and release charts but its code was never released publicly.

## Special Thanks

Thanks to the home-operations team for providing and maintaining their [OCI mirror](https://github.com/home-operations/charts-mirror). 🎉

This ensures every one of us can fully use the power of OCI-backed Helm-charts in our clusters!

## Important Notice for SCALE Users

Starting with v2, Clustertool will no longer include any tooling or support for SCALE exports, conversions,
or migrations. Users relying on those features should retain v1 or migrate to separate tools.

## Ready to update?

Clustertool v2 continues the projects goal of modular, maintainable cluster management and leans into modern best-practices for Kubernetes ecosystem integration.
This release sets the foundation for a more streamlined and scalable future.

Ready to upgrade? Check out the full changelog and migration resources to get started.
