# Validation

Validation makes sure that your input is in the desired format, so the application can parse it without problems.
Below you can find more info about which fields have the mentioned validation and what formats are accepted.

### All Apps
---

#### Resources and Devices

__`CPU`__
Accepted formats are:

- Plain integer (eg. `1`) - This means 1 hyperthread
- Float (eg. `0.5`) - This means half hyperthread
- Milicpu (eg. `500m`) This means also half hyperthread

Regex used to match those: `^(?!^0(\.0|m|)$)([0-9]+)(\.[0-9]|m?)$`
You can try live [here](https://regex101.com/r/WxComc/1)
More detailed info can be found [here](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#meaning-of-cpu)

__`Memory RAM`__
Accepted formats are:

- Suffixed with E, P, T, G, M, K (eg. `5G`) - This means 5Gigabyte of RAM
- Suffixed with Ei, Pi, Ti, Gi, Mi, Ki (eg. `5Gi`) - This means 5Gibibyte of RAM
- Plain integer (eg. `134217728`) - This means 128Megabyte of RAM
- As an exponent format (eg. `134e6`) This means ~128Megabyte of RAM

Regex uesd to match those: `^(?!^0(e[0-9]|[EPTGMK]i?|)$)([0-9]+)(|[EPTGMK]i?|e[0-9]+)$`
You can try live [here](https://regex101.com/r/LyDc6u/1)
More detailed info can be found [here](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#meaning-of-memory)

---

_If you find a field that you think it needs validation, please open an issue on github_
