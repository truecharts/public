---
title: General Helm Support Policy
---

This manual contains general information on working with TrueCharts Charts using Helm directly.
As well as when editing Helm Yaml for tools like FluxCD, KubeApps and Rancher

:::tip

Please, always remember to check the content specific to the chart.

:::

We at TrueCharts offer limited free support via a support-ticketing system on Discord.
However the scope of this support is limited to two things:

- ClusterTool Commands
- The `values.yaml` of our Helm charts

## Expected Prior Knowledge

- How to use a shell/console/terminal
- Basic shell commands (`cp`, `ls`, `etc` and if you think `etc` is a command here, you'll have a problem)
- Basic `kubectl` use (get pods, get svc, describe something etc)
- Basic knowhow of Talos when you use it (things like: what is "Apply", what is a "machineconfig", what does "upgrade" do vs `k8s-upgrade`)
- Basic Kubernetes knowhow (such as what is a "worker" node vs a "controlplane" node, what's "etcd", what's a "pod" vs a "container", etc.)

## What's Explicitly Not Covered By Support:

- Network configuration
- CloudFlare proxying
- Operating-Systems, outside of Talos deployed using ClusterTool
- Helm 101 (e.g. "how do I install/upgrade/edit a Helm Chart?")
- The software *contained* in our Helm Charts (for example "how do I configure Radarr?")
- Cluster Operations (maintenance, fixing flaky pods, tracking non-deploying fluxcd helm-releases/customisations)
- How to install/use `kubectl`/`talosctl`

### Supported Versions of Helm

| Helm version    | Branch   | Supported with updates | Accepting Support tickets | Accepting Bug Reports | Notes |
| --------------- | -------- | ---------------------- | ------------------------- | --------------------- | ----- |
| 3.11 and prior  | `master` | ✅                     | ❌                        | ❌                    |       |
| 3.12 - 3.14     | `master` | ✅                     | ✅                        | ✅                    |       |

:::caution[China]

Due to local regulations and restrictions, we are unable to provide support or services for any locations or operations within China.
We appreciate your understanding.

:::

## Project Scope

For more info on what to expect from TrueCharts Apps, be sure to also read the [Project Scope documentation](/general/scope).
