---
title: Installation notes and guidelines
---

## CSRF Error

Starting with Seafile 11, the defaults fail CSRF verification, and you may see the error message when logging in.

![CSRF](./img/CSRF.png)

To fix this, the following must be added to your `seahub_settings.conf` file. It is found inside `/shared/conf`. We recommedend enabling the `Code-server` addon or mounting the container

![Stock](./img/StockSeahub_settings.png)

Add an entry for: `CSRF_TRUSTED_ORIGINS = ["https://seafile.YOURDOMAINHERE.com"]`

![CSRFadded](./img/CSRFAdded_SeaHub_Settings.png)

## Storage

Seafile uses Block storage so files/folders uploaded to Seafile aren't visible by default when mounting the persisted storage. For more information see the this [post](https://forum.seafile.com/t/maintain-file-name-after-upload/11190/3) on the Seafile Forums. As well, Seafile uses init scripts which need to be run as `root` so if `hostpath` is used (such as using HDDs) then make sure your storage is owned by `root`.

## WebDAV

By default WebDAV is disabled by default, as per [upstream docs](https://manual.seafile.com/extension/webdav/). Here's some simple instructions to modify your `seafdav.conf` to enable WebDAV if you wish to use it with Traefik.

- Enter Seafile Pod Shell
- Use the CLI to enter the Seafile WebDAV (`seafdav.conf`) config file
- Use vi commands to edit the `Enabled` to `true` and change the share name as desired (default is `/seafdav`).
> Use `i` to insert text and and `:wq`, and `ESC key` to exit insert mode

- Restart Seafile and your WebDAV share will be accessible using your domain.com/seafdav

![SeafileWebDAV](./img/SeafileWebDAV.png)
