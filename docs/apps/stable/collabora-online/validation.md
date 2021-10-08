# Input Validation

__`Domain(s) using collabora`__
Accepted formats are:

- Single FQDN (eg. `cloud.mydomain.com` or `mydomain.com`)
- Multiple FQDN (eg. `cloud.mydomain.com|nextcloud.mydomain.com` or `mydomain.com|cname.mydomain.com`) - Each FQDN is separated with `|`

Each FQDN is split into parts
* Hostname (`cname`.domain.com) _Optional_
  * Can have from 1 up to 127 levels deep cnames.
  * Can contain [0-9], [a-z] and `-`.
  * Must be at least 1 char and no longer than 63 chars.
  * Must start with [a-z], [0-9].
  * Must NOT end with `-`.
* Domain (cname.`domain`.com)
  * Can contain [0-9], [a-z] and `-`.
  * Must be at least 1 chars and no longer than 63 chars.
  * Must start with [a-z], [0-9].
  * Must NOT end with `-`.
* Top-Level-Domains (cname.domain.`com`)
  * Can contain [0-9], [a-z] and `-`.
  * Must be at least 2 chars and no longer than 63 chars.
  * Must start with [a-z].
  * Must NOT end with `-`.

Regex used to match those: `^(([a-z\d](-?[a-z\d]){0,62})\.)*(([a-z\d](-?[a-z\d]){0,62})\.)([a-z](-?[a-z\d]){1,62})((\|((([a-z\d](-?[a-z\d]){0,62})\.)*(([a-z\d](-?[a-z\d]){0,62})\.)([a-z](-?[a-z\d]){1,62})))*)$`
You can try live [here](https://regex101.com/r/rIxhye/1)

__`Server Name`__
Accepted formats are:

- Single FQDN (eg. `collabora.mydomain.com` or `mydomain.com`)

_Same rules apply for FQDN as in the section above_

Regex used to match this: `^(([a-z\d](-?[a-z\d]){0,62})\.)*(([a-z\d](-?[a-z\d]){0,62})\.)([a-z](-?[a-z\d]){1,62})$`
You can try live [here](https://regex101.com/r/0HpkSI/1)

__`Password for WebUI`__
Accepted formats are:

- Letters, Numbers, Symbols, Minimum 8 characters (eg. `dg523$*a`) - It accepts `a-z`, `A-Z`, `0-9` and `!@#$%^&*?`

Regex used to match those: `[a-zA-Z0-9!@#$%^&*?]{8,}`
You can try live [here](https://regex101.com/r/ef3V88/1)

---

_If you find a field that you think it needs validation, please open an issue on github_
