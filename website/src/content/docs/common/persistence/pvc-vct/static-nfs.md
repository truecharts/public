---
title: Static NFS
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/persistence/pvc-vct/static-nfs#full-examples) section for complete examples.

:::

## Appears in

- `.Values.persistence.$name.static`

:::tip

- See available persistence keys [here](/common/persistence).
- This options apply only when `type: pvc` or `type: vct` and `mode: nfs`.

:::

---

## `server`

Define the nfs server

|            |                                   |
| ---------- | --------------------------------- |
| Key        | `persistence.$name.static.server` |
| Type       | `string`                          |
| Required   | ✅                                |
| Helm `tpl` | ✅                                |
| Default    | `""`                              |

Example

```yaml
persistence:
  nfs-vol:
    type: pvc
    static:
      server: /server
```

---

## `share`

Define the nfs export share path

|            |                                  |
| ---------- | -------------------------------- |
| Key        | `persistence.$name.static.share` |
| Type       | `string`                         |
| Required   | ✅                               |
| Helm `tpl` | ✅                               |
| Default    | `""`                             |

Example

```yaml
persistence:
  nfs-vol:
    type: pvc
    static:
      share: share
```

---

## Full Examples

```yaml
persistence:
  nfs-vol:
    type: pvc
    static:
      mode: nfs
      server: /server
      share: share
```
