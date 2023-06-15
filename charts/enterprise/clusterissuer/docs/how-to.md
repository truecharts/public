# clusterissuer Setup Guide

This guide will walk you through setting up `clusterissuer`, certificate management for Kubernetes.

## Prerequisites

Ensure you have the `enterprise` train enabled for `TrueCharts` as discussed [here](https://truecharts.org/manual/SCALE/guides/getting-started/#adding-truecharts).

Ensure you have traefik installed, required for Ingress.

Search for clusterissuer in the `Apps` menu | `Available Applications` tab and click **Install**.

## Cloudflare DNS-Provider

You can setup multiple domains with a single `clusterissuer` app, all you have to do is either add the global API key (**not recommended**) or `Add` multiple `ACME Issuer` entries for each domain and create an API token for each at [Cloudflare API Tokens](https://dash.cloudflare.com/profile/api-tokens). The recommended settings for creating `API Tokens` for use with `clusterissuer` can be found on the upstream [Cert-Manager](https://cert-manager.io/) documentation for [Cloudflare](https://cert-manager.io/docs/configuration/acme/dns01/cloudflare/).

- Give the certificate a name (eg domain or "maincert", etc).
- Select the correct provider, for example `Cloudflare`.
- Set **Server** to **Letsencrypt-Production**.
- Set Email to the account email.
- Optionally set Cloudflare API key (**not recommended**)
- Set the Cloudflare API Token to the one created earlier.

![clusterissuer edit dialog](img/clusterissuer1.png)

## clusterissuer App

:::note

It is by design that the app does not run, there are no events, no logs and no shell.

:::

![clusterissuer app card](img/clusterissuer2.png)

## How to Add Ingress to Apps with clusterissuer

Here's an example on how to add ingress to an app with clusterissuer for a single domain only.

Add the name of the `ACME Issuer` into `Cert-Manager clusterIssuer`

:::warning

Do **NOT** use this combined with the `TLS-Settings`.

:::

![how to add ingress using clusterissuer ](img/clusterissuer3.png)

If you want to support multiple domains, use the `TLS-Settings` option to create each one, basically an extra step each time.

## Verifying clusterissuer is working

Once installed using the Ingress settings above, you can see the `Application Events` for the app in question to pull the certificate and issue the challenge directly. See the example below:

![clusterissuer4](img/clusterissuer4.png)
![clusterissuer5](img/clusterissuer5.png)

All is automated by `clusterissuer`
