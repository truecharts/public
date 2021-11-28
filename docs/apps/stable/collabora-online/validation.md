# Input Validation

__`Domain(s) using collabora`__
Accepted formats are:

- Single FQDN (eg. `cloud.mydomain.com` or `mydomain.com`)
- Multiple FQDN (eg. `cloud.mydomain.com|nextcloud.mydomain.com` or `mydomain.com|cname.mydomain.com`) - Each FQDN is separated with `|`
- Single IP's (eg. `10.10.10.11`)
- Multiple IP's (eg. `10.10.10.11|10.10.10.2`) - Each IP is separated with `|`
- Mixed FQDN and IP's (eg. `10.10.10.11|domain.com` or `domain.com|10.10.10.11`) - Each FQDN or IP is separated with `|`

Each FQDN is split into parts
__Hostname (`cname`.domain.com)__ _Optional_
* Can have from 1 up to 127 levels deep cnames.
* Can contain [0-9], [a-z] and `-`.
* Must be at least 1 char and no longer than 63 chars.
* Must start with [a-z], [0-9].
* Must NOT end with `-`.
__Domain (cname.`domain`.com)__
* Can contain [0-9], [a-z] and `-`.
* Must be at least 1 chars and no longer than 63 chars.
* Must start with [a-z], [0-9].
* Must NOT end with `-`.
__Top-Level-Domains (cname.domain.`com`)__
* Can contain [0-9], [a-z] and `-`.
* Must be at least 2 chars and no longer than 63 chars.
* Must start with [a-z].
* Must NOT end with `-`.

Regex used to match those: `^((([a-z\d](-?[a-z\d]){0,62})\.)*(([a-z\d](-?[a-z\d]){0,62})\.)([a-z](-?[a-z\d]){1,62})|((\d{1,3}\.){3}\d{1,3}))((\|((([a-z\d](-?[a-z\d]){0,62})\.)*(([a-z\d](-?[a-z\d]){0,62})\.)([a-z](-?[a-z\d]){1,62})|((\d{1,3}\.){3}\d{1,3})))*)$`
You can try live [here](https://regex101.com/r/ymDFln/1)

__`Server Name`__
Accepted formats are:

- Single FQDN (eg. `collabora.mydomain.com` or `mydomain.com`)
- Single IP (eg. `10.10.10.11`)

_Same rules apply for FQDN as in the section above_

Regex used to match this: `^((([a-z\d](-?[a-z\d]){0,62})\.)*(([a-z\d](-?[a-z\d]){0,62})\.)([a-z](-?[a-z\d]){1,62})|((\d{1,3}\.){3}\d{1,3}))$`
You can try live [here](https://regex101.com/r/mICKDp/1)

__`Password for WebUI`__
Accepted formats are:

- Letters, Numbers, Symbols, Minimum 8 characters (eg. `dg523$*a`) - It accepts `a-z`, `A-Z`, `0-9` and `!@#$%^&*?`

Regex used to match those: `[a-zA-Z0-9!@#$%^&*?]{8,}`
You can try live [here](https://regex101.com/r/ef3V88/1)

---

_If you find a field that you think it needs validation, please open an issue on github_
