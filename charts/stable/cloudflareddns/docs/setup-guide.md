# How-To

So you've followed some of our TrueNAS guides, setup your domain name, certificates and use Cloudflare for your DNS management, however you don't have a static IP, then this guide is for you. This quick guide will help you go through the steps to use Cloudflareddns to update your dynamic IP along with your entire deployment so that even if you change IP your domain will point to the right address.

## Requirements

Domain name (can be purchased through Cloudflare or etc)

Cloudflare DNS management

- Sign up for Cloudflare free
- Point your nameservers to the ones Cloudflare assigns to you
  ![image](https://user-images.githubusercontent.com/89483932/179332161-e903e46e-ed8c-4b58-81fc-6fcadf1a9851.png)

Cloudflareddns chart

## Prerequisites

This guide assumes you've followed our main [Quick-Start Guide](https://truecharts.org/docs/manual/SCALE%20Apps/Quick-Start%20Guides/adding-letsencrypt) with your domain on TrueNAS and done the configuration for your DNS on Cloudflare (see [this video](https://www.youtube.com/watch?v=hJVghecs3rE) on our YouTube channel)

The recommended way is to setup CNAMEs for your subdomains (charts) and keep your A record pointed to your base domain, such as below

![image](https://user-images.githubusercontent.com/89483932/179334653-316e462f-7bf7-4cda-a9dc-dd8842e76021.png)

To keep things simple, one can simply using the Global API key from Cloudflare that you previously used inside our guides to setup your certificates, in case you forget it's in the page below

![Overview](https://user-images.githubusercontent.com/89483932/179630007-5a4136ee-05ef-48e6-a900-74c2841ba312.png)

## Cloudflareddns chart setup

Step 1-2: Name chart and leave defaults for Step 2

![Step 1](https://user-images.githubusercontent.com/89483932/179336761-2ce2da3a-cd75-43ba-befe-4c3775f04027.png)

Step 3:

![Container Configuration](https://user-images.githubusercontent.com/89483932/179630166-b3b9e673-ec0e-4db2-a5ac-8fec4e9d319e.png)

Use Global API ley from Cloudflare Domain Overview page (see above) for the `CF_APITKEY` field

Change `CF_USER` to your Cloudflare Email Account

Change `CF_HOSTS` to your DNS Zone A record (mydomain.com)

Change `CF_ZONES` to the same Zone (mydomain.com)

Change `CF_RECORDTYPES` to A if you're only changing your main domain

If you're using or changing specific A records or CNAMEs you may want to refer to the upstream documentation for more examples [here](https://hotio.dev/containers/cloudflareddns/))

Steps 4-8: Adjust as necessary but defaults are fine

## Support

- If you need more details or have a more custom setup the documentation on the [upstream](https://hotio.dev/containers/cloudflareddns/) is very complete so check the descriptions of the options there.
- You can also reach us using [Discord](https://discord.gg/tVsPTHWTtr) for real-time feedback and support
- If you found a bug in our chart, open a Github [issue](https://github.com/truecharts/apps/issues/new/choose)

---

All Rights Reserved - The TrueCharts Project
