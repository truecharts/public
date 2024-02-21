---
title: Installation Notes
---

## Prerequisites

1. The cloudnative-pg operator is required from the operator train. More information can be
   found on our [getting started guide](https://truecharts.org/manual/SCALE/guides/getting-started#cnpg-operator-installation-and-migration-guide-for-older-users).
2. Ingress is required to be configured. The preferred and supported method for ingress is Traefik. More information can be
   found on our [getting started guide](https://truecharts.org/manual/SCALE/guides/getting-started#traefik-installation-for-ingress--reverse-proxy-support-with-truecharts-apps).

:::caution SNAPSHOT DIRECTORY VISIBILITY

Nextcloud installation will fail if the application or user data datasets have Snapshot Directory set to Visible (Invisible by default). Return this setting to default prior to installation.

:::

## User Data Permissions

If you plan to use HostPath or NFS to store user data then the permissions for the dataset will need to be set as shown below.

![userdata-perms](./img/userdata-perms.png)

## Nextcloud Configurations

### Required

The following configurations must be set during initially setup for nextcloud to deploy.

1. Initial Admin Username
2. Initial Admin Password
3. Default Phone Region (if you are unsure about your region, you can find your code for your
   region in this [wiki](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#Officially_assigned_code_elements))

### Optional Addons

1. Notify Push (Allows Nextcloud to notify clients of changes, instead of clients having to poll.
   A Notify Push container will be deployed automatically). This is highly recommended to keep enabled.
2. ClamAV (Anti-virus for nextcloud, keep in mind that only scans files that Nextcloud posts to it's endpoint.
   A Clam AV container will be deployed automatically.
3. Collabora (Document editor for Nextcloud. A Collabora container will be deployed automatically.
4. Only Office (document editor for Nextcloud, this does **NOT** deploy the Only Office container.
   You will need to have a separate installation.

### Storage

You can change the User Data Storage option to your preference here if you previously setup the proper dataset permissions. All other Storage should remain the default of PVC.
