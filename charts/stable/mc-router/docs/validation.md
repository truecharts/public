---
title: Input Validation
---

**`Domain and Minecraft Service`**

Accepts:

- domain=service:port
- IP or DNS host
- Characters (`0-9`, `a-z`, `A-Z`, `-`, `.`)
- Port

Accepted formats are:

- `minecraft.local=minecraft-java.ix-minecraft-java.svc.cluster.local:25565`
- `minecraft.local=localhost:25565`
- `minecraft.local=0.0.0.0:25565`

Regex used to match this: `^$|^(http(s)?:\/\/([a-zA-Z0-9.-]*)(:\d{0,5})?,?)*$`
You can try live [here](https://regex101.com/r/u2ifZm/1)

---

_If you find a field that you think it needs validation, please open an issue on github_
