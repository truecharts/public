---
title: Cluster Certificates Setup Guide
---

This guide will walk you through setting up and using `cluster certificates`.

:::note

Since this is an advanced feature, it is not covered by Truecharts support.

:::

## Prerequisites

- Ensure you have completed the [clusterissuer Setup Guide](how-to)
- Install the `kubernetes-reflector` app from the `premium` train

## Creating a cluster certificate

In the clusterissuer app settings create a new "Cluster-Wide certificate". As with a [single domain certificate](how-to#configure-ingress-using-clusterissuer), input a cert-manager issuer (for example an ACME issuer you configured previously), a list of hosts for which the certificate is valid (you can use wildcards), and a name you will use to reference it.

:::note

In order for an ACME issuer to issue a wildcard certificate, you need to have a DNS01 challenge solver configured.

:::

```yaml
// values.yaml
clusterCertificates:
  replicationNamespaces: '.*'
  certificates:
    - name: domain-0-wildcard
      enabled: true
      # name of previously configured single domain certificate
      certificateIssuer: domain-0-le-prod
      hosts:
        - example.com
        - '*.example.com
```

After creating the cluster certificate, verify it is working by checking the `kubectl events` for the `clusterissuer` chart (see [how to verify a single app certificate is working](how-to#verifying-clusterissuer-is-working) for more information).

## Using a cluster certificate

After you have verified the certificate was created successfully, edit the `values.yaml` of the chart you wish to use it for.

:::note

In order for your cluster certificate to show up as valid, the certificate hosts it is used for must match the ones specified when creating it in the clusterissuer app settings. For example, in this case we configure the certificate host `jellyfin.example.com`, which matches the configured wildcard certificate host (`*.example.com`).

:::

```yaml
// values.yaml
ingress:
  main:
    enabled: true
    integrations:
      traefik:
        enabled: true
    tls:
      - hosts:
          - app.example.com
        clusterIssuer: domain-0-wildcard
    hosts:
      - host: app.example.com
```
