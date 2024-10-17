---
title: Host Path
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/persistence/hostpath#full-examples) section for complete examples.

:::

## Appears in

- `.Values.persistence.$name`

:::tip

- See available persistence keys [here](/common/persistence).
- This options apply only when `type: hostPath`.

:::

---

## `hostPath`

Define the hostPath

|            |                              |
| ---------- | ---------------------------- |
| Key        | `persistence.$name.hostPath` |
| Type       | `string`                     |
| Required   | ✅                           |
| Helm `tpl` | ✅                           |
| Default    | `""`                         |

Example

```yaml
persistence:
  hostpath-vol:
    hostPath: /path/to/host
```

---

## `hostPathType`

Define the hostPathType

|            |                                  |
| ---------- | -------------------------------- |
| Key        | `persistence.$name.hostPathType` |
| Type       | `string`                         |
| Required   | ❌                               |
| Helm `tpl` | ✅                               |
| Default    | `""`                             |

Valid Values

- `""`
- `DirectoryOrCreate`
- `Directory`
- `FileOrCreate`
- `File`
- `Socket`
- `CharDevice`
- `BlockDevice`

Example

```yaml
persistence:
  hostpath-vol:
    hostPathType: DirectoryOrCreate
```

---

## Full Examples

```yaml
persistence:
  hostpath-vol:
    enabled: true
    type: hostPath
    mountPath: /path
    hostPath: /path/to/host
    hostPathType: DirectoryOrCreate
```
