---
title: Adding Storage
---

:::danger

TrueNAS SCALE Apps are considered Deprecated. We heavily recommend using a more mature Kubernetes platform such as "TalosOS" instead, and no longer offer an apps/charts catalogue for SCALE users to install. The below docs exist purely as historical references and may be removed at any time.

:::

Apps in SCALE rely on several kinds of storage for core data:

- [Persistent Volumes](https://docs.k3s.io/storage) (`PVC`), a specific volume which Kubernetes will not delete (i.e. persist) through upgrades, restarts, and rollbacks of your app/chart.
- Hostpaths (`hostpath`), a path (/mnt/tank/pool/folder) to a data volume, typically a dataset within a pool on your SCALE installation, or a mounted folder to network attached storage.
- You can use a folder mapped to the container or memory (`emptyDir`).
- You can directly link an NFS share (`NFS Share`) to your app storage.

You can choose during app installation to use a PVC to store all of your app's data, or manually assign a hostpath.

**Note:** We only provide support for apps using **PVC** for core app storage, often named "config", but you can always add additional hostpaths for other storage, such as your media.

## Adding additional app storage

Even if an app doesn't let you specify a hostpath in its chart config, the TrueCharts config lets you **add additional app storage** through hostpaths which are linked to a local path on the app (e.g linking `/mnt/tank/pool/folder` to `/media/folder`). This will allow the path on your SCALE installation to be available from your app, assuming permissions are correctly configured.

From your SCALE App's configuration (during or after installation):

1. Scroll down to `Storage and Persistence`
2. Under `Additional App Storage`, click **Add**
3. Check the box next to **Automatic Permissions** if you'd like the app to automatically configure permissions to the UID of the container (_default:_ `568`)
4. Specify the type of storage you'd like to add (typically a `hostpath`)
5. _(For hostpaths)_ Specify the path on your SCALE installation you'd like to mount to the container (e.g. `/mnt/tank/pool/folder`)
6. _(For hostpaths)_ Specify the path on you App you'd like to link to the hostpath (e.g. `/media/folder`)
7. Click **Save** to re-create your App with the specified additional app storage.

## Permissions

Permissions apply for app storage and are based on the app's fsGroup which you can configure during app installation. By default most apps will set this to the `apps` group (568).

Apps also have a **Automatic Permissions** option for app storage and additional app storage. If you enable automatic permissions, the app will attempt to `chown` the hostpath and all subfolders within the hostpath during deployment. **Note:** This may not work for large volumes.

- Be careful with automatic permissions for shared datasets, especially if folders or subfolders carry different user/group owners. Be sure that your permission changes will not break other apps/services.
- The `Automatic Permissions` command for an app will only apply upon the installation or update of an app.
- It's not typically recommended to use automatic permissions for mounted shares (e.g. NFS shares on other external systems) since it will rewrite permissions for those folders which may be shared with multiple systems.
- You can always add the apps fsGroup (_default:_ `568`)
- ACLs are not recommended or supported for app storage as many apps have issues with accessing data managed by an ACL.

You can learn more about permissions and ACLs in the [TrueNAS SCALE Docs](https://www.truenas.com/docs/scale/scaleuireference/storage/datasets/editaclscreens/).

## Host Path Validation Safety

Starting with SCALE Bluefin (22.12), there's a new safety check on apps called **Host Path Safety Checks** located in your SCALE installation's Apps **Advanced Settings** (the same place as your k3s network, GPU, and other settings). This check is intended to ensure datasets used by your apps (e.g. media datasets) are not in use by a network share (e.g. SMB, NFS, CIFS). We require this for security (Protect the system from container escape vulnerabilities using hostPath) and reliability (Prevent multiple services (shares for example) from using the same dataset.) reasons. **You can disable these checks, but it may lead to issues with your Apps depending on your permissions configuration**.

To disable Host Path Safety Checks:

1. From the SCALE Apps page, click **Settings** > **Advanced Settings**
2. Uncheck **Enable Host Path Safety Checks**
3. Click **Save** and wait for your apps to re-deploy.

Alternatively, you can add your additional app storage [using the NFS share option](/deprecated/scale/guides/nfs-share) instead of hostpath without violating Host Path Safety Checks.

**If you choose to disable your host path safety checks, we cannot provide support for any issues related to storage or permission.** When opening a TrueCharts support ticket related to storage issues, you must show that host path safety checks are still enabled in order for us to help.

## Video Guide

<iframe width="560" height="315" src="https://www.youtube.com/embed/aktv1r-KRI0" title="YouTube video player" frameBorder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowFullScreen></iframe>

## Notes

- When using hostpaths for config data and other app data, you typically want to create a dataset in your pool for each app so you can individually configure and manage the data and permissions.
- Using hostpath instead of PVC can also cause issues with rollbacks if the container isn't able to update config files and other data during the rollback.
- If you have legacy (i.e. FreeNAS, TrueNAS or early SCALE) datasets, you may typically see the media fsGroup or PUID (`8675309`) which you'll want to adjust your permission to work with apps running under the apps PUID (`568`).
- Apps which violate Host Path Safety Checks will not finish deploying. In other words, if you have an app deploying which includes a hostpath shared with an SMB/NFS share, you'll see errors in the App's events during deployment.
- Creating separate datasets in your pool will let you independently manage permissions each for parent or child dataset.
