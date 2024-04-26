---
title: Installing Traefik
---

Within TrueCharts, our aim is to make it as easy as possible to secure your Apps.
To support this, we supply a separate Traefik "ingress" app, which has been pre-configured to provide secure and fast connections.

:::notice

The current TrueCharts implementation of Traefik doesn't support TCP/UDP Ingress, only HTTP/HTTPS.

:::

## How-To

### TrueNAS WebUI

In order to set up Traefik, you will be required to change the default TrueNAS WebUI access ports.
These ports are by default set to port `80` for HTTP and port `443` for HTTPS.
This is necessary as we will be setting Traefik up to function as a reverse proxy, and to receive traffic on these host ports.

In the TrueNAS Menu, navigate to **System Settings** > **General**. Click the **Settings** button at the top right of the GUI component.
Under these **GUI Settings**, change:

- Web Interface HTTP Port to port `81`
- Web Interface HTTPS Port to port `444`.

Click **Save** to save your changes. The WebUI will now prompt you to restart the web server service,
after which you will be automatically redirected to your dashboard through one of the new ports.
If you are not prompted to restart the web server service, you may restart the machine and manually navigate
to the WebUI address followed by one of the new ports eg. `truenas.local:81`.

:::tip

These are the recommended ports for this procedure. Using different ports may require some
changes to your configuration that are not covered in this tutorial.

:::

:::caution

Do not skip this step. Neglecting to change the default ports active may cause your WebUI to become inaccessible after the following step.
Ensure you are accessing your WebUI from the new ports before proceeding.

:::

### Installing the Traefik SCALE App

:::note

Traefik is part of the `premium` train, so make sure you have it enabled as specified in the [guide](/scale/#adding-truecharts).

:::

In the TrueNAS Menu, navigate to **Apps** > **Discover Apps**. Use the search bar to search for or manually
find the Traefik app in the list of apps, and click **Install**.

The setup of Traefik is relatively straight-forward. Most of the settings remain unchanged from default, except for these two:

- **Application Name**: Enter a name for your app. You may use simply _traefik_ for this field.
- At the bottom, check the warning checkbox.

Continue to section 12, and select **Next**. Traefik will now be installed.
After installation you can access the Traefik dashboard using your host IP address followed by `:9000`, or by simply clicking `Open` on the application's entry under **Apps** > **Installed Applications**.

## Video Guide

<iframe width="560" height="315" src="https://www.youtube.com/embed/bWNPfrKjawI" title="YouTube video player" frameBorder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowFullScreen></iframe>
