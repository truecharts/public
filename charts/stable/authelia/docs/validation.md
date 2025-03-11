---
title: Input Validation
---

**`Default Redirection URL`**

Accepts:

- `https://`
- DNS host
- Characters (`0-9`, `a-z`, `A-Z`, `-`, `.`)

Accepted formats are:

- `https://dnshost`
- `https://DNSHOST`
- `https://DNS-HOST`
- `https://dns-host`

Regex used to match this: `^https?:\/\/(.*)`
You can try live [here](https://regex101.com/r/zFt9zy/1)

---

_If you find a field that you think it needs validation, please open an issue on github_
