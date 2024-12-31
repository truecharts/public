---
title: Middlewares
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares#full-examples) section for complete examples.

:::

## Appears in

- `.Values.middlewares`

## Naming scheme

- `$FullName-$MiddlewareName` (release-name-chart-name-middleware-name)

:::tip

- Replace references to `$name` with the actual name you want to use.

:::

---

## `middlewares`

Create Middleware objects

|            |               |
| ---------- | ------------- |
| Key        | `middlewares` |
| Type       | `map`         |
| Required   | ❌             |
| Helm `tpl` | ❌             |
| Default    | `{}`          |

Example

```yaml
middlewares: {}
```

---

### `$name`

Define Middleware

|            |                     |
| ---------- | ------------------- |
| Key        | `middlewares.$name` |
| Type       | `map`               |
| Required   | ✅                   |
| Helm `tpl` | ❌                   |
| Default    | `{}`                |

Example

```yaml
middlewares:
  middleware-name: {}
```

---

#### `enabled`

Enables or Disables the Configmap

|            |                           |
| ---------- | ------------------------- |
| Key        | `configmap.$name.enabled` |
| Type       | `bool`                    |
| Required   | ✅                         |
| Helm `tpl` | ✅                         |
| Default    | `false`                   |

Example

```yaml
middlewares:
  middleware-name:
    enabled: true
```

---

#### `expandObjectName`

Whether to expand (adding the fullname as prefix) the middleware name.

|            |                                    |
| ---------- | ---------------------------------- |
| Key        | `configmap.$name.expandObjectName` |
| Type       | `bool`                             |
| Required   | ✅                                  |
| Helm `tpl` | ✅                                  |
| Default    | `true`                             |

Example

```yaml
middlewares:
  middleware-name:
    expandObjectName: false
```

---

#### `namespace`

Define the namespace for this object

|            |                               |
| ---------- | ----------------------------- |
| Key        | `middlewares.$name.namespace` |
| Type       | `string`                      |
| Required   | ❌                             |
| Helm `tpl` | ✅                             |
| Default    | `""`                          |

Example

```yaml
middlewares:
  middleware-name:
    namespace: some-namespace
```

---

#### `type`

Define the type for this object

Available types:

- [buffering](/common/middlewares/buffering)

|            |                          |
| ---------- | ------------------------ |
| Key        | `middlewares.$name.type` |
| Type       | `string`                 |
| Required   | ❌                        |
| Helm `tpl` | ❌                        |
| Default    | `""`                     |

Example

```yaml
middlewares:
  middleware-name:
    type: buffering
```

---

#### `labels`

Additional labels for middleware

|            |                            |
| ---------- | -------------------------- |
| Key        | `middlewares.$name.labels` |
| Type       | `map`                      |
| Required   | ❌                          |
| Helm `tpl` | ✅ (On value only)          |
| Default    | `{}`                       |

Example

```yaml
middlewares:
  middleware-name:
    labels:
      key: value
```

---

#### `annotations`

Additional annotations for middleware

|            |                                 |
| ---------- | ------------------------------- |
| Key        | `middlewares.$name.annotations` |
| Type       | `map`                           |
| Required   | ❌                               |
| Helm `tpl` | ✅ (On value only)               |
| Default    | `{}`                            |

Example

```yaml
middlewares:
  middleware-name:
    annotations:
      key: value
```

---

#### `data`

Define the data of the middleware

|            |                          |
| ---------- | ------------------------ |
| Key        | `middlewares.$name.data` |
| Type       | `map`                    |
| Required   | ✅                        |
| Helm `tpl` | ✅                        |
| Example    | `{}`                     |

```yaml
middlewares:
  middleware-name:
    data:
      key: value
```

---

## Full Examples

```yaml
middlewares:
  middleware-name:
    enabled: true
    type: buffering
    expandObjectName: false
    labels:
      key: value
      keytpl: "{{ .Values.some.value }}"
    annotations:
      key: value
      keytpl: "{{ .Values.some.value }}"
    data:
      key: value

  other-middleware-name:
    enabled: true
    type: buffering
    namespace: some-namespace
    data:
      key: value
```
