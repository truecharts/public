# Validation

Validation makes sure that your input is in the desired format, so the application can parse it without problems.
Below you can find more info about which fields have the mentioned validation and what formats are accepted.

### All Apps

##### Resources and Devices

__CPU__

Accepted formats are:

- Plain integer (eg. `1`) - This means 1 hyperthread
- Float (eg. `0.5`) - This means half hyperthread
- Milicpu (eg. `500m`) This means also half hyperthread

Regex used to match those: `^([0-9]+)(\.[0-9]?|m?)$`
You can try live [here](https://regex101.com/r/pFoJTx/1)
More detailed info can be found [here](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#meaning-of-cpu)

__Memory RAM__

Accepted formats are:

- Suffixed with E, P, T, G, M, K (eg. `5G`) - This means 5Gigabyte of RAM
- Suffixed with Ei, Pi, Ti, Gi, Mi, Ki (eg. `5Gi`) - This means 5Gibibyte of RAM
- Plain integer (eg. `134217728`) - This means 128Megabyte of RAM
- As an exponent format (eg. `134e6`) This means ~128Megabyte of RAM

Regex uesd to match those: `^([0-9.]+)([EPTGMK]i?|[EPTGMK]?|e[0-9]+)$`
You can try live [here](https://regex101.com/r/TUkZhN/1)
More detailed info can be found [here](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#meaning-of-memory)

---

### Per app validation

##### Appdaemon

__LATITUDE__ and __LONGITUDE__

Accepted formats are:

- Float (eg. `24.2028`)

Regex used to match this: `^[0-9]{1,}\.{1}[0-9]{1,}$`
You can try live [here](https://regex101.com/r/xsLGWN/1)

##### Collabora

__Domain(s) using collabora__

Accepted formats are:

- Single domain (eg. `cloud\.mydomain\.com`) - Each `.` has to be escaped with `\`
- Multiple domains (eg. `cloud\.mydomain\.com|nextcloud\.mydomain\.com`) - Each `.` has to be escaped with `\` and each domain is separated with `|`

Regex used to match those: `^([a-z]{1,}\\{1}\.{1}[a-z]{1,}\\{1}\.{1}[a-z]{1,}\|{0,1})*$`
You can try live [here](https://regex101.com/r/LK02xa/1)

__Password for WebUI__

Accepted formats are:

- Letters, Numbers, Symbols, Minimum 8 characters (eg. `dg523$*a`) - It accepts `a-z`, `A-Z`, `0-9` and `!@#$%^&*?`

Regex used to match those: `[a-zA-Z0-9!@#$%^&*?]{8,}`
You can try live [here](https://regex101.com/r/ef3V88/1)

##### Fireflyiii

__APP_KEY__

Accepted formats are:

- Letters, Numbers, Symbols, Exactly 32 characters (eg. `!oqVA9o2@br#$6vAyk8LLrDm54X5EtjD`) - It accepts `a-z`, `A-Z`, `0-9` and `!@#$%^&*?`

You can try live [here](https://regex101.com/r/OR879w/1)
Regex used to match this: `[a-zA-Z0-9!@#$%^&*?]{32}`

---

_If you find a field that you think it needs validation, please open an issue on github_