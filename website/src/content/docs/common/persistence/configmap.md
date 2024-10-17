---
title: Configmap
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/persistence/configmap#full-examples) section for complete examples.

:::

## Appears in

- `.Values.persistence.$name`

:::tip

- See available persistence keys [here](/common/persistence).
- This options apply only when `type: configmap`.

:::

---

## `objectName`

Define the configmap name.

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
  configmap-vol:
    objectName: configmap-name
```

---

## `expandObjectName`

Whether to expand (adding the fullname as prefix) the configmap name.

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
  configmap-vol:
    expandObjectName: false
```

---

## `optional`

Whether the configmap should be required or not.

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
  configmap-vol:
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
  configmap-vol:
    defaultMode: "0777"
```

---

## `items`

Define a list of items for configmap.

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
  configmap-vol:
    items:
      - key: key1
        path: path1
      - key: key2
        path: path2
```

---

### `items[].key`

Define the key of the configmap.

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
  configmap-vol:
    items:
      - key: key1
        path: path1
```

---

### `items[].path`

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
  configmap-vol:
    items:
      - key: key1
        path: path1
```

---

## Full Examples

```yaml
persistence:
  configmap-vol:
    enabled: true
    type: configmap
    objectName: configmap-name
    expandObjectName: false
    optional: false
    defaultMode: "0777"
    items:
      - key: key1
        path: path1
      - key: key2
        path: path2
```
