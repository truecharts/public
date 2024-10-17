---
title: Notes
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/notes#full-examples) section for complete examples.

:::

## Appears in

- `.Values.notes`

---

## `notes`

Define values for `NOTES.txt`

|            |         |
| ---------- | ------- |
| Key        | `notes` |
| Type       | `map`   |
| Required   | ❌      |
| Helm `tpl` | ❌      |
| Default    | `{}`    |

Example

```yaml
notes: {}
```

---

### `header`

Define header

|            |                |
| ---------- | -------------- |
| Key        | `notes.header` |
| Type       | `string`       |
| Required   | ❌             |
| Helm `tpl` | ✅             |

Default

```yaml
header: |
  # Welcome to TrueCharts!
  Thank you for installing <{{ .Chart.Name }}>.
```

Example

```yaml
notes:
  header: ""
```

---

### `custom`

Define custom message, this go between header and footer

|            |                |
| ---------- | -------------- |
| Key        | `notes.custom` |
| Type       | `string`       |
| Required   | ❌             |
| Helm `tpl` | ✅             |
| Default    | `""`           |

Example

```yaml
notes:
  custom: ""
```

---

### `footer`

Define footer

|            |                |
| ---------- | -------------- |
| Key        | `notes.footer` |
| Type       | `string`       |
| Required   | ❌             |
| Helm `tpl` | ✅             |

Default

```yaml
footer: |
  # Documentation
  Documentation for this chart can be found at ...
  # Bug reports
  If you find a bug in this chart, please file an issue at ...
```

Example

```yaml
notes:
  footer: ""
```

---

## Full Examples

```yaml
notes:
  custom: |
    This is a custom message
```
