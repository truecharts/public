---
title: Input Validation
---

**`CF Hosts`**

**Not** accepted domains are:

- Domain ending in `.cf` (eg. `example.cf`)
- Domain ending in `.ga` (eg. `example.ga`)
- Domain ending in `.gq` (eg. `example.gq`)
- Domain ending in `.ml` (eg. `example.ml`)
- Domain ending in `.tk` (eg. `example.tk`)

Regex used to match this: `^((?!(\.cf|\.ga|\.gq|\.ml|\.tk)$).)*$`
You can try live [here](https://regex101.com/r/rZBln5/1)

**`CF Zones`**

**Not** accepted domains are:

- Domain ending in `.cf` (eg. `example.cf`)
- Domain ending in `.ga` (eg. `example.ga`)
- Domain ending in `.gq` (eg. `example.gq`)
- Domain ending in `.ml` (eg. `example.ml`)
- Domain ending in `.tk` (eg. `example.tk`)

Regex used to match this: `^((?!(\.cf|\.ga|\.gq|\.ml|\.tk)$).)*$`
You can try live [here](https://regex101.com/r/rZBln5/1)

---

_If you find a field that you think it needs validation, please open an issue on github_
