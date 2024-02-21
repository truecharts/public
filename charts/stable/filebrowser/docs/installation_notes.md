---
title: Installation notes
---

## Credentials

- **Default Email**: `admin`
- **Default Password**: `admin`

## Base Url

- Leave `BASEURL` field empty if you want ingress for the chart, otherwise the page loops on the loading screen

## Storage Access

- Mount Hostpath to `App Data Storage` and point it to the location you want to access from filebrowser

## Additional App Storage

- To add `Additional App Storage` add `/data` to the beginning of the `Mount Path`. For example, if you want to add a mount for `/photos` the `Mount Path` would be `/data/photos`.
