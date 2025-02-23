---
title: Longhorn
---

Longhorn is a distributed block storage system for Kubernetes. Longhorn is cloud-native storage built using Kubernetes and container primitives.

Their Helm-Chart is available at: <https://github.com/longhorn/charts>

## Installation

Longhorn is included with ClusterTool. It rolls out a, default, storageClass named longhorn, that saves its data on the systemdisk.

## Issues with Longhorn and Volsync

Volsync creates backup each day and uses snapshots to do so. This leads to a lot of snapshot creations which will be deleted after the backup is done.

Longhorn wont free/trim the space gained by the deletion of the snapshots and will keep it as used. This can lead to a no-disk-space error after some time depending on the amount of volsync backups and their size.
This can be prevented by adding the following `ReccuringTask` to Longhorn:

```yaml
apiVersion: longhorn.io/v1beta2
kind: RecurringJob
metadata:
  name: trim
  namespace: longhorn-system
spec:
  concurrency: 1
  cron: 0 0 * * *
  groups:
  - default
  name: trim
  retain: 0
  task: filesystem-trim
```

This runs a filesystem trim at midnight UTC. To free the "used" space.

In addition to trim, it is possible to delete and cleanup all snapshots by adding tasks for snapshot-delete and snapshot-cleanup.

:::caution

This tasks should only be used with caution, as they will delete manually created snapshots too.

:::

```yaml
apiVersion: longhorn.io/v1beta2
kind: RecurringJob
metadata:
  name: delete
  namespace: longhorn-system
spec:
  concurrency: 1
  cron: 00 22 * * *
  groups:
  - default
  name: delete
  retain: 0
  task: snapshot-delete
```

This runs a snapshot delete task at 22:00 UTC.

```yaml
apiVersion: longhorn.io/v1beta2
kind: RecurringJob
metadata:
  name: cleanup
  namespace: longhorn-system
spec:
  concurrency: 1
  cron: 30 22 * * *
  groups:
  - default
  name: cleanup
  retain: 0
  task: snapshot-cleanup
```

This runs a snapshot cleanup task at 22:30 UTC.

## Other references

<https://longhorn.io/docs/1.8.0/deploy/install/install-with-helm> \
<https://volsync.readthedocs.io/en/latest/installation/index.html> \
<https://longhorn.io/docs/1.8.0/snapshots-and-backups/scheduling-backups-and-snapshots/#using-the-manifest>
