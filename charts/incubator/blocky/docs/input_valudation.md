# Input Validation

**`Config File Host Path`, `Whitelist File Host Path`, `Blacklist File Host Path`**
Accepted formats are:

- Absolute file Paths (eg. `/mnt/pool/files/file.txt`) - Accepts the following characters `0-9`, `A-Z`, `a-z`, `_`, `-`, `/`, ` `, `.`

Regex used to match those: `^\/([a-zA-Z0-9._-]+(\s?[a-zA-Z0-9._-]+|\/?))+$`
You can try live [here](https://regex101.com/r/2mrQe1/1)

---

_If you find a field that you think it needs validation, please open an issue on github_
