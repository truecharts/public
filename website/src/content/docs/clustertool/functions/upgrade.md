---
sidebar:
  order: 8
title: Upgrade
---

:::caution[Work In Progress]

This program, all its features and its general design, are all a Work-In-Progress. It is not done and not widely available.

All code and docs are considered Pre-Beta drafts

:::

The `upgrade` command updates Talos to the latest version specified in talconfig.yaml for all nodes.
It also applies any changed `extentions` and/or `overlays` specified there.

On top of this, after upgrading Talos on all nodes, it also executes kubernetes-upgrades for the whole cluster as well.