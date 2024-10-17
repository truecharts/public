---
title: Adding Ingress
---

## What is ingress?

Ingress is a way to define "routes" from a domain name, through an "ingress controller", to the application running in a chart.
Simply put, they specify reverse proxy configuration for a special reverse proxy called "ingress controller".

## Requirements

Before setting up ingress, we advise you to have an ingress controller already set-up. Our recommended ingress controller is [Traefik](https://github.com/traefik/traefik).

## How to Setup

To setup ingress, add the following minimal section to the values.yaml manually, updating the required rows and adapting where needed:

```yaml
ingress:
  main:
    enabled: true
    hosts:
      - host: chart-example.local
    tls:
      - hosts:
         - chart-example.local
```

This can be expanded by adding "integrations" with cert-manager, and/or homepage, for example:

```yaml
ingress:
  main:
    enabled: true
    hosts:
      - host: chart-example.local
    tls:
      - hosts:
          - chart-example.local
        secretName: chart-example-tls
    integrations:
      certManager:
        enabled: false
        certificateIssuer: ""
      homepage:
        enabled: false
        name: ""
        description: ""
        group: ""
        icon: ""
        widget:
          type: ""
          url: ""
          custom:
            key: value
          customkv:
            - key: some key
              value: some value
```

In some cases, an ingress might already been partly defined. When that's the case, please merge the above settings with the already defined ingresses.

## More info

For more info, checkout the common-chart [ingress options](/common/ingress/)
