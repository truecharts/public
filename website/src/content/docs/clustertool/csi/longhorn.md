---
title: Longhorn
---


:::caution[Work In Progress]

This program, all its features and its general design, are all a Work-In-Progress. It is not done and not widely available.

All code and docs are considered Pre-Beta drafts

:::

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
This runs a filesystem trim on midnight cet. To free the "used" space.

## Other references

<https://longhorn.io/docs/1.7.1/deploy/install/install-with-helm/>
<https://volsync.readthedocs.io/en/latest/installation/index.html>
