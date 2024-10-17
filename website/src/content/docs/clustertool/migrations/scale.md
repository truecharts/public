---
sidebar:
  order: 1
title: 'TrueNAS SCALE -> ClusterTool'
---

:::caution[Work In Progress]

This program, all its features and its general design, are all a Work-In-Progress. It is not done and not widely available.

All code and docs are considered Pre-Beta drafts

:::

With the upcoming "Electric Eel" version of TrueNAS SCALE, iX-Systems has decided to completely gut the Kubernetes backend of SCALE. However, we've got you covered so you can safely keep running your TrueCharts Charts.

Our new ClusterTool can, among other things, be used to craft yourself a new kubernetes backend to continue self-hosting using TrueCharts. For this guide we'll be using a TalosOS VM on TrueNAS SCALE, but any solid hypervisor would suffice.

## Pre-Migrations Advisory

Prior to migration, we require the following to be done:

### Ensure all "hostPath" storage is replaced with "NFS"-share based storage

With the future migration to Talos using ClusterTool, you won't technically be able to reach these folders through "hostPath" anymore.
Please ensure to make a *seperate* NFS share on TrueNAS SCALE for each of those folders and edit the TrueNAS SCALE App to point towards said share directly.

Please be sure to use the publicly reachable IP of the TrueNAS server and not `127.0.0.1`.

To ensure a stable running environment, we would strongly advise you to ensure the TrueNAS SCALE host running NFS, uses a static IP and does *NOT* use a DHCP-supplied IP address, typically from your modem/router.

Ensure you setup the permissions on the Dataset according to [this](https://truecharts.org/deprecated/scale/guides/dataset/#dataset-permissions) guide.

And configure the NFS Shares according to [this](https://truecharts.org/deprecated/scale/guides/nfs-share/) guide.

:::note


With NFS-based storage, we explicitly refer to the NFS storage type as explained in [this](https://truecharts.org/deprecated/scale/guides/nfs-share/) guide. We do not advise the use of "static-PVC" NFS storage as an alternative

:::

We  also *heavily* advise that config storage should almost *always* be set to "PVC" and not *hostPath* nor *NFS*.  If you did decide on using NFS storage for config, we cannot take responsibility if the migration fails.

### Ensure all PVC storage has VolSync backups (not restore) Enabled

While we've not fully finished our design docs, there are big chances those are going to require you to already have VolSync backups of any PVC present.

Please follow the guides for setting-up VolSync backups on TrueNAS SCALE. However, setting recovery is not needed and currently not functional on our TrueNAS SCALE Apps. Hence this can be safely skipped.

Setup VolSync according to [this](https://truecharts.org/deprecated/scale/guides/backup-restore/) guide.

*If you currently do not have VolSync installed, a migration-specific catalog will be provided at a later date to install it prior to migration*

## Continue with ClusterTool Getting-Started

From this point onwards, please go through the complete [ClusterTool Getting-Started](/clustertool/getting-started) guide.
