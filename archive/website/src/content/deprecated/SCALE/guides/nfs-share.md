---
title: NFS Shares with Apps on TrueNAS SCALE
---

:::danger

TrueNAS SCALE Apps are considered Deprecated. We heavily recommend using a more mature Kubernetes platform such as "TalosOS" instead, and no longer offer an apps/charts catalogue for SCALE users to install. The below docs exist purely as historical references and may be removed at any time.

:::

With the changes to TrueNAS SCALE 22.12 concerning HostPath validation (read our [news](/news/hostpath-validation) or our [adding storage](/deprecated/scale/guides/add-storage) pages to learn more) the one way to add media storage is to mount NFS Shares to your TrueCharts applications. This process involves two parts, and this guide will demonstrate each step to create NFS Shares in SCALE and then add them in the `Storage` section of TrueCharts apps.

Additionally, you can use NFS shares and SMB shares on the same dataset, but only NFS shares are mounted by TrueCharts applications.

:::note

This won't work with the iX/"Official" catalog applications

:::

:::caution[Application Databases / Configs on NFS Shares]

NFS Shares are meant for sharing your file/media shares with other users or computers. This is not meant for the entire application. Our recommended approach and default for most applications is PVC storage (read more [here](/general/faq#why-pvc-is-recommended-over-hostpath)). There is known cases of database corruption with NFS Shares and sqlite so you are warned

:::

## Part 1 - Create NFS Shares in SCALE

In the main SCALE GUI, select the `Shares` item on the menu bar and you'll read this page.

![Shares Main](./img/Sharesmain.png)

Click on `Add` inside the "UNIX (NFS) Shares" section. Select the dataset or folder that contains your media library, a description is optional but helps, and then click `Save`

![Add NFS Share](./img/AddNFSShare.png)

Repeat as necessary for different folders or datasets you wish to share, and make sure you note the paths of each NFS Share, as you will need to enter those later.

## Part 2 - Add NFS Shares to Applications

Next you're going to add NFS Storage to your applications. This can be in the "media" or "downloads" storage sections for certain apps, or "Additional App Storage" for others (such as the example below). **We do not recommend installing the entire app to NFS Shares as that can corrupt any databases inside the app.** This is meant for media or file storage only.

1. Select `Add` next to "Additional Add Storage"

![Additional Storage Add](./img/BlankAddAppStorage.png)

2. Change to `NFS Share` in the "Type of Storage" dropdown

![NFS Add Storage Blank](./img/NFSAddAppStorageBlank.png)

3. Enter info for yourNFS Share as below, for this example we'll use the "Downloads" share we created above.

- The NFS Server should be `localhost`
- `Path on NFS Server` has to match your NFS Shares path, as above I had _mnt/Storage/Apps/Downloads/_
- `Mount Path` is the container's path to mount the storage to, I simply put `/downloads`

![NFS Add Storage Filled](./img/NFSAddAppStorageFilled.png)

- Continue entering info as any regular app and click `Save`.

And that's it, to verify depending on the app you can use the App Shell such as the example below or the GUI inside the web interface of your app.

![App Shell Storage Added](./img/AppShellStorageAdded.png)
