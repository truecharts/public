---
title: NFS
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/persistence/nfs#full-examples) section for complete examples.

:::

## Appears in

- `.Values.persistence.$name`

:::tip

- See available persistence keys [here](/common/persistence).
- This options apply only when `type: nfs`.

:::

---

## `path`

Define the nfs export share path

|            |                          |
| ---------- | ------------------------ |
| Key        | `persistence.$name.path` |
| Type       | `string`                 |
| Required   | ✅                       |
| Helm `tpl` | ✅                       |
| Default    | `""`                     |

Example

```yaml
persistence:
  nfs-vol:
    path: /path/of/nfs/share
```

---

## `server`

Define the nfs server

|            |                            |
| ---------- | -------------------------- |
| Key        | `persistence.$name.server` |
| Type       | `string`                   |
| Required   | ✅                         |
| Helm `tpl` | ✅                         |
| Default    | `""`                       |

Example

```yaml
persistence:
  nfs-vol:
    server: nfs-server
```

---

## Full Examples

```yaml
persistence:
  nfs-vol:
    enabled: true
    type: nfs
    path: /path/of/nfs/share
    server: nfs-server
```
