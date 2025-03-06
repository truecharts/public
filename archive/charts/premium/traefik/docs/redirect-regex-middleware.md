---
title: Redirect Regex
---

The Redirect Regex middleware redirects a request using regex matching and replacement.

## Creating the middleware on traefik

Edit your traefik `values.yaml`.

```yaml
// values.yaml
middlewares:
  redirectRegex:
  - name: guacamole-redirect
    regex: ^https://remote\.domain\.com/?$
    replacement: https://remote.domain.com/guacamole
    permanent: true
```

This will capture `https://remote.domain.com` or `https://remote.domain.com/`
and redirect it to `https://remote.domain.com/guacamole`

## Applying the regex redirect middleware to the app

Edit your app `values.yaml`.

```yaml
// values.yaml
ingress:
  main:
    enabled: true
    integrations:
      traefik:
        enabled: true
        middlewares:
          - name: guacamole-redirect
            namespace: traefik
      certManager:
        enabled: true
        certificateIssuer: domain-0-le-prod
    hosts:
      - host: remote.domain.com
```
