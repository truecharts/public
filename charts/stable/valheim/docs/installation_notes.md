---
title: Installation Notes
---

Valheim app does not support having different port numbers for `port` and `targetPort`.
Setting `port` will set the same port number to `targetPort` and it's Environmental Variable.
e.g `Status HTTP Port`, `Supervisor HTTP Port`, `Server Port`

Also, services named `valheim1`, `valheim2`, `valheim3`, should be continuous port numbers. eg 2456, 2457, 2458.
You **can't** skip a number!
