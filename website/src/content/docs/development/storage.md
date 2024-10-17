---
title: Storage
---

This article serves as a development extension to the storage article available [here](https://wiki.truecharts.org/general/storage/)

## Storage and Common-Chart

For all these storage solutions we require the common-chart to be added to the App.
The Common-Chart handles both the connection/addition of storage to the container and spinning up special k8s jobs to fix the permissions if requested for the Custom storage.

### Unlimited Custom Storage Mounts

We support presenting the user with a "Do it yourself" style list, in which the user can add unlimited paths on the host system to mount.
It should always be included in any App, to give users the option to customize things however they like.
