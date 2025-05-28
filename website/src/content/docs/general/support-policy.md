---
title: Support Policy
sidebar:
  order: 2
---

:::tip

Please, always remember to check the content specific to the chart.

:::

TrueCharts is a comprehensive project that focuses on providing opinionated Helm charts for applications to run on Kubernetes-based platforms.

We also offer free support via a support-ticketing system on Discord, according to the policy laid out in this document.

## System Requirements

Make sure your system fullfills atleast the [Minimum System Specifications
](/general/systemrequirements) to be alligable for ticket support.

## Support Rules

- If its covered by support as outlined below make a ticket in [⁠🎫・support](https://discord.com/channels/830763548678291466/936275413179723826).
- [⁠🎫・support](https://discord.com/channels/830763548678291466/936275413179723826) is not rendered on GitHub or any other platform.
- Bugs must be reported on GitHub, but only after confirmation by the staff via a [⁠🎫・support ticket](https://discord.com/channels/830763548678291466/936275413179723826)
- Anything not covered by the below Support Policy is not eligible for a [⁠🎫・support ticket](https://discord.com/channels/830763548678291466/936275413179723826). If you need assistance outside the scope of [⁠🎫・support](https://discord.com/channels/830763548678291466/936275413179723826) make a thread in an appropriate [Discord Channel](https://discord.gg/tVsPTHWTtr).
- We help out where we can, as long as you tried to do it yourself *first*. We do not provide a walkthrough service.
- Our staff will try to help out with providing instructions on how to use `kubectl` and other `*ctl` tools where needed.
- Please be aware that the code of conduct also applies to all support.

## Expected Prior Knowledge

- How to use a shell/console/terminal and basic commands (ie. `cp`, `ls`, `etc`).
- Having read our Guides, Docs, News and Announcements.
- Basic Kubernetes know how (such as what is a "worker" node vs a "controlplane" node, what's "etcd", what's a "pod" vs a "container", etc).

## ClusterTool Support Policy

- We offer support for all ClusterTool functions, except those under `adv` and `charts`
- If you deviate from default configurations significantly, we cannot guarantee a bootstrap will work and support will be limited on a case-by-case basis.
- We do provide support for issues regarding talconfig.yaml, as long as ClusterTool is used for the deployment.
- We do provide *basic* assistance with [Talos OS](/guides/talos/), when deployed or maintained through ClusterTool (upgrades, config changes etc)
- We do provide support for FluxCD setup and layout, as long as ClusterTool is used for the deployment.
- We *only* provide support for the latest version of ClusterTool. Please ensure you are utilizing the latest version before requesting support.

## Kubernetes Support Policy

- We do not offer support for any component of kubernets that is not made by TrueCharts.
- This includes charts by other parties or manually created kubernetes manifests and deployments.
- We do not offer support for any version of kubernetes not listed below.

## Helm Chart Support Policy

- We offer support for all features available in our helm-charts, including all options in the common-chart.
- We offer [basic documentation](/guides/) and support for installing, upgrading and editing our Helm-Charts using Helm.
- We do not support external secret management outside of values.yaml
- We offer support for all our charts trains, except `incubator`, `dev`, and `test`.
- We cannot guarantee special characters will work flawlessly in any field.
- We do not offer support for any version of helm not listed below.

:::note

Some [(common-chart)](../common/) features might not work correctly with all charts.

:::

## FluxCD Support Policy

- We offer support for our Helm-Charts values in FluxCD as outlined in Helm Chart Support.
- We offer [basic documentation](/guides/fluxcd/) and support on how to create a `helm-release` file, to deploy our helm-charts on Flux.
- To be eligible for FluxCD support your repository must be public.
- All information being provided *must* be un-encrypted. You can obfuscate any sensitive information as needed.

## What's Explicitly Not Covered By Support

- Troubleshooting complete clusters, outside of just our Helm-Charts.
- CloudFlare proxying.
- The software *contained* in our Helm Charts (for example "how to configure Radarr to connect to a torrent client?").
- How to install additional tools (like: [kubectl](https://kubernetes.io/docs/tasks/tools/), [talosctl](https://www.talos.dev/latest/talos-guides/install/talosctl/), [flux](https://fluxcd.io/flux/cmd/) etc)
- We do not support any Cloud providers or OpenShift.

:::note

If an issue is covered support create a [⁠🎫・support ticket](https://discord.com/channels/830763548678291466/936275413179723826) for assistance.

For all issues not covered by support you can make a thread in an appropriate [Discord Channel](https://discord.gg/tVsPTHWTtr) for assistance from the community.

:::

## Supported Helm Versions

| Helm version    | Branch   | Supported with updates | Accepting Support tickets | Accepting Bug Reports | Notes |
| --------------- | -------- | ---------------------- | ------------------------- | --------------------- | ----- |
| 3.13 and prior  | `master` | ❌                     | ❌                        | ❌                    |       |
| 3.14 - 3.17     | `master` | ✅                     | ✅                        | ✅                    |       |
| 3.18.0           | `master` | ❌                     | ❌                        | ❌                    | Bug indentifed on 3.18.0, we cannot support this version. https://github.com/helm/helm/pull/30902 |

## Supported Kubernetes Versions

| Kube version    | Branch   | Supported with updates | Accepting Support tickets | Accepting Bug Reports | Notes |
| --------------- | -------- | ---------------------- | ------------------------- | --------------------- | ----- |
| 1.23 and prior  | `master` | ❌                     | ❌                        | ❌                    |       |
| 1.24 - 1.32     | `master` | ✅                     | ✅                        | ✅                    |       |
| 1.33.0          | `master` | ✅                     | ✅                        | ✅                    | Known issue with error "failed to set MOUNT_ATTR_IDMAP". Can be corrected by setting hostUsers to True. https://truecharts.org/common/podoptions/#hostusers |

:::caution[China]

Due to local regulations and restrictions, we are unable to provide support or services for any locations or operations within China.
We appreciate your understanding.

:::
