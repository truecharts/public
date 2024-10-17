---
slug: "news/persistence-changes"
title: "Changes to Storage, Persistence, and PostgreSQL"
authors: [ornias]
date: 2023-12-20
tags:
  - "2023"
---

We're glad to announce that shortly we will release a big update to all our Apps. This will be a complex update that technically includes a few changes that might break some specific features for some users. While we do not foresee any data loss, it's imperative to back up your data.

## Standardization of PVC Storage

A number of new storage options are being released. These are all optional and should be considered somewhat experimental.

## Redesign of Cloudnative-PG

Our Cloudnative-PG backend has been completely rewritten. This should provide more stability, but also carries the risk of introducing new bugs.

## Required Migration Steps

If you want to update, here are the instructions:

#### All Platforms

- We strongly advise upgrading all charts and not just a select few as the new version of ClusterIssuer might not be fully compatible with charts on old versions.
- Ingress: In some cases it might be prudent to disable ingress prior to update and enable it again afterwards.
- Statefulsets: Be sure to remove any statefulsets made by TrueCharts Helm Charts before or after update. See instructions below.

#### Helm

- Ingress: Most of the certManager settings have been moved to "integrations".
- Ingress: All of the Traefik settings have been moved to "integrations".
- Ingress: It's advisable to apply the new structure from common values.yaml prior to upgrade: https://github.com/truecharts/library-charts/blob/main/library/common/values.yaml
- CNPG: All settings have been restructured. Prior to update, users should view the new structure in common values.yaml and adapt accordingly: https://github.com/truecharts/library-charts/blob/main/library/common/values.yaml

#### SCALE

- Ingress: Most of the cert-manager settings have been moved to "integrations" and they are reset.
- Ingress: All of the Traefik settings have been moved to "integrations" and they are reset.
- Ingress: This means you likely will lose TLS and security middlewares after the update, until adapted.
- CNPG: If present in the old GUI, Instance number and storage size have been moved and reset to defaults.
- Traefik: After updating, you will need to check a checkbox at the bottom, with a warning confirmation, before you will be able to do any further updates or edits.

### Stateful Set Instructions

The charts with statefulsets have a manual step. but it wont require reinstall. make sure to refresh your catalog.
We do not have many statefulsets in our catalog, so expect it to be mostly OpenLDAP and/or Redis related.

#### SCALE

To check which have statefulsets:

```bash
k3s kubectl get statefulsets -A | grep "ix-"
```

Then to delete the statefulset:

```bash
k3s kubectl delete statefulset STATEFULSETNAME -n ix-APPNAME
```

Example:

```bash
k3s kubectl delete statefulset blocky-redis -n ix-blocky
```

Once deleted you can attempt the update (or if you were already updated to latest versions, then edit and save without any changes)

#### Helm

To check which have statefulsets:

```bash
kubectl get statefulsets -A
```

Then to delete the statefulset:

```bash
kubectl delete statefulset STATEFULSETNAME -n APPNAME
```

Example:

```bash
kubectl delete statefulset blocky-redis -n blocky
```

Once deleted you can attempt the update (or if you were already updated to latest versions, then edit and save without any changes)
