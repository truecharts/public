---
title: clusterissuer Setup Guide
---

This guide will walk you through setting up `clusterissuer`, certificate management for Kubernetes.

## Prerequisites

- [Cert-Mananger[(/guides/#cert-manager) and [Prometheus(-crds)]((/guides/#prometheus)

:::caution[DNS]

As part of the DNS verification process cert-manager will connect to authoritative nameservers to validate the DNS ACME entry. Any firewall or router rules blocking or modifying DNS traffic will cause this process to fail and prevent the issuance of certificates. Ensure no firewall or router rules are in place blocking or modifying DNS traffic to assigned authoritative nameservers. Below is an example of cloudflare assigned authoritative nameservers (these nameservers are unique to each user).

![cloudflare-nameservers](./img/cloudflare-nameservers.png)

:::

## Configure ACME Issuer

You can setup multiple domains and/or DNS providers with a single `clusterissuer` app.

### Cloudflare DNS Provider

#### Create a Cloudflare API token

Login to Cloudflare dashboard and go to the [Cloudflare API Tokens](https://dash.cloudflare.com/profile/api-tokens) page. Select Edit Zone DNS template.

![clusterissuer app card](./img/cf-apitokens-template.png)

The recommended `API Token` permissions are below:
![clusterissuer app card](./img/cf-apitokens-perms.png)

#### Cloudflare ACME Issuer Settings

```yaml
// values.yaml
clusterIssuer:
  ACME:
    - name: domain-0-le-prod
      # Used for both logging in to the DNS provider AND ACME registration
      email: "${DOMAIN_0_EMAIL}"
      server: 'https://acme-staging-v02.api.letsencrypt.org/directory'
      type: "cloudflare"
      # Obtained using instructions above
      cfapitoken: sometoken
```

More detail can be found on the upstream [Cert-Manager](https://cert-manager.io/) documentation for [Cloudflare](https://cert-manager.io/docs/configuration/acme/dns01/cloudflare/).

### Route 53 DNS Provider

To be completed

### Akamai DNS Provider

To be completed

### Digital Ocean DNS Provider

To be completed

## Configure Ingress using clusterissuer

Here's an example on how to add ingress to a chart with clusterissuer for a single domain only.

```yaml
// values.yaml
ingress:
  main:
    enabled: true
    integrations:
      traefik:
        enabled: true
        middlewares:
          - name: auth
            namespace: traefik
      certManager:
        enabled: true
        certificateIssuer: domain-0-le-prod
    hosts:
      - host: librespeed.example.com
```

## Verifying clusterissuer is working

Once installed using the Ingress settings above, you can see the `kubectl events` for the chart in question to pull the certificate and issue the challenge directly. See the example below:

Renewals are handled automatically by `clusterissuer`.
