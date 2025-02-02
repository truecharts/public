---
title: Theme Park
---

Theme park is a middleware to inject [supported stylesheets (css)](https://docs.theme-park.dev/theme-options)
into [supported apps](https://docs.theme-park.dev/themes).

So let's see how to do that.

Note that this will only work on apps you have enabled traefik intergration, and only when accessing them via the URL.
Will NOT work if you access them via `IP:PORT`.

## Creating the middleware on traefik

Edit your traefik `values.yaml`.

```yaml
// values.yaml
middlewares:
  themePark:
  - name: guactheme
    app: guacamole
    theme: plex
    baseUrl: https://theme-park.dev
```

> Keep in mind that if you decide to use a self hosted theme provider, it will need to have enabled ingress.
> Also use the external URL, not the internal, as the client will need to access that theme provider to fetch the
> stylesheets.

## Applying the theme to the app

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
          - name: guactheme
            namespace: traefik
      certManager:
        enabled: true
        certificateIssuer: domain-0-le-prod
    hosts:
      - host: remote.domain.com
```

|                         Before                          |                         After                         |
| :-----------------------------------------------------: | :---------------------------------------------------: |
| ![traefik-theme-before](./img/traefik-theme-before.png) | ![traefik-theme-after](./img/traefik-theme-after.png) |
