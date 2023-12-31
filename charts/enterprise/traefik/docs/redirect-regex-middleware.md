---
title: Redirect Regex
---

The Redirect Regex middleware redirects a request using regex matching and replacement.

In the `Regex` field enter the capturing regex expression
In the `Replacement` enter the URL to redirect to.

## Creating the middleware on traefik

Edit your existing traefik install (or install fresh if you don't have it installed)

- Scroll down to `redirectRegex`
- Click <kbd>Add</kbd>
- Name: `guacamole-redirect` (Any name you want, remember it, you will need it later)
- Regex: `^https://remote\.domain\.com/?$`
- Replacement: `https://remote.domain.com/guacamole`
- Check `Permanent`
- Click <kbd>Save</kbd>

  ![traefik-regex-redirect-fields](./img/traefik-regex-redirect-fields.png)

This will capture `https://remote.domain.com` or `https://remote.domain.com/`
and redirect it to `https://remote.domain.com/guacamole`

## Applying the regex redirect middleware to the app

Edit your existing _App_, in this example we will use `guacamole-client`.

- Scroll down to `Traefik MIddlewares` (Remember, you need to have `ingress` enabled)
- Click <kbd>Add</kbd>
- Name: `guacamole-redirect` (Replace with the name you gave to your middleware on the previous step)
- Click <kbd>Save</kbd>

  ![traefik-regex-redirect-app](./img/traefik-regex-redirect-app.png)

You are ready!
