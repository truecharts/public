---
title: Secret
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/persistence/secret#full-examples) section for complete examples.

:::

## Appears in

- `.Values.persistence.$name`

:::tip

- See available persistence keys [here](/common/persistence).
- This options apply only when `type: secret`.

:::

---

## `objectName`

Define the secret name.

|            |                                |
| ---------- | ------------------------------ |
| Key        | `persistence.$name.objectName` |
| Type       | `string`                       |
| Required   | ✅                             |
| Helm `tpl` | ✅                             |
| Default    | `""`                           |

Example

```yaml
persistence:
  secret-vol:
    objectName: secret-name
```

---

## `expandObjectName`

Whether to expand (adding the fullname as prefix) the secret name.

|            |                                      |
| ---------- | ------------------------------------ |
| Key        | `persistence.$name.expandObjectName` |
| Type       | `bool`                               |
| Required   | ❌                                   |
| Helm `tpl` | ✅                                   |
| Default    | `true`                               |

Example

```yaml
persistence:
  secret-vol:
    expandObjectName: false
```

---

## `optional`

Whether the secret should be required or not.

|            |                              |
| ---------- | ---------------------------- |
| Key        | `persistence.$name.optional` |
| Type       | `bool`                       |
| Required   | ❌                           |
| Helm `tpl` | ❌                           |
| Default    | `false`                      |

Example

```yaml
persistence:
  secret-vol:
    optional: false
```

---

## `defaultMode`

Define the defaultMode (must be a string in format of "0777").

|            |                                 |
| ---------- | ------------------------------- |
| Key        | `persistence.$name.defaultMode` |
| Type       | `string`                        |
| Required   | ❌                              |
| Helm `tpl` | ✅                              |
| Default    | `""`                            |

Example

```yaml
persistence:
  secret-vol:
    defaultMode: "0777"
```

---

## `items`

Define a list of items for secret.

|            |                           |
| ---------- | ------------------------- |
| Key        | `persistence.$name.items` |
| Type       | `list`                    |
| Required   | ❌                        |
| Helm `tpl` | ❌                        |
| Default    | `[]`                      |

Example

```yaml
persistence:
  secret-vol:
    items:
      - key: key1
        path: path1
      - key: key2
        path: path2
```

---

### `items.key`

Define the key of the secret.

|            |                                 |
| ---------- | ------------------------------- |
| Key        | `persistence.$name.items[].key` |
| Type       | `string`                        |
| Required   | ✅                              |
| Helm `tpl` | ✅                              |
| Default    | `""`                            |

Example

```yaml
persistence:
  secret-vol:
    items:
      - key: key1
        path: path1
```

---

### `items.path`

Define the path.

|            |                                  |
| ---------- | -------------------------------- |
| Key        | `persistence.$name.items[].path` |
| Type       | `string`                         |
| Required   | ✅                               |
| Helm `tpl` | ✅                               |
| Default    | `""`                             |

Example

```yaml
persistence:
  secret-vol:
    items:
      - key: key1
        path: path1
```

---

## Full Examples

```yaml
persistence:
  secret-vol:
    enabled: true
    type: secret
    objectName: secret-name
    expandObjectName: false
    optional: false
    defaultMode: "0777"
    items:
      - key: key1
        path: path1
      - key: key2
        path: path2
```
