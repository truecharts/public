---
title: Installation Guide
---

## Persistence

Add a `data` persistence for your `nzb` files. For example a mountPath `/nzb` directing to a NFS Share.
How to setup your files a good source of information is: [Trashguides](https://trash-guides.info/Downloaders/NZBGet/Basic-Setup/)

## Using NZBGET

### SECURITY settings

**Log-in**

For login credentials defaults:
- Username: `nzbget`
- ControlPassword: `tegbzn6789`

Don't forget to change them in `SECURITY` settings when you are logged in.

**AuthorizedIP**

`127.0.0.1,192.168.0.*,172.16.*.*`

- This field is separated by commas.
- I added my Lan on there `192.168.0.*`
- As well as the kubernetes Network `172.16.*.*`

<br />

### Categories

I use 5 categories

- `Movies` is used by:

??? Radarr "Radarr"

    - We also always enable `Remove Completed` for NZBs

    ![!Settings: Radarr](./img/radarr.png)

- `Series` is used by:

??? Sonarr "Sonarr"

    - We also always enable `Remove Completed` for NZBs

    ![!Settings: Sonarr](./img/sonarr.png)

- `Music` is used by:

??? Lidarr "Lidarr"

    - We also always enable `Remove Completed` for NZBs

    ![!Settings: Lidarr](./img/lidarr.png)

- `Manual` is ignored by all of my applications and only for my personal use

- `Manga` is for Komga
  - Komga doesn't automatically import, We just decided to give it its own category anyway

While creating these categories, We _ONLY_ changed the name, no other field was changed, the files once completed, will still go into their own directory as shown below.

![!Structure: NZBGet](./img/catagories_files.png)

<br />
