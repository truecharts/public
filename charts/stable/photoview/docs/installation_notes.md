---
title: Installation Notes
---

In case you want to use `darktable` and it's features inside the app,
you have to run the app as `root`.

``` yaml
securityContext:
  container:
    readOnlyRootFilesystem: false
    runAsGroup: 0
    runAsUser: 0
```
