# Community Migration Guide

:::warn

This guide does not fall under support, use at your own risk. You can create a thread in our discord channel [#📚・tc-scale-apps](https://discord.gg/a5fj3FJ9Mx) for basic support for the guide itself.

:::

This guide will walk you through on migrating your plex config data from a _old_ to the new plex instance. IE official to truecharts.

The first thing you need to do is go to **settings** and then **Library**.

- Disable `Empty trash automatically after every scan` checkbox if its enabled.

Go to **Settings** -> **General** and `Sign Out` of your server completely.

In scale, go to **apps** -> **Installed Applications** turn the _old_ app **off**.

Follow the sub section depending on how your app config was stored.

## Backing up App Data From PVC

To access the app's data from **PVC**, we are going to use [**truetool**](https://github.com/truecharts/truetool#how-to-install) mount flag.

Go to **system settings** -> **shell**.

Make sure truetool is installed and active (refer to the link above for the how to guide) before running the following commands:

```console
truetool --mount
```

```console
1
```

You will get list similar like this for example.

![truetool-mount-list](./img/truetool-mount-list.png)

To mount the directory just enter the correct number...so for me I have to enter `51`. Verify the number you are entering is for plex-config.

you will get a unmount command similar to this:

```console
zfs set mountpoint=legacy root/ix-applications/releases/plex-config/volumes/pvc-af2b9242-ecf6-4659-ace4-d601211cf448 && rmdir /mnt/truetool/plex-config
```

The old plex app is mounted in a dir for example `/mnt/truetool/plex-config`.

The above assumes your app is named `plex`, if its not the dir `name` will be **different**.

You have two options here:

1.  [Copy and Delete](#Copy-and-Delete)
2.  [Install New](#Install-New)

### Copy and Delete

Create a dataset in **storage** -> **datasets** for your old app plex config with the follow perms as **apps** since its our default user and group for most of our charts:

![perms](./img/media-dataset-perms.png)

- run the following commands:

  Make sure you are in the correct working dir.

  ```console
  cd /mnt/truetool/plex-config
  ```

  run this command to verify you see a single dir called **Library**.

  ```console
  ls
  ```

  Replace this command's path with your **OWN** `pool name`, `dataset name` and `dir` if you created one specifically for the config.

  ```console
  rsync -rav Library /mnt/POOL/DATASET/PLEX_CONFIG_DIR
  ```

Unmount the PVC

```console
truetool --mount
```

```console
2
```

- Delete the old app afterwards.

:::note

This is just temporary dataset, you will be setting up the config data for the new app as PVC as its our [recommended and supported](https://truecharts.org/manual/FAQ#why-pvc-is-recommended-over-hostpath) storage type for the majority of our apps.

:::

### Install New

Edit the old app and change its port to 32399 or something else that wont conflict with the new app - Install the new plex app and give a different name like `plex-media-server` or something. - Keep it strictly default for now and don't add anything yet. - Wait for it to go active and access it via its ip:port - Check if the setup/auth page can be reach. If it can, **DON'T** sign in and just turn the new app off.

### Backup Option

If you want to re-use the same name and port without having to edit the app back and forth, i suggest [Copy and Delete](#Copy-and-Delete), but if you want to be safe and keep the old app until the new one is active then [Install New](#Install-New) is doable.

## Accessing App Data HostPath

While its not wise or recommended to have the app config data permanently as hostpath, read our faq about [PVC](https://truecharts.org/manual/FAQ#why-pvc-is-recommended-over-hostpath).

Verify the dataset that holds the old app config permissions are for example default:
![perms](./img/media-dataset-perms.png)

There's not much to do other than recommend copying the config data over to the new app.

---

## App Data Migration

If the new plex app is not installed yet, please do so now. Verify that the **new** app can go active with just the defaults for now.

If it works, dont sign in yet, simply turn off the app and then go to **system settings** -> **shell**.

We're going to mount the new plex app config data. Run the following commands in the shell.

```console
truetool --mount
```

```console
1
```

You will get list similar like this for example.

![truetool-mount-list](./img/truetool-mount-list.png)

To mount the directory just enter the correct number...so for me I have to enter `51`. Verify the number you are entering is for plex-config.

you will get a unmount command similar to this:

```console
zfs set mountpoint=legacy root/ix-applications/releases/plex-config/volumes/pvc-af2b9242-ecf6-4659-ace4-d601211cf448 && rmdir /mnt/truetool/plex-config
```

The new plex app is mounted in a dir for example `/mnt/truetool/plex-config`.

Change the working directory to the mounted dir for the new app:

```console
cd /mnt/truetool/plex-config
```

Check if you're in the right location by running:

```console
ls
```

You should only see a single dir called `Library`.

Delete this dir from the new app.

```console
rm -r Library
```

now grab the path for your dataset that holds your plex config.

for example...my path would be `/mnt/tank/configs/plex`.

run the `LS` command on the dir to verify that its correct and you see a single dir called `Library`.

```console
ls /mnt/tank/configs/plex
```

If everything is set you can proceed to run the rsync copy command to the mounted PVC location.

```console
  rsync -rav Library /mnt/truetool/plex-config
```

:::note

This process can a while to complete depending on how large your config is and how your pools are setup. Make sure scale doesnt time out, simply keep the tab active and interact with the page menu top right will suffice until its done.

:::

If the operation completed successfully you can run the following commands to unmount the PVC.

```console
truetool --mount
```

```console
2
```

---

## New Plex App

Before you start the new plex app edit the app and add your media via additional storage with the correct **mountpath** from the original app and update any variables as needed.

The official app from scale use the `/data` path for media, but you could have used an entirely different dir for it.

I highly recommend setting up the variable `Plex Claim Token` last as it has a 4 min window.

To get a claim token from plex, go to [Plex Claim Token](https://plex.tv/claim).

Once set, save and wait a min for the task to finish and then start the app.

---

You should now be able to access plex's web service as normal with all your data intact.

You can remove the temp dataset that holds your plex config as its not needed anymore.

:::warn

This guide does not fall under support, use at your own risk. You can create a thread in our discord channel [#📚・tc-scale-apps](https://discord.gg/a5fj3FJ9Mx) for basic support for the guide itself.

:::
