---
sidebar:
  order: 5
title: decrypt
---

:::caution[Work In Progress]

This program, all its features and its general design, are all a Work-In-Progress. It is not done and not widely available.

All code and docs are considered Pre-Beta drafts

:::

The decryption feature of ClusterTool goes over all config files and, if encrypted, checks if `.sops.yaml` specifies that they should be decrypted.
If so, they are decrypted using your `age.agekey` file as specified in `.sops.yaml`.
