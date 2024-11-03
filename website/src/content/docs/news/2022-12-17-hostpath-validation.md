---
slug: "news/hostpath-validation"
title: "TrueNAS SCALE 22.12: hostPath Validation"
authors: [ornias]
date: 2022-12-17
tags:
  - "2022"
---

We are excited to finally be able to work with TrueNAS SCALE version 22.12 "BlueFin," however this version includes a new feature called "hostPath validation." This feature is designed to ensure the stability and security of TrueNAS SCALE systems by preventing the use of any datasets for apps where that dataset is also used for shares.

This safety check makes sure apps and sharing services (SMB, NFS, etc) do not use the same data. This is done to avoid permissions issues, as there are a lot of apps that change permissions without giving the user a warning, or just plain do not work with ACL's.

While this feature is an important security measure, it can also be a source of frustration for some users who may be using datasets for both apps and shares. If you are encountering issues with "hostPath validation", such as Apps being "stuck on deploying" after update, there are three potential solutions you can consider:

1. Disable "hostPath validation." If you disable "hostPath validation," TrueCharts will not provide support on things that involve storage. If you disable "hostPath validation" and have an issue with the app, your configuration screenshots must not have any hostPath storage defined.

2. Keeping "hostPath validation" enabled and disable shares on any datasets that are also used with apps. TrueCharts will continue to provide support for things that involve storage.

3. Keeping "hostPath validation" enabled and keep shares enabled on any datasets that are also used with apps. Instead of hostPath, you can mount the dataset using the [NFS option on all TrueCharts apps](/.

The Option to disable "hostPath validation" can be found in Apps -> Settings -> Advanced Settings -> Enable Host Path Safety Checks

We hope these suggestions are helpful in resolving any issues you may be experiencing with "hostPath validation" on TrueNAS SCALE version 22.12 "BlueFin".
