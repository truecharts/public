---
title: Installation Notes
---

To use this to protect multiple apps setup the traefik middleware "modsecurity".

- Name
- ModSecurity Url
- timeout Millis
- maxBody Size

If you do not plan to use traefik or only want to protect a single app, just add a custom variable "BACKEND" in Extra Environment Variables.
The value can be `<http://ip:port>` or `<http://$NAME.ix-$NAME.svc.cluster.local:PORT>`.
