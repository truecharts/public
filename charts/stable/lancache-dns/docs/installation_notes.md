---
title: Installation Notes
---

- Set `USE GENERIC CACHE` to **true** if you are running `lancache-monolithic`.
- Set `LANCACHE IP` to the local IP that `lancache-monolithic` runs on.
- You can leave `Disable Cache DNS Resolvers` as disabled to cache all supported game servers or choose from the small list to not cache. you can add more by setting the environment variable of DISABLE\_${SERVICE}=true to `Configure Extra Environment Variables`.
