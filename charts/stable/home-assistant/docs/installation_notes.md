---
title: Installation Notes
---

## General

This chart does not need any special steps to be installed and can be installed normally, following the general guideliness for TrueCharts charts. This installation notes are only special steps if need.

## Add Code Server

-1. [Addons](https://truecharts.org/manual/SCALE/options/add-ons/#addons-1)
  1.1 Go to [codeserver](http://IP_Address:Port) 

## Add Media

-1.[adding-additional-app-storage](https://truecharts.org/manual/SCALE/guides/add-storage/#adding-additional-app-storage)
  1.1 Mount Path = /media
-2. [additional media folders](https://www.home-assistant.io/integrations/media_source/).
  2.1 homeassistant:
        media_dirs:
        local: /media

## Installed HACS

-1. HACS is pre-installed skip the download script setup for HACS.
  1.1 Start here [Initial Configuration](https://hacs.xyz/docs/configuration/basic)