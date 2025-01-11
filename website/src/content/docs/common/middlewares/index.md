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

- [add-prefix](/common/middlewares/add-prefix)
- [basic-auth](/common/middlewares/basic-auth)
- [buffering](/common/middlewares/buffering)
- [chain](/common/middlewares/chain)
- [compress](/common/middlewares/compress)
- [content-type](/common/middlewares/content-type)
- [forward-auth](/common/middlewares/forward-auth)
- [headers](/common/middlewares/headers)
- [ip-allow-list](/common/middlewares/ip-allow-list)
- [plugin-bouncer](/common/middlewares/plugin-bouncer)
- [plugin-geoblock](/common/middlewares/plugin-geoblock)
- [plugin-mod-security](/common/middlewares/plugin-mod-security)
- [plugin-real-ip](/common/middlewares/plugin-real-ip)
- [plugin-rewrite-response-headers](/common/middlewares/plugin-rewrite-response-headers)
- [plugin-theme-park](/common/middlewares/plugin-theme-park)
- [rate-limit](/common/middlewares/rate-limit)
- [redirect-regex](/common/middlewares/redirect-regex)
- [redirect-scheme](/common/middlewares/redirect-scheme)
- [replace-path-regex](/common/middlewares/replace-path-regex)
- [replace-path](/common/middlewares/replace-path)
- [retry](/common/middlewares/retry)
- [strip-prefix-regex](/common/middlewares/strip-prefix-regex)
- [strip-prefix](/common/middlewares/strip-prefix)

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
