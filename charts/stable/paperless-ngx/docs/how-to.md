# Setup Guide

**Paperless-ngx** is an open-source document management system that transforms your physical documents into a searchable
online archive. Our app is a simple way to install it on your TrueNAS SCALE server.

## Requirements

- Installation of the TrueCharts Catalog, starting [here](https://truecharts.org/manual/SCALE/guides/getting-started)
- [`CloundNative-PG`
  operator](https://truecharts.org/manual/SCALE/guides/getting-started#cnpg-and-prometheus-operators-installation-and-migration-guide-for-older-users)
- Paperless-ngx TrueCharts Chart

## Media Storage

- If you plan on importing documents into Paperless-ngx via a network share, for example from a computer or scanner, it
  is recommended to setup an `NFS Share` for the shared folder. See the [NFS Shares
  guide](https://truecharts.org/manual/SCALE/guides/nfs-share) for further information.

## Install Paperless inside TrueNAS SCALE

- Select `Apps` inside the TrueNAS menu.
- Choose the `Available Applications` tab.
- Search for `paperless-ngx`.

![Search paperless-ngx](img/search_paperless-ngx.png)

- Click the Install button, you'll be prompted to set up Paperless-ngx. You can leave most options at their default
  values, but:
  - Check that the `Timezone` is set correctly for this app.
  - Provide `PAPERLESS_ADMIN_USER`, `PAPERLESS_ADMIN_PASSWORD` and `PAPERLESS_ADMIN_MAIL`, those will only apply on
    installation, you can change them later in the app.
  - Enter the URL your Paperless-ngx will be accessible under in `PAPERLESS_URL` if you plan on making your app
    accessible from the web.
- If you have set up [Traefik](https://truecharts.org/charts/enterprise/traefik/how-to/) for ingress click `Enable
  Ingress` and enter your Paperless-ngx domain in the Hosts section.

![Configure paperless-ngx](img/configure_paperless-ngx.png)

Scroll to the botton of the window and click `Save`. Once you hit Save Paperless-ngx will be donwloaded and configured. 

Switch back to the `Installed Applications` tab, and wait for the application to switch from `Deploying` to `Active`.
Once `paperless-ngx` shows `Active` you can click its `Open` button to launch to its login screen. Use the initial Admin
credentials you provided in the configuration to login.

<!-- TODO

### Configure additional OCR languages

### Configure import share

### Configure ForwardAuth authentication

-->

## Where to go from here?

Paperless-ngx offers a helpful [best practices guide](https://docs.paperless-ngx.com/usage/#basic-searching) as a
starting point, as well as a recommended workflow a little further along on that same page.

## Support

- You can reach us using [Discord](https://discord.gg/tVsPTHWTtr) for real-time feedback and support.
- If you found a bug in our chart, open a [GitHub issue](https://github.com/truecharts/apps/issues/new/choose).
