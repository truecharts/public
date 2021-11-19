# 19 - Backup and Restore

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

## Restore


#### Video Guide

TBD


##### Additional Documentation
