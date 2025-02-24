---
title: OpenEBS
---

OpenEBS is a multi-storage CSI solution.
However, its important to note that its snapshot capabilities either are relatively unstable or non-existent.

## OpenEBS HostPath

OpenEBS HostPath is included with ClusterTool.
It rolls out a, non-default, storageClass named `openebs-hostpath`, that saves its data on the systemdisk.

OpenEBS hostPath does not support snapshots in any way, shape or form. So is not a good pick for volsync support, but might work well with CNPG.
