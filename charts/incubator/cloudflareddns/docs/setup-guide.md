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

This guide assumes you've followed our main [Quick-Start Guide](https://truecharts.org/docs/manual/SCALE%20Apps/Quick-Start%20Guides/adding-letsencrypt) with your domain on TrueNAS and done the configuration for your DNS on Cloudflare (see https://www.youtube.com/watch?v=hJVghecs3rE on our YouTube channel)

The recommended way is to setup CNAMEs for your subdomains (charts) and keep your A record pointed to your base domain, such as below

![image](https://user-images.githubusercontent.com/89483932/179334653-316e462f-7bf7-4cda-a9dc-dd8842e76021.png)

Take note of the `Zone ID` and `Account ID`, that's what we'll use inside the Cloudflareddns chart.

![Overview](https://user-images.githubusercontent.com/89483932/179336819-64a32521-c64b-4ae6-8d5d-225b7342b786.png)

## Cloudflareddns chart setup

Step 1-2: Name chart and leave defaults for Step 2

![Step 1](https://user-images.githubusercontent.com/89483932/179336761-2ce2da3a-cd75-43ba-befe-4c3775f04027.png)

Step 3:

![Step 3 Part 1](https://user-images.githubusercontent.com/89483932/179336779-e2aa5273-8527-40f1-bc3c-3768931ea289.png)

Use ZoneID from Cloudflare Domain Overview page (see above) for the `CF_APITOKEN_ZONE` field

Use Account ID from Cloudflare Domain Overview page (see above) for the `CF_APITOKEN` field

![Step 3 Part 2](https://user-images.githubusercontent.com/89483932/179336787-338b1939-546c-42fa-86a2-afe89da91e8d.png)

You can leave everything but the `CF_RECORDTYPES` to defaults if you're only changing your A record, (refer to the upstream documentation for more options here(https://hotio.dev/containers/cloudflareddns/))

Change `CF_RECORDTYPES` to A if you're only changing your main domain

Steps 4-8: Adjust as necessary but defaults are fine

## Support

- If you need more details or have a more custom setup the documentation on the upstream chart (https://hotio.dev/containers/cloudflareddns/) is very complete so check the descriptions of the options there.
- You can also reach us using Discord for real-time feedback and support
- Check our [Discord](https://discord.gg/tVsPTHWTtr)
- If you found a bug in our chart, open a Github [issue](https://github.com/truecharts/apps/issues/new/choose)

---

All Rights Reserved - The TrueCharts Project
