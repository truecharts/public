# Input Validation

__`Domain(s) using collabora`__
Accepted formats are:

- Single domain (eg. `cloud.mydomain.com`)
- Multiple domains (eg. `cloud.mydomain.com|nextcloud.mydomain.com`) - Each domain is separated with `|`

Regex used to match those: `^([a-z]{1,}\.[a-z]{1,}\.[a-z]{1,})((\|[a-z]{1,}\.[a-z]{1,}\.[a-z]{1,}))*$`
You can try live [here](https://regex101.com/r/AQFh2g/1)

__`Server Name`__
Accepted formats are:

- Single domain (eg. `collabora.mydomain.com`)

Regex used to match this: `^([a-z]{1,}\.[a-z]{1,}\.[a-z]{1,})$`
You can try live [here](https://regex101.com/r/xCjpW7/1)

__`Password for WebUI`__
Accepted formats are:

- Letters, Numbers, Symbols, Minimum 8 characters (eg. `dg523$*a`) - It accepts `a-z`, `A-Z`, `0-9` and `!@#$%^&*?`

Regex used to match those: `[a-zA-Z0-9!@#$%^&*?]{8,}`
You can try live [here](https://regex101.com/r/ef3V88/1)

---

_If you find a field that you think it needs validation, please open an issue on github_
