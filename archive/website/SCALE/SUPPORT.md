---
title: Support Policy
sidebar:
  order: 2
---

## TrueCharts on TrueNAS SCALE

:::danger

TrueNAS SCALE Apps are considered Deprecated. We heavily recommend using a more mature Kubernetes platform such as "TalosOS" instead, and no longer offer an apps/charts catalogue for SCALE users to install. The below docs exist purely as historical references and may be removed at any time.

:::

### Supported Versions of TrueNAS SCALE

| TrueNAS Version    | Branch         | Getting Updates | Accepting Support Tickets | Accepting Bug Reports | Notes                                                                                          |
| ------------------ | -------------- | --------------- | ------------------------- | --------------------- | ---------------------------------------------------------------------------------------------- |
| 22.12.4.2 or prior | `master`       | ❌              | ❌                        | ❌                    | SCALE is deprecated |
| 23.10.2            | `legacy_23.10` | ❌              | ❌                        | ❌                    | SCALE is deprecated |
| 24.04.X            | `master`       | ❌              | ❌                        | ❌                    | SCALE is deprecated |
| Alpha/BETA/RC      | `master`       | ❌              | ❌                        | ❌                    | SCALE is deprecated |
| Nightly            | `master`       | ❌              | ❌                        | ❌                    | SCALE is deprecated |

:::tip

Set aside time for a maintenance window or simple check-in for your SCALE system every week, month or quarter as this can go a long way to helping prevent lengthy amounts of time needing to be spent bringing a SCALE system up to date. SCALE _usually_ has two major version releases each year, so at a minimum ensuring you're prepared for those will help.

:::

## Project Scope

For more info on what to expect from TrueCharts Apps, be sure to also read the [Project Scope documentation](/general/scope).

:::caution[Support Guidelines]

Our [Discord](/s/discord) support (the ticketing system inside #support) is primarily limited to what is covered by our written guides. This includes installing, linking and editing apps. This doesn't mean the actual setup of the application. All #support tickets covered by the staff are done so on a **best effort** basis.

:::

## Unsupported Features

iX-Systems has built a rather crude middleware in-between Apps and the Kubernetes cluster itself. Many of its features have severe design flaws, and they do not have the expertise in-house nor the intention to fix the codebase.

For this reason we do not support a number of features on TrueNAS SCALE Apps and/or have alternative features implemented ourselves. This includes

### Stop Button

**DO NOT** use the iX-provided `Stop` button in the SCALE GUI. Its implementation is severely flawed and only works with Kubernetes objects designed by iX-Systems themselves, leaving your Apps open to being left in a limbo state.
Instead of the Stop button, use either

- The TrueCharts "Stop-All" feature available in the apps configuration/edit section or

- [HeavyScript](https://github.com/Heavybullets8/heavy_script) with the `-x appname` or `--stop appname` arguments.

### Storage Rollback

While rollback of Kubernetes objects works fine, this is a native feature on normal Helm deployments as well.
The "include storage" option for rollback on SCALE either does not work at all or breaks some things (like databases).

### Migration to another Pool

While the idea of cross-pool migration is nice, it inherently does not work because it's not Kubernetes aware and only works correctly with a limited subset of Kubernetes objects created by iX-Systems.

Migration certainly does not work with CNPG, our PostgreSQL backend at all.
Manual steps might be needed to restore systems containing databases.

### SCALE Certificates

There are a lot of issues with SCALE certificates and they are crudely injected into the Kubernetes cluster in ways that are not "normal" when working with Kubernetes.
We instead rely on `Cert-Manager`, an industry-standard Kubernetes-aware certificate management solution for Kubernetes.

### iX-Volumes

iX-Volumes are a crudely designed "PVC-like" storage solution by iX-Systems, offloading behavior that should normally be handled by PVC storage controllers onto the host system.
This is not a good way to deal with storage on Kubernetes and might unexpectedly lead to issues.

We use PVC storage, like normal with Kubernetes, instead.

### Backup and Restore

iX-Systems has not officially released backup and restore, and SCALE Apps do not work with normal Kubernetes backup and restore tools like Velero, due to their archaic Kubernetes folder-structure-design.
[HeavyScript](https://github.com/Heavybullets8/heavy_script) offers an alternative, but we cannot guarantee it works out-of-the-box, at all or with our Apps. But it's the best there is at the moment.

Backup and Restore certainly does not work with CNPG, our PostgreSQL backend at all. Manual steps might be needed to restore systems containing databases.

### TrueNAS GPU Selectors

The GPU selectors have weirdly worded options, confusing many users and heavily rely on the host system to say which GPUs are available or not. This might cause issues with updates, installs, edits etc.
Kubernetes usually handles GPUs itself, the amount entered is just a request of how many GPUs the applications/container wants assigned and Kubernetes can handle the rest.

Instead we offer our own option, where you can enter the number of specific GPUs you want assigned under "Resources" in the "Limits" section
