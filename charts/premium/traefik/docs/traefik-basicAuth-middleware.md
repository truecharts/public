---
title: Add Traefik Basic Auth to Apps
---

Our `traefik` chart has the ability to add various `middlewares` to the chart that can add extra functionality to your setup. In this guide we'll go over setting up the `Basic Auth` traefik middleware.

## Installation

Edit your traefik `values.yaml`.

```yaml
// values.yaml
middlewares:
  basicAuth:
  - name: basic
    users:
      - username: someuser
        password: somepassword
      - username: seconduser
        password: secondpassword
```

- Add as name users as necessary, choosing a specific `Username` and `Password` for each user.

## Adding it to Apps using Ingress

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
          - name: basic
            namespace: traefik
      certManager:
        enabled: true
        certificateIssuer: domain-0-le-prod
    hosts:
      - host: app.domain.tld
```

## Verify Authentication

Once the `basicAuth` is setup, please visit the `URL` that you configured the `Ingress` for. If everything is setup correctly you should see the Pop-Up below.

![BasicAuthWorking](./img/BasicAuthWorking.png)

## Support

- If you need more help you can also reach us using [Discord](https://discord.gg/tVsPTHWTtr) for real-time feedback and support.
