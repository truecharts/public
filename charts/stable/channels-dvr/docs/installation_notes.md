---
title: Channels DVR Installation Notes
---

:::danger[TV Everywhere Permissions]

If using TV Everywhere, `runAsUser` and `runAsGroup` must both be changed to `0` and `readOnlyRootFilesystem` must be changed to `false`.

:::

## Ingress

You cannot use Ingress during the initial setup. The Channels DVR Server web interface must be accessed using the TrueNAS server IP and Channels DVR Server port (defaults to 8089).

After initial setup, ingress can be used to access the Channels DVR Server web interface.

## Login

During initial setup on the Channels DVR Server web interface, you will need to login to your Channels DVR website account as described here: [https://getchannels.com/docs/channels-dvr-server/quick-guide/installation-setup/#log-in](https://getchannels.com/docs/channels-dvr-server/quick-guide/installation-setup/#log-in).

After you login on the Channels DVR website, you will be redirected back to your local Channels DVR Server web interface. However, the redirect will use the internal Kubernetes IP in the URL so it will not work. Simply change the IP in the URL to the IP of you TrueNAS server leaving the path and query parameters unmodified.
