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
