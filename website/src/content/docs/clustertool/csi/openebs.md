---
title: OpenEBS
---


:::caution[Work In Progress]

This program, all its features and its general design, are all a Work-In-Progress. It is not done and not widely available.

All code and docs are considered Pre-Beta drafts

:::

OpenEBS is a multi-storage CSI solution.
However, its important to note that its snapshot capabilities either are relatively unstable or non-existent.

## OpenEBS HostPath

OpenEBS HostPath is included with ClusterTool.
It rolls out a, non-default, storageClass named `openebs-hostpath`, that saves its data on the systemdisk.

OpenEBS hostPath does not support snapshots in any way, shape or form. So is not a good pick for volsync support, but might work well with CNPG.
