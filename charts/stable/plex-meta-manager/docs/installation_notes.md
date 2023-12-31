---
title: Installation Notes
---

## Setup ENV variables

- Set `PMM_RUN` as **true** to run immediately, bypassing `PMM_TIME`

However disabling `PMM_RUN` will show the options to set a time for `PMM_TIME` with a comma-separated
list in HH:MM format(ex: **06:00,18:00**) and `PMM_NO_COUNTDOWN` set to **true** to run without displaying a
countdown to the next scheduled run

Additional env are available [here](https://metamanager.wiki/en/latest/home/environmental.html#run-commands-environment-variables)

## Configuration file setup

An example [config.yml](https://metamanager.wiki/en/latest/config/configuration.html#configuration-file-walkthrough):
