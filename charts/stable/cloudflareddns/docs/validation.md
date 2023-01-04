# Input Validation

**`CF Hosts`**
Not accepted domains are:

- String (eg. `example.cf`)
- String (eg. `example.ga`)
- String (eg. `example.gq`)
- String (eg. `example.ml`)
- String (eg. `example.tk`)

Regex used to match this: `^((?!\.cf$|\.ga$|\.gq$|\.ml$|\.tk$).)*$`
You can try live [here](https://regex101.com/r/GFEGVB/1)

**`CF Zones`**
Not accepted domains are:

- String (eg. `example.cf`)
- String (eg. `example.ga`)
- String (eg. `example.gq`)
- String (eg. `example.ml`)
- String (eg. `example.tk`)

Regex used to match this: `^((?!\.cf$|\.ga$|\.gq$|\.ml$|\.tk$).)*$`
You can try live [here](https://regex101.com/r/GFEGVB/1)

---

_If you find a field that you think it needs validation, please open an issue on github_
