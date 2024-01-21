---
title: TT-RSS Installation Notes
---

#### Credentials

TT-RSS will create a user (named `admin`) on first run. If no password is given in the *TTRSS Admin User Pass* field, then a password is automatically generated and printed to the app's logs. Otherwise the password entered in that field will be used.

Be warned that if the app restarts before collecting the automatically generated password, it may be rotated out of the logs and the app will require re-installing to set and print a new password.

To reach the automatically generated password, select the tt-rss app in TrueNAS's Applications list. Under Workloads click the View Logs icon beside the tt-rss container. In the dialog that pops up, there will be several containers, look for the one without `-cnpg`, `-nginx`, or `-updater` in the name. The password log section will look like this:

```
*****************************************************************************
* Setting initial built-in admin user password to '$RANDOM_PASS'        *
* If you want to set it manually, use ADMIN_USER_PASS environment variable. *
*****************************************************************************
```

### Configuring path and URL

TT-RSS has defaults which expect it to be installed and reachable at a url ending in `/tt-rss/` (e.g. https://rss.me.com/tt-rss/). This SCALE app comes with adjusted defaults that eliminate this ending portion (e.g. https://rss.me.com/).

If an advanced user wishes to alter the app path, use the *App Web Root Path* and *App Base Path* fields to do so. Read more here: https://tt-rss.org/wiki/InstallationNotes#how-do-i-make-it-run-without-tt-rss-in-the-url-i.e.-at-website-root

#### Install to subdomain with traefik + ingress

- Set `TTRSS Self URL Path` to `https://subdomain.scale_domain.tld/`.
  - Configure ingress on the app

#### Install to IP address

- Set `TTRSS Self URL Path` to `http://SCALE_IP:APP_PORT/`.
  - Ensure the app's port is set to LoadBalancer to allow external browsers to reach it.

#### Resolver - Advanced Usage

:::danger TrueNAS DNS IP
Changing the `Cluster DNS IP` address in TrueNAS SCALE will **DELETE your APPS and APP DATA!**

*ANY* change should only be made to the `TTRSS DNS Resolver` field in the app's edit dialog, and no change should be needed for regular app usage.
:::

TT-RSS sets the default nginx resolver to 127.0.0.11, which appears not to work on SCALE apps. The resolver for this app has been altered to TrueNAS SCALE's default of `172.17.0.10`. If a user has a different SCALE DNS IP, it must be reflected here in the app's configuration.

Check the SCALE DNS IP by navigating to `Applications` > `Settings` (dropdown) > `Advanced Settings`. A sidebar titled "Kubernetes Settings" will appear, and toward the bottom is `Cluster DNS IP` *(Do not change! See warning above!)* with the IP address that should match this app's `TTRSS DNS Resolver` field.
