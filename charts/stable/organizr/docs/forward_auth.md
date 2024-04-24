---
title: Organizr Forward Auth Setup Guide
---

Basic setup guide for enabling Organizr authentication on your apps using Traefik forwardAuth.

## Requirements

- Organizr TrueCharts App
- Traefik TrueCharts App

## Prerequisites

This guide assumes you're using Traefik as your Reverse Proxy / Ingress provider and have through the configuration listed in our
[Quick-Start guides](/scale/) and/or the [Traefik documents](/charts/premium/traefik/how-to).
Please ensure that you can access your domain properly with Ingress before attempting any further steps.

## Organizr App Setup

All of the defaults are fine to start off, however `ingress` must be set if you wish to use `organizr` with `traefik`.

In this guide the app name is `organizr` and ingress is configured as `organizr.example.com`

**Ingress Example**

![organizr-ingress-section](./img/organizr-ingress-section.png)

(also complete the TLS section for ingress configuration using the same hostname as above)

## Organizr GUI Setup

Once the app is deployed, complete the standard installation steps until you get to the Organizr settings page.

### Review Pre-defined Groups

Goto Organizr Settings -> User Management -> Manage Groups

No changes needed here for now unless you want to create a custom group
![Manage-Groups](./img/organizr-groups.png)

### Configure Traefik Redirect

Goto Organizr Settings -> Main -> Security

- Set `Enable Traefik Auth Redirect` to on
- Set `Traefik Domain for Return Override` to `https://organizr.example.com` (this should match the address you defined in the Organizr app ingress section)

![organizr-gui-traefik-redirect](./img/organizr-gui-traefik-redirect.png)

## Traefik ForwardAuth Setup

Once Organizr app is up and running, you must create `forwardAuth` middleware entries inside Traefik in order to use Organizr's authentication on your apps.

We will use the Organizr user groups that map to specific forwardAuth URLs.

The below table shows the example forwardAuth entries that correspond to the user groups in Organizr.
The URLs for these entries use the kubernetes internal DNS address & default port (`10022`) for your Organizr app. You can name the forwardAuth entries whatever you like.

| forwardAuth Name                      | forwardAuth Address                                                         |                              screenshot                               |
| :------------------------------------ | :-------------------------------------------------------------------------- | :-------------------------------------------------------------------: |
| `organizr-admin`                      | `http://organizr.ix-organizr.svc.cluster.local:10022/api/v2/auth?group=0`   |  ![Organizr-admin-forwardAuth](./img/organizr-admin-forwardAuth.png)  |
| `organizr-guest` (optional)           | `http://organizr.ix-organizr.svc.cluster.local:10022/api/v2/auth?group=999` |  ![Organizr-guest-forwardAuth](./img/organizr-guest-forwardAuth.png)  |
| `organizr-custom5` (optional, custom) | `http://organizr.ix-organizr.svc.cluster.local:10022/api/v2/auth?group=5`   | ![Organizr-custom-forwardAuth](./img/organizr-custom-forwardAuth.png) |

See Organizr [documentation](https://docs.organizr.app/features/server-authentication#using-the-organizr-authorization-api) on "Server Authentication"
for more details on the predefined groups and their corresponding URL pattern.

### Add Traefik forwardAuth to Apps

Once that is done all you need to add the `middleware` to your apps under the `Ingress section`, corresponding to the level of
permissions the app's user should have to access it. Example below uses `organizr-admin`.

![organizr-traefik-middleware](./img/organizr-traefik-middleware.png)

## Verify it works

Visit the app's `URL` where you set ingress + forwardAuth middleware. You will see the following organizr login page:

![organizr-authentication-page](./img/organizr-authentication-page.png)

## Optional: Enable Plex OAuth (or LDAP backend service)

Additionally Organizr supports enabling plex oauth or LDAP as your authentication backend. If you have users already provisioned
in Plex, you can point to your plex server for OAuth.

![organizr-plex-oauth](./img/organizr-plex-oauth.png)

When Plex OAuth is enabled, users will see the option on the Organizr authentication page:

![organizr-plex-authentication-page](./img/organizr-plex-authentication-page.png)

See Organizr [documentation](https://docs.organizr.app/features/authentication-backends/plex-backend) on "Plex Authentication Backend" for more details.
