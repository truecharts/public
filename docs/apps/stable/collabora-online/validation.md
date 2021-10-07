# Input Validation

__`Domain(s) using collabora`__
Accepted formats are:

- Single FQDN (eg. `cloud.mydomain.com`)
- Multiple FQDN (eg. `cloud.mydomain.com|nextcloud.mydomain.com`) - Each FQDN is separated with `|`

Each FQDN is split into parts
* Hostname (`cname`.domain.com)
  * Can have from 1 up to 127 levels deep cnames.
  * Can contain [0-9], [a-z] and `-`.
  * Must be at least 1 char and no longer than 63 chars.
  * Must start with [a-z], [0-9].
  * Must NOT end with `-`.
* Domain (cname.`domain`.com)
  * Can contain [0-9], [a-z] and `-`.
  * Must be at least 2 chars and no longer than 63 chars.
  * Must start with [a-z], [0-9].
  * Must NOT end with `-`.
* Top-Level-Domains (cname.domain.`com`)
  * Can contain [0-9], [a-z] and `-`.
  * Must be at least 2 chars and no longer than 63 chars.
  * Must start with [a-z].
  * Must NOT end with `-`.

Regex used to match those: `^(((([a-z0-9]{1,63}|[a-z0-9][a-z\-0-9]{1,61}[a-z0-9])\.){1,127}([a-z0-9][a-z\-0-9]{0,61}[a-z0-9])\.([a-z][a-z\-0-9]{0,61}[a-z0-9]))(\|(([a-z0-9]{1,63}|[a-z0-9][a-z\-0-9]{1,61}[a-z0-9])\.){1,127}([a-z0-9][a-z\-0-9]{0,61}[a-z0-9])\.([a-z][a-z\-0-9]{0,61}[a-z0-9]))*)*$`
You can try live [here](https://regex101.com/r/Yyt6Ct/1)

__`Server Name`__
Accepted formats are:

- Single FQDN (eg. `collabora.mydomain.com`)

The FQDN is split into parts
* Hostname (`cname`.domain.com)
  * Can have from 1 up to 127 levels deep cnames.
  * Can contain [0-9], [a-z] and `-`.
  * Must be at least 1 char and no longer than 63 chars.
  * Must start with [a-z], [0-9].
  * Must NOT end with `-`.
* Domain (cname.`domain`.com)
  * Can contain [0-9], [a-z] and `-`.
  * Must be at least 2 chars and no longer than 63 chars.
  * Must start with [a-z], [0-9].
  * Must NOT end with `-`.
* Top-Level-Domains (cname.domain.`com`)
  * Can contain [0-9], [a-z] and `-`.
  * Must be at least 2 chars and no longer than 63 chars.
  * Must start with [a-z].
  * Must NOT end with `-`.

Regex used to match this: `^((([a-z0-9]{1,63}|[a-z0-9][a-z\-0-9]{1,61}[a-z0-9])\.){1,127}([a-z0-9][a-z\-0-9]{0,61}[a-z0-9])\.([a-z][a-z\-0-9]{0,61}[a-z0-9]))*$`
You can try live [here](https://regex101.com/r/5m8oXl/1)

__`Password for WebUI`__
Accepted formats are:

- Letters, Numbers, Symbols, Minimum 8 characters (eg. `dg523$*a`) - It accepts `a-z`, `A-Z`, `0-9` and `!@#$%^&*?`

Regex used to match those: `[a-zA-Z0-9!@#$%^&*?]{8,}`
You can try live [here](https://regex101.com/r/ef3V88/1)

---

_If you find a field that you think it needs validation, please open an issue on github_
