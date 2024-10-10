---
title: Dataset and Share Setup Guide
---

:::danger

TrueNAS SCALE Apps are considered Deprecated. We heavily recommend using a more mature Kubernetes platform such as "TalosOS" instead, and no longer offer an apps/charts catalogue for SCALE users to install. The below docs exist purely as historical references and may be removed at any time.

:::

This guide provides the recommended setup for dataset permissions, shares and application data storage.

## Dataset Permissions

TrueCharts applications are designed to use the `apps` (568) user for data permissions. Configure your dataset permissions as shown below to allows applications access.

:::tip[ACL]

If your existing dataset shows `Edit ACL` then you need to `Strip ACL` before continuing.

:::

![data-perms](./img/data-perms.png)

## SMB Access

For SMB access you will need to create a user(s) that are members of the `apps` group and modify the default SMB settings.

### SMB User

Create a user and assign it to the `apps` group under `Auxiliary Groups` as shown below.

![user-groups](./img/user-groups.png)

### SMB Share

Create an SMB Share as shown below. All settings should remain default.

:::caution[ACL]

After saving SMB settings TrueNAS Scale will ask if you want to `Configure ACL`. Do **NOT** as this will overwrite the previously configured permissions. You can select `Cancel`, the SMB Share will still be configured.

:::

![share-smb](./img/share-smb-cobia.png)

#### Setup SMB Share Auxiliary Parameters

With the release of Cobia the `Auxiliary Parameters` has been removed from the WebUI. The below will guide you through the use of API calls and the system shell to add the correct parameters.

Open the SCALE System GUI Shell and enter the following command:

```bash
midclt call sharing.smb.query | jq
```

![smb-cli1](./img/smb-cli1.png)

Take note of the id(s) you wish to setup.

Enter the following command, make sure to replace `<id>` with the id from above.

```bash
midclt call sharing.smb.update <id> '{"auxsmbconf": "force user = apps\nforce group = apps"}'
```

The output should include the following if it was done correctly:

![smb-cli2](./img/smb-cli2.png)

Repeat for any additional SMB Shares.

## NFS Share

Create an NFS Share which will be used for applications to access the dataset. Configure an NFS Share as shown below. You will need to click `Advanced Options` to set `Maproot User` to `root`.

![nfs-share-cobia](./img/nfs-share-cobia.png)

## App Storage

For most applications data access will be configured under `Additional App Storage`.

:::caution[APP CONFIG STORAGE]

NFS should **NOT** be used for `App Config Storage`. This should be left on the default of PVC.

:::

Configure `Additional App Storage` as shown below. In some applications data storage is part of the application configuration, in those cases you would still configure NFS but not need to setup a `Mount Path`.

![app-storage](./img/app-storage.png)
