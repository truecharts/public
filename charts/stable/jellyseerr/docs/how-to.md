---
title: Setup Guide
---

**Jellyseerr** is a free and open source software application for managing requests for your media library. It is a fork of [Overseerr](https://github.com/sct/overseerr) built to bring support for [Jellyfin](https://github.com/jellyfin/jellyfin) & [Emby](https://github.com/MediaBrowser/Emby) media servers!
## Requirements

- Jellyseerr TrueCharts Chart
- Installation of the TrueCharts Catalog, starting [here](https://truecharts.org/manual/SCALE/guides/getting-started#adding-truecharts)

## Install Jellyseerr inside TrueNAS SCALE

- Select `Apps` inside the `TrueNAS` menu,
- Then choose the `Available Applications` tab,
- and search for `jellyseerr`

![Search Jellyseer](./img/SearchJellyseer.png)

- Click the Install button, and you’ll be prompted to set up the **Jellyseer** software.
- Most of the settings can be left at the default values, but ensure you select the correct
  timezone before scrolling down to the Networking and Services section.
  Take note of the default port (10241) that **Jellyfin** is listening on.

Scroll to the bottom of the window and click Save.

Once you hit Save, the process of downloading and setting up **Jellyseerr** will begin.
Switch back to the Installed Applications tab, and wait for the application to switch
from Deploying to Active - once it does, click the Open button to launch the **Jellyseerr** welcome portal.

## Jellyseerr Initial Setup

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
