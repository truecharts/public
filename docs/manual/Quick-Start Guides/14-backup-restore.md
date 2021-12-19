# 14 - Backup and Restore

This section is a WIP, please do NOT consider this to be either finished or working.

## Backup

##### Creating Frequent Backups

SCALE includes an integrated system to backup the kubernetes objects as well as make snapshots of the `PVC` and `ix_volume` storage.
However, it does NOT create these outside of SCALE upgrades.

To create daily backups of the kubernetes objects, create the following Cron Job:

<a href="https://truecharts.org/_static/img/backup/cron.png"><img src="https://truecharts.org/_static/img/backup/cron.png" width="100%"/></a>

##### Exporting Backups

The above only creates only a backup of the kubernetes objects and a snapshot of the `PVC` and `ix_volume` storage.
It does not protect these against, for example, deletion of datasets or save them on an external system.

We **highly** advice making both an internal backup (seperate dataset on the same system) *and* an offsite backup.
One could create a normal recursive(!) replication of the `ix-volumes` dataset using the SCALE GUI, with the following few special tricks by editing the replication after creation:

1. Exclude the docker images:

<a href="https://truecharts.org/_static/img/backup/dockerignore.png"><img src="https://truecharts.org/_static/img/backup/dockerignore.png" width="100%"/></a>

2. Include any snapshots made by the above backup task

<a href="https://truecharts.org/_static/img/backup/includebackups.png"><img src="https://truecharts.org/_static/img/backup/includebackups.png" width="100%"/></a>

It's also important to ensure you keep regular config backups of the SCALE system itself, preferably right after the Apps backup above).
However this is not part of this guide and we will assume you've done so yourself.


##### Checking Backups

To make which backups are present, one can use the following command in a shell:

`cli -c "app kubernetes list_backups"`

## Restore

One of the most important parts of backups is to ensure they can be restored.
There are two scenario's for a restore:

1. Reverting a working system

2. Total System Restore

##### Reverting a running system

Reverting a running system is rather trivial. But there are a few caveats:

- This will reinitialise the kubernetes node, which means all kubernetes objects that are not deployed using the Apps system will get reverted
- You CANNOT revert a single Apps

To revert an existing system, the process is as follows:

1. List your current backups using `cli -c "app kubernetes list_backups"`

2. Pick a backup to revert and note it's name

3. Run: `cli -c "app kubernetes list_backups { 'backup_name': 'BACKUPNAME'}` (where you replease BACKUPNAME with the name of the backup you selected above)


##### Total System restore

Sometimes you either need to wipe your Pool, Migrate to a new Pool or restore a system completely.
With the above steps this is all very-much-possible.

0. Do not initiate the (select a pool for) Apps system yet.

1. Optional: When the SCALE system itself is also wiped, ensure to restore it using a SCALE config export **first**.

2. Using ZFS replication, move back the previously backed-up `ix-applications` dataset.

3. Continue with the steps listed on `Reverting a running system`

#### Video Guide

TBD


##### Additional Documentation
