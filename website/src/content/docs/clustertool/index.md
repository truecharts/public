---
sidebar:
  order: 1
title: Introduction to ClusterTool
---

ClusterTool is TrueCharts' own easy deployment and maintenance tool for TalosOS clusters.

It has support for both single-node and multi-node clusters, both as Virtual Machines and on Bare-Metal.
It can also be used to bootstrap and maintain a FluxCD environment, shared with TalOS Through a single settings interface.

As security is important, it features integrated encryption and decryption. Based on SOPS and is fully FluxCD compatible out-of-the-box.

## Requirements

We do expect users to understand what Talos OS is and isn't.
As well as understand the basics of what "Apply", "Bootstrap" and/or "Upgrade" means for Talos OS.

## What ClusterTool is not

Besides bootstrapping included helm charts, clustertool will NOT help you update, maintain or alter helm-charts in *any* way.
How users run their cluster post-bootstrap, is on to the user to decide.

This means that users are expected to have basic shell/console/terminal skills and understand the basics on how to edit, update, upgrade and install Helm charts.
Our support is explicitly limited to ClusterTool *itself* and the values.yaml of our Helm charts.

## Noteworthy settings

### Log-Level

Loglevel can be set by settings the `LOGLEVEL` environment variable.
It has the following options:
- "trace"
- "debug"
- "warn"
- "error"
- "fatal"
- "panic"
- "info" (Default)

### Multi-Clustering

We offer a experimental Multi-clustering option, which creates multiple seperate clusters under `clusters`.
It can be set using the flag: `--cluster`

*Please note that this feature is **experimental**, not covered by our support and might be unstable*
