---
title: Installation Notes
---

## Requirements

1. The Cloudnative-PG operator is required from the `system` train. More information can be found on our [getting started guide](/scale/#prometheus-and-cnpg-system-app-installations)

2. Ingress is required to be configured. The preferred and supported method for ingress is Traefik. More information can be
   found on our [getting started guide](/scale/#traefik-installation-for-ingress--reverse-proxy-support-with-truecharts-apps).

:::caution[SNAPSHOT DIRECTORY VISIBILITY]

Nextcloud installation will fail if the application or user data datasets have Snapshot Directory set to Visible (invisible by default). Return this setting to default prior to installation.

:::

## User Data Permissions

If you plan to use HostPath or NFS to store user data then the permissions for the dataset will need to be set as shown below.

![userdata-perms](./img/userdata-perms.png)

## Nextcloud Configurations

### Required

The following configurations must be set during initial setup in order for Nextcloud to deploy.

1. An initial admin username needs to be set

2. An initial admin password needs to be set. 

3. Default phone region needs to be set (if you are unsure about your region, you can find your code for your region in this [wiki](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#Officially_assigned_code_elements))

:::caution[Password Requirements]

Due to limitations when converting YAML to JSON, the passwords used with Nextcloud for admin and Postgres must **only** start with a letter or number. If you attempt to use a password that starts with a symbol, e.g. '%', Nextcloud will fail to install as it will be unable to convert the YAML to JSON.

:::

### Optional Addons

1. Notify Push (Allows Nextcloud to notify clients of changes, instead of clients having to poll. A Notify Push container will be deployed automatically). This is highly recommended to keep enabled.

2. ClamAV (Anti-virus for Nextcloud, keep in mind that only scans files that Nextcloud posts to its endpoint. A Clam AV container will be deployed automatically.

3. Collabora (document editor for Nextcloud. A Collabora container will be deployed automatically.

4. Only Office (document editor for Nextcloud, this does **NOT** deploy the Only Office container.
   You will need to have a separate installation.

### Storage

You can change the User Data Storage option to your preference here if you previously setup the proper dataset permissions. All other Storage should remain the default of PVC.
