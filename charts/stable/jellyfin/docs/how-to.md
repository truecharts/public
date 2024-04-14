---
title: Setup Guide
---

**Jellyfin** Media Server is a free fully open-source solution to watch your media from anywhere
and our app is a simple way to install it on your TrueNAS SCALE server.

## Requirements

- Jellyfin TrueCharts Chart
- Installation of the TrueCharts Catalog, starting [here](/platforms/scale/guides/getting-started/)

## Media Storage

- We recommend having configured your media before installing the chart.
  Most people will have their media inside their TrueNAS box,
  and for that you can simply follow our [Adding Storage](/platforms/scale/guides/add-storage)
  guide to `Add Additional App Storage` to **Jellyfin** for their media folder.
- However some will prefer `NFS Shares` for this storage,
  as they may need to share these folders with other users on other
  devices outside of TrueNAS, so we recommend following the [using NFS Shares guide](/platforms/scale/guides/nfs-share/).

## Install Jellyfin inside TrueNAS SCALE

- Select `Apps` inside the `TrueNAS` menu,
- Then choose the `Available Applications` tab,
- and search for `jellyfin`

![Search Jellyfin](./img/SearchJellyfin.png)

- Click the Install button, and you’ll be prompted to set up the **Jellyfin** software.
- Most of the settings can be left at the default values, but ensure you select the correct
  timezone before scrolling down to the Networking and Services section.
  Take note of the default port (8096) that **Jellyfin** is listening on, and move down to Storage and Persistence.

### Jellyfin Configuration Storage

The Jellyfin software itself will have some integrated configuration storage included
with a “PVC” storage type - make sure not to change this, as it’s the preferred and supported option from TrueCharts.

![Jellyfin PVC](./img/JellyfinPVC.png)

### Jellyfin App Transcode Storage

Users can choose from the default PVC for the **Jellyfin** App Transcode directory or they can
change the App Transcode Storage to the emptyDir type, with the Default storage medium.

More advanced users with a large amount of RAM in their TrueNAS machine might consider
changing the transcoding space to use the Memory storage medium. Note that this can potentially
consume a large amount of memory if you’re streaming high-definition video content, or multiple streams at the same time.

![Jellyfin App Transcode](./img/JellyfinTranscodeDir.png)

### Jellyfin Media Storage

To add your media directory inside **Jellyfin** you have to click on `Add` in the `Additional App Storage` section.

Depending on your media type (HostPath or NFS) feel free to follow the guides linked earlier in this guide.
As an example we'll add an existing `NFS Share` as many users will have that for their media storage.

- Select an NFS Share for the type of storage
- Enter `localhost` or the `IP address` for your NFS server.
- Enter the path to your media folder, making sure to match the capitalization,
- Fill out and take note of a Mount Path that your **Jellyfin** server will access it through. Mark this as Read Only.

![JellyfinNFSShare](./img/JellyfinNFSStorage.png)

Repeat this process for each additional media folder you may have.

If you have a GPU in your TrueNAS system that’s capable of video transcoding in hardware,
you can add it to **Jellyfin** under the Resources and Devices section.

Scroll to the bottom of the window and click Save.

Once you hit Save, the process of downloading and setting up **Jellyfin** will begin.
Switch back to the Installed Applications tab, and wait for the application to switch
from Deploying to Active - once it does, click the Open button to launch the **Jellyfin** welcome portal.

## Jellyfin Initial Setup

Select your language, define a user to be used for administrative purposes in **Jellyfin**
(as well as your first playback) and then choose the Add Media Library button.

![JellyfinAddMedia](./img/JellyfinAddMedia.png)

Choose the media type (or as best as you can match it) and click the (+) sign beside Folders to add a Mount Path that you shared over NFS from above.

![JellyfinAddMovies1](./img/JellyfinAddMovies1.png)
![JellyfinAddMovies2](./img/JellyfinAddMovies2.png)

- If required, add more media libraries - music, TV shows, photos - and then click Next.
- Set your default metadata language for obtaining media information from the Internet,
  and leave the Allow remote connections to this server option checked - otherwise,
  you won’t be able to view anything you just made available.
- Click on Finish and you’ll be sent to the dashboard, where you can log in as the user you set up during the wizard, and start watching your shows!

## Support

- You can also reach us using [Discord](https://discord.gg/tVsPTHWTtr) for real-time feedback and support
- If you found a bug in our chart, open a Github [issue](https://github.com/truecharts/apps/issues/new/choose)
- For further information on operating **Jellyfin** itself, start with their [Quick Start Guide](https://jellyfin.org/docs/general/quick-start).
