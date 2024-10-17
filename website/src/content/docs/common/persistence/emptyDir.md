---
title: EmptyDir
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/persistence/emptydir#full-examples) section for complete examples.

:::

## Appears in

- `.Values.persistence.$name`

:::tip

- See available persistence keys [here](/common/persistence).
- This options apply only when `type: emptyDir`.

:::

---

## `size`

Define the sizeLimit of the emptyDir

|            |                          |
| ---------- | ------------------------ |
| Key        | `persistence.$name.size` |
| Type       | `string`                 |
| Required   | ❌                       |
| Helm `tpl` | ✅                       |
| Default    | `""`                     |

Example

```yaml
persistence:
  emptyDir-vol:
    size: 2Gi
```

---

## `medium`

Define the medium of emptyDir (Memory, "")

|            |                            |
| ---------- | -------------------------- |
| Key        | `persistence.$name.medium` |
| Type       | `string`                   |
| Required   | ❌                         |
| Helm `tpl` | ✅                         |
| Default    | `""`                       |

Valid Values

- `Memory`
- `""`

Example

```yaml
persistence:
  emptyDir-vol:
    medium: Memory
```

---

## Full Examples

```yaml
persistence:
  emptyDir-vol:
    enabled: true
    type: emptyDir
    medium: Memory
    size: 2Gi
```
