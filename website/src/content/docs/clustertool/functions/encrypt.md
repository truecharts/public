---
sidebar:
  order: 4
title: encrypt
---

:::caution[Work In Progress]

This program, all its features and its general design, are all a Work-In-Progress. It is not done and not widely available.

All code and docs are considered Pre-Beta drafts

:::

The encryption feature of ClusterTool goes over all config files and, if not encrypted already, checks if `.sops.yaml` mandates that they should be encrypted.
Afterwards, they are encrypted using your `age.agekey` file as specified in `.sops.yaml`.