---
title: Container Storage Interfaces
---

Container Storage Interfaces, better known as "CSI", are used to connect storage to kubernetes PVCs.
The base ClusterTool setup, includes a single-node setup of Longhorn, which can be easily tweaked from single-node to multi-node setup.

Guides under this section give some user-made examples of CSI storage options available.
However, as those are user-made, they are not covered by TrueCharts Discord Support.

## Default CSI

For users that want to keep things simple, with data on the OS disk and decent snapshotting.
This would not require extra drives and can easily be configured for single-node (1 replica, the default) as wel as clustered storage (3 replicas).
In addition longhorn would, by default, not conflict with any of the other CSIs listed above, meaning users can easily start experimenting with other CSIs as well, while still relying on Longhorn.

Hence for most users starting-out we would advice starting-out using Longhorn and have included it as the default storage backend (CSI) when deploying clustertool.

## Overview

|                  | Location  | Disk Consumption | Snapshot Compat. | RWO/RWX | Notes                                                                                                                         |
|------------------|-----------|------------------|------------------|:-------:|-------------------------------------------------------------------------------------------------------------------------------|
| OpenEBS hostPath | Local     | Partial          | No               | RWX     |                                                                                                                               |
| OpenEBS Device   | Local     | Full             | Troublesome      | RWO     | Partial snapshotting support                                                                                                  |
| OpenEBS ZFS      | Local     | See Notes        | Troublesome      | RWX     | Snapshots notoriously flaky, Full disk required for zpool, partial zpool can be used for OpenEBS |
| TopoLVM          | Local     | Full             | Yes              | RWO     |                                                                                                    |
| Longhorn         | local/Clustered | Partial    | Yes              | RWX     | RWX untested on TalosOS, Enterprise SSDs mandatory                                |
| CEPH -block      | Clustered | Full             | Yes              | RWO     | Shares disks with CEPH-FS                                                                       |
| CEPH -FS         | Clustered | Full             | Yes              | RWX     | Shares disks with CEPH-Block                                                                                                 |
| Democratic NFS   | Networked | Partial          | Yes              | RWX     | Requires TrueNAS Cron script due to instability                                                                               |
| Democratic iSCSI | Networked | Partial          | Yes              | RWO     | Requires TrueNAS Cron script due to instability                                                  |

## General notes

Some general notes might be cool as well, wirthen out a little longer obviously:

- ClusterTool already includes snapshot controller by default
- Some CSIs try to claim unused disks or even wipe used disks. Be carefull when mixing multiple "full disk" CSIs!
- For multi-pod charts sharing storage, a RWX CSI is required!
- "Networked" CSIs means that ALL pods using that storage stop working when the networked storage goes down

## Our Top Picks

- Local non-volsync storage: OpenEBS hostPath
- Local general storage: Longhorn
- Clustered RWO storage: CEPH-Block
- Clustered RWX storage: CEPH-FS
- Networked Storage: Democratic NFS
