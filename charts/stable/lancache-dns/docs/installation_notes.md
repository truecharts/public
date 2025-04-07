---
title: Installation Notes
---

All is configured via Environment Variables in the `.Values`.

If you are using a single monolithic instance:
- Set `USE_GENERIC_CACHE` to **true** if you are running `single monolithic instance`.
- Set `LANCACHE_IP` to the local IP that `lancache-monolithic` runs on.
- If you want to disable certain supported game servers, this can be via the Environment Variables.
