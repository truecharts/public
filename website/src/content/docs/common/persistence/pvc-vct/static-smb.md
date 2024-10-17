---
title: Static SMB
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/persistence/pvc-vct/static-smb#full-examples) section for complete examples.

:::

## Appears in

- `.Values.persistence.$name.static`

:::tip

- See available persistence keys [here](/common/persistence).
- This options apply only when `type: pvc` or `type: vct` and `mode: smb`.

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
  smb-vol:
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
  smb-vol:
    type: pvc
    static:
      share: share
```

---

## `user`

Define the smb user

|            |                                 |
| ---------- | ------------------------------- |
| Key        | `persistence.$name.static.user` |
| Type       | `string`                        |
| Required   | ✅                              |
| Helm `tpl` | ❌                              |
| Default    | `""`                            |

Example

```yaml
persistence:
  smb-vol:
    type: pvc
    static:
      user: user
```

---

## `password`

Define the smb password

|            |                                     |
| ---------- | ----------------------------------- |
| Key        | `persistence.$name.static.password` |
| Type       | `string`                            |
| Required   | ✅                                  |
| Helm `tpl` | ❌                                  |
| Default    | `""`                                |

Example

```yaml
persistence:
  smb-vol:
    type: pvc
    static:
      password: password
```

---

## `domain`

Define the smb domain

|            |                                   |
| ---------- | --------------------------------- |
| Key        | `persistence.$name.static.domain` |
| Type       | `string`                          |
| Required   | ❌                                |
| Helm `tpl` | ❌                                |
| Default    | `""`                              |

Example

```yaml
persistence:
  smb-vol:
    type: pvc
    static:
      domain: domain
```

---

## Full Examples

```yaml
persistence:
  smb-vol:
    type: pvc
    static:
      mode: smb
      user: user
      password: password
      domain: domain
      share: share
      server: /server
```
