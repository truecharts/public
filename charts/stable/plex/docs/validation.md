---
title: Input Validation
---

**`Advertise IP`**

Accepts:

- Empty string
- `http://` or `https://`
- IP or DNS host
- Characters (`0-9`, `a-z`, `A-Z`, `-`, `.`)
- Port is optional
- `,` Separated

Accepted formats are:

- `https://192.168.1.100:32400`
- `https://192.168.1.100:32400`
- `http://dnshost:32400`
- `https://dnshost:32400`
- `https://dnshost`
- `https://DNSHOST`
- `https://DNS-HOST`
- `https://dns-host`
- `https://dnshost,http://192.168.1.100:32400`

Regex used to match this: `^$|^(http(s)?:\/\/([a-zA-Z0-9.-]*)(:\d{0,5})?,?)*$`
You can try live [here](https://regex101.com/r/zay2xO/1)

---

_If you find a field that you think it needs validation, please open an issue on github_
