---
title: Installation Notes
---

In case you want to use `darktable` and it's features inside the app,
you have to run the app as `root` (`0`).

Under `Security and Permissions`

- Check `Show Advanced Security Settings`
  - Uncheck `ReadOnly Root Filesystem`

Under `Pod Security Context`

- runAsUser: `0`
- runAsGroup: `0`
