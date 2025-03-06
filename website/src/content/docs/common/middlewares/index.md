---
title: Ingress Middlewares
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares#full-examples) section for complete examples.

:::

## Appears in

- `.Values.ingressMiddlewares`

## Naming scheme

- `$FullName-$MiddlewareName` (release-name-chart-name-middleware-name)

:::tip

- Replace references to `$name` with the actual name you want to use.

:::

---

## `ingressMiddlewares`

Create Middleware objects

|            |                      |
| ---------- | -------------------- |
| Key        | `ingressMiddlewares` |
| Type       | `map`                |
| Required   | ❌                    |
| Helm `tpl` | ❌                    |
| Default    | `{}`                 |

Example

```yaml
ingressMiddlewares: {}
```

---

### `$provider`

Define Middleware

:::note

- Available providers are:
  - [traefik](/common/middlewares/traefik)

:::

|            |                                |
| ---------- | ------------------------------ |
| Key        | `ingressMiddlewares.$provider` |
| Type       | `map`                          |
| Required   | ✅                              |
| Helm `tpl` | ❌                              |
| Default    | `{}`                           |

Example

```yaml
ingressMiddlewares:
  traefik: {}
```

---

#### `$name`

Define Middleware

|            |                                      |
| ---------- | ------------------------------------ |
| Key        | `ingressMiddlewares.$provider.$name` |
| Type       | `map`                                |
| Required   | ✅                                    |
| Helm `tpl` | ❌                                    |
| Default    | `{}`                                 |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name: {}
```

---

##### `enabled`

Enables or Disables the Middleware

|            |                                              |
| ---------- | -------------------------------------------- |
| Key        | `ingressMiddlewares.$provider.$name.enabled` |
| Type       | `bool`                                       |
| Required   | ✅                                            |
| Helm `tpl` | ✅                                            |
| Default    | `false`                                      |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      enabled: true
```

---

##### `expandObjectName`

Whether to expand (adding the fullname as prefix) the middleware name.

|            |                                                      |
| ---------- | ---------------------------------------------------- |
| Key        | `ingressMiddleware.$provider.$name.expandObjectName` |
| Type       | `bool`                                               |
| Required   | ✅                                                    |
| Helm `tpl` | ✅                                                    |
| Default    | `true`                                               |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      expandObjectName: false
```

---

##### `namespace`

Define the namespace for this object

|            |                                                |
| ---------- | ---------------------------------------------- |
| Key        | `ingressMiddlewares.$provider.$name.namespace` |
| Type       | `string`                                       |
| Required   | ❌                                              |
| Helm `tpl` | ✅                                              |
| Default    | `""`                                           |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      namespace: some-namespace
```

---

##### `labels`

Additional labels for middleware

|            |                                             |
| ---------- | ------------------------------------------- |
| Key        | `ingressMiddlewares.$provider.$name.labels` |
| Type       | `map`                                       |
| Required   | ❌                                           |
| Helm `tpl` | ✅ (On value only)                           |
| Default    | `{}`                                        |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      labels:
        key: value
```

---

##### `annotations`

Additional annotations for middleware

|            |                                                  |
| ---------- | ------------------------------------------------ |
| Key        | `ingressMiddlewares.$provider.$name.annotations` |
| Type       | `map`                                            |
| Required   | ❌                                                |
| Helm `tpl` | ✅ (On value only)                                |
| Default    | `{}`                                             |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      annotations:
        key: value
```

---

##### `data`

Define the data of the middleware

|            |                                           |
| ---------- | ----------------------------------------- |
| Key        | `ingressMiddlewares.$provider.$name.data` |
| Type       | `map`                                     |
| Required   | ✅                                         |
| Helm `tpl` | ✅                                         |
| Example    | `{}`                                      |

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        key: value
```

---

##### `type`

Define the type for this object

:::note

See the [provider](/common/middlewares#provider) documentation for more information.

:::

|            |                                           |
| ---------- | ----------------------------------------- |
| Key        | `ingressMiddlewares.$provider.$name.type` |
| Type       | `string`                                  |
| Required   | ❌                                         |
| Helm `tpl` | ❌                                         |
| Default    | `""`                                      |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      type: buffering
```

---

## Full Examples

```yaml
ingressMiddlewares:
  traefik:
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
