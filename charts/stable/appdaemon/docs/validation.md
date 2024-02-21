---
title: Input Validation
---

**`LATITUDE`**
Accepted formats are:

- Float (eg. `24.2028`)
- Negative Float (eg. `-24.2028`)

Regex used to match this: `^(\+|-)?(?:90(?:(?:\.0{1,15})?)|(?:[0-9]|[1-8][0-9])(?:(?:\.[0-9]{1,15})?))$`
You can try live [here](https://regex101.com/r/kzRvvw/1)

**`LONGITUDE`**
Accepted formats are:

- Float (eg. `24.2028`)
- Negative Float (eg. `-24.2028`)

Regex used to match this: `^(\+|-)?(?:180(?:(?:\.0{1,15})?)|(?:[0-9]|[1-9][0-9]|1[0-7][0-9])(?:(?:\.[0-9]{1,15})?))$`
You can try live [here](https://regex101.com/r/EjuPpL/1)

---

_If you find a field that you think it needs validation, please open an issue on github_
