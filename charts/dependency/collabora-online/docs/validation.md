# Input Validation

**`Server Name`**
Accepted formats are:

- Single FQDN (eg. `collabora.mydomain.com` or `mydomain.com`)
- Single IP (eg. `10.10.10.11`)

_Same rules apply for FQDN as in the section above_

Regex used to match this: `^((([a-z\d](-?[a-z\d]){0,62})\.)*(([a-z\d](-?[a-z\d]){0,62})\.)([a-z](-?[a-z\d]){1,62})|((\d{1,3}\.){3}\d{1,3}))$`
You can try live [here](https://regex101.com/r/mICKDp/1)

**`Password for WebUI`**
Accepted formats are:

- Letters, Numbers, Symbols, Minimum 8 characters (eg. `dg523$*a`) - It accepts `a-z`, `A-Z`, `0-9` and `!@#$%^&*?`

Regex used to match those: `[a-zA-Z0-9!@#$%^&*?]{8,}`
You can try live [here](https://regex101.com/r/ef3V88/1)

---

_If you find a field that you think it needs validation, please open an issue on github_
