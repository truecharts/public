---
title: Setup Guide
---

## Requirements

- Your 'All integrations' API key from your account on `notifiarr.com`
- Installation of the TrueCharts Catalog, starting [here](/platforms/scale/guides/getting-started/#adding-truecharts)

## Install Notifiarr inside TrueNAS SCALE

- Select `Apps` inside the `TrueNAS` menu,
- Then choose the `Available Applications` tab,
- and search for `notifiarr`

- Click the Install button, and you’ll be prompted to set up Notifiarr.
- Most of the settings can be left at the default values, but ensure to add in your API key
- Take note of the default port (5454) that **Notifiarr** is listening on.

## Notifiarr Initial Setup

For your first time log in, use the username `admin` and the API key you configured as the password.

After you log in, navigate to **`admin` -> `Profile`**. Input your API key as the current password and type in a new password in the new password field. Save your changes.

:::danger

Create a new password right away and do not share your API key (or password) with anyone unless you absolutely, 100%, trust them!

:::

## Support

- You can also reach us using [Discord](https://discord.gg/tVsPTHWTtr) for real-time feedback and support
- If you found a bug in our chart, open a Github [issue](https://github.com/truecharts/apps/issues/new/choose)
- For further information on operating **Notifiarr** itself, start with their [Quick Start Guide](https://notifiarr.wiki/en/QuickStart).
