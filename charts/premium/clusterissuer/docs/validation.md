---
title: Input Validation
---

**`Self Signed Issuer Name`, `ACME Issuer Entry` and `CA Issuer Name`**
Accepted formats are:

- Lowercase letters and single hyphens between letters
- No hyphens at the beginning or end of the name

Regex used to match those: `^[a-z]+(-?[a-z]){0,63}-?[a-z]+$`
You can try live [here](https://regex101.com/r/wKN01j/1)

---

_If you find a field that you think it needs validation, please open an issue on github_
