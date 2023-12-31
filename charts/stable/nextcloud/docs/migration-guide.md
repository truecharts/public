---
title: Nextcloud Migration Guide
---

This guide will walk you through the migration process for Nextcloud. This guide utilize HostPath or NFS for UserData.

:::danger SMB EXTERNAL STORAGE

If you are using SMB authenticated external storage on your Nextcloud remove it before starting this guide. The migration process will fail if it is not removed.

:::

:::danger TWO FACTOR AUTHENTICATION

If you are using two factor authentication on your Nextcloud accounts disable it before starting this guide. While it can be done via the CLI later it is much easier to disable it before hand.

:::

## Backup Nextcloud Database

If you have not already done so install PGAdmin and the [tcdbinfo.sh script](https://truecharts.org/manual/SCALE/guides/sql-export#how-to-list-database-login-info-for-truecharts-apps)

1. Run the tcdbinfo.sh script and take note of the connection info

```bash
bash tcdbinfo.sh
```

![tcdbinfo-output](./img/tcdbinfo-output.png)
2. Add Nextcloud to PGAdmin using the connection info from previous step.
![pgadmin-connection1](./img/pgadmin-connection1.png)
![pgadmin-connection2](./img/pgadmin-connection2.png)
3. Backup Nextcloud database.
![pgadmin-backup](./img/pgadmin-backup.png)

## Delete Nextcloud

:::danger Userdata Location

Do not remove your Nextcloud installation until you have confirmed you use HostPath/NFS for user data or have copied UserData using utilizing [Heavyscript](https://github.com/Heavybullets8/heavy_script)

:::

If you are using HostPath of NFS for UserData then remove your current Nextcloud installation. If you are using PVC for UserData then you will first need to mount your Nextcloud PVC and copy your UserData to a new dataset.

## Remove Old Nextcloud AppData

This step is not required but to have a clean installation remove all UserData folder and files that are not user folders.

```bash
ls -la
```

![userdata-old](./img/userdata-old.png)

:::warning

Next steps are destructive without a way to undo.
Make sure you have proper backups to avoid data loss.

You have been **warned**

```bash
rm -rf <folder>
```

```bash
rm .ocdata .htaccess index.html nextcloud.log
```

![userdata-clean](./img/userdata-clean.png)

:::

## Change UserData Permissions

The new version of Nextcloud uses apps instead of www-data for file ownership. Apply permissions as shown below to your UserData dataset.

![userdata-perms](./img/userdata-perms.png)

## Install Nextcloud

Install with a temporary user that you do not currently use for Nextcloud (ie. temp)

Setup Nextcloud UserData storage with your previous UserData dataset or the dataset you copied your UserData to.

![userdata-setting](./img/userdata-setting.png)

## Restore Nextcloud Database

:::caution Nextcloud Installation

Wait for Nextcloud to fully deploy before proceeding.

:::

1. Stop the main pod of Nextcloud.

    ```bash
    k3s kubectl scale deploy nextcloud -n ix-nextcloud --replicas=0
    ```

2. Add Nextcloud to PGAdmin as guided in [steps 1 and 2 here](#backup-nextcloud-database).
3. In PGAdmin right click on the database and select restore as shown below.
  ![pgadmin-restore1](./img/pgadmin-restore1.png)
4. Select the database backup you created previously.
  ![pgadmin-restore2](./img/pgadmin-restore2.png)
5. Configure Data/Objects as shown below.
  ![pgadmin-restore3](./img/pgadmin-restore3.png)
6. Configure Options as shown below and click restore.
  ![pgadmin-restore4](./img/pgadmin-restore4.png)
    :::caution PGAdmin Error

    PGAdmin may display an error during the restore process. This is known to occur and may be ignored.

    :::

7. Start the main pod of Nextcloud.

  ```bash
  k3s kubectl scale deploy nextcloud -n ix-nextcloud --replicas=1
  ```

## Nextcloud OCC Commands

:::caution Nextcloud Deploy

Wait for Nextcloud to fully deploy before proceeding.

:::

1. Open a shell for the Nextcloud main pod as shown below. Ensure your are selecting the correct pod it should just say nextcloud for both Pods (followed by random characters only) and Containers as shown below.
![nextcloud-cli](./img/nextcloud-cli.png)
2. Run the following commands in the Nextcloud shell.

```bash
occ upgrade
```

```bash
occ maintenance:mode --on
```

```bash
occ maintenance:repair
```

```bash
occ maintenance:mode --off
```

```bash
occ db:add-missing-indices
```

```bash
occ files:scan --all
```

## Delete Temporary User Data Folder

You may now remove the folder created during install for the temporary user that was configured.
