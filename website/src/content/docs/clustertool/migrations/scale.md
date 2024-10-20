---
sidebar:
  order: 1
title: 'TrueNAS SCALE -> ClusterTool'
---

:::caution[Work In Progress]

This program, all its features and its general design, are all a Work-In-Progress. It is not done and not widely available.

All code and docs are considered Pre-Beta drafts

:::

With the upcoming 24.10 "Electric Eel" version of TrueNAS SCALE, iX-Systems has decided to completely gut the Kubernetes backend of SCALE. However, we've got you covered so you can safely keep running your TrueCharts Charts.

Our new ClusterTool can, among other things, be used to craft yourself a new kubernetes backend to continue self-hosting using TrueCharts. For this guide we'll be using a TalosOS VM on TrueNAS SCALE, but any solid hypervisor would suffice.

## Pre-Migrations Advisory

Prior to migration, we require the following to be done:

### **DO NOT** update to Electric Eel

As soon as you migupdaterated to TrueNAS SCALE 24.10 "Electric Eel", you cannot, in any way, migrate your TrueCharts Apps anymore.

### Ensure all "hostPath" storage is replaced with "NFS"-share based storage

With the future migration to Talos using ClusterTool, you won't technically be able to reach these folders through "hostPath" anymore.
Please ensure to make a *seperate* NFS share on TrueNAS SCALE for each of those folders and edit the TrueNAS SCALE App to point towards said share directly.

Please be sure to use the publicly reachable IP of the TrueNAS server and not `127.0.0.1`.

To ensure a stable running environment, we would strongly advise you to ensure the TrueNAS SCALE host running NFS, uses a static IP and does *NOT* use a DHCP-supplied IP address, typically from your modem/router.

Ensure you setup the permissions on the Dataset according to [this](https://truecharts.org/deprecated/scale/guides/dataset/#dataset-permissions) guide.

And configure the NFS Shares according to [this](https://truecharts.org/deprecated/scale/guides/nfs-share/) guide.


We  also *heavily* advise that config storage should almost *always* be set to "PVC" and not *hostPath* nor *NFS*.  If you did decide on using NFS storage for config, we cannot take responsibility if the migration fails.

### NFSv4 Requirement

Our default ClusterTool Talos setup, requires NFSv4 to be enabled on any shares used.
Not doing so beforehand, might lead to issues.

### Ensure all PVC storage has VolSync backups (not restore) Enabled

While we've not fully finished our design docs, there are big chances those are going to require you to already have VolSync backups of any PVC present.

Please follow the guides for setting-up VolSync backups on TrueNAS SCALE. However, setting recovery is not needed and currently not functional on our TrueNAS SCALE Apps. Hence this can be safely skipped.

Setup VolSync according to [this](https://truecharts.org/deprecated/scale/guides/backup-restore/) guide.

*If you currently do not have VolSync installed, a migration-specific catalog will be provided at a later date to install it prior to migration*

### Ensure all CNPG/Postgresql sections have their backups **enabled**

CNPG/postgresql data is not backed up using volsync but uses their own backup solution.
Its imperative to setup those backups seperately as described in [this](https://truecharts.org/deprecated/scale/guides/backup-restore/) guide.

### Note on other databases and their backups

We cannot guarantee the integerty of included:
- MongoDB databases
- Redis Databases
- MariaDB databases

Those might get wiped on migration.

### Keep Existing Data Around

We cannot guarantee everything goes smoothly. Hence we would advice to "unset" the Apps pool, but **do not** remove the `ix-applications` dataset before you've verified your new cluster and its Apps are fully up-and-running. Deleting of Apps and/or the `ix-applications` dataset leads to permanent irreversable dataloss.

#### Cobia specific

When still on TrueNAS SCALE 23.10 "Cobia", we would advice using Heavyscript to make Backups of the Apps system as well.


## Continue with ClusterTool Getting-Started

From this point onwards, please go through the complete [ClusterTool Getting-Started](/clustertool/getting-started) guide.

## Migration

### Important note

We do not sanitise the exported/migated configuration from SCALE.
You yourself are responsible to move any sensitive data to `ClusterEnv.yaml` variables and references them in `helmrelease.yaml` as `${NAMEOFVARIABLE}`

An easy way (GUI) to do this, is stopping the Apps and then editing all SCALE Apps and replacing the sensitive data before export.
In a lot of cases you can even, already, change them into a `${NAMEOFVARIABLE}` format!

This will "break" the Apps from running in SCALE, but guarantees the sensitive data is not ever exported.

### Exporting SCALE Apps

Ensure you git-cloned your Cluster git repository, setup during [ClusterTool Getting-Started](/clustertool/getting-started), onto your TrueNAS SCALE machine.
You can run now `./clustertool scale export`, to export a complete dump of the configuration values for your SCALE Apps.
This command does NOT remove passwords and other credentials from the export files. You're responsible yourself to (re)move them!

Afterwards, ensure you run `git add . && git commit -m "Exported SCALE App config" && git push`

### Converting SCALE Apps to Helm-Release files

- Move back to your main machine running ClusterTool and ensure your gotten your latest additions to your Cluster GIT repository, by running: `git pull`
- Run `./clustertool scale migrate` to convert all exported SCALE Apps to ClusterTool/FluxCD compatible Helm-Releases
- Remove any, unwanted, changes (or duplicates of) to any charts included by clustertool by default.
- run `./clustertool init` and `./clustertool genconfig` again to ensure a fluxcd compatible directory structure is loaded

### Alterations for CNPG restore

The same issues with CNPG restores discussed in [this](https://truecharts.org/deprecated/scale/guides/backup-restore/) guide, also Apply to other clusters/deployments other than TrueNAS SCALE.
Primarily the requirement to set the bootstrap mode to recovery and having to change the revision numbers on both the backup and restore sections.

So to restore your CNPG backup made on SCALE< please ensure this is done before loading onto the cluster

### Loading Into the Cluster

We heavily advice using FluxCD to keep all your charts synced with your github repository as-well-as allow for automated updates.

In case you do not, we've made an alternative for `helm install` and `helm upgrade` that uses the values defined in the `helmrelease.yaml` files instead of `values.yaml`.
This ensures the migration is compatible with both "plain" clusters as well as FluxCD

#### The FluxCD way

- Push the files to your Git Repo Flux should automatically pick it all up.

#### The Helm Way

Run the following for each chart you want imported (altered accordingly):
`./clustertool helmrelease install cluster/main/kubernetes/path/to/my/helmrelease/file.yaml`

If you ever need to do alterations/updates/upgrades manually, there is also a command for that:
`./clustertool helmrelease upgrade cluster/main/kubernetes/path/to/my/helmrelease/file.yaml`



## Known Issues

### VolSync backups broken
In some cases VolSync might not backup your data.
If everything is setup correctly, you can ask our support staff to verify, there is currently not much we can do about this upstream bug.

### TrueNAS SCALE 24.10 "Electric Eel" not supported

Its **NOT** possible *in any way* to do the migration after updating to TrueNAS SCALE 24.10 "Electric Eel"

### MariaDB, MongoDB and Redis data wont migrate

This is correct, all this data will NOT migrate.
This cannot be helped or patched.
