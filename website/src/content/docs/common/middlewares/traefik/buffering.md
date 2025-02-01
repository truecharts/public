---
title: Buffering Middleware
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares/traefik/buffering#full-examples) section for complete examples.
- Upstream documentation for this middleware can be found [here](https://doc.traefik.io/traefik/middlewares/http/buffering)

:::

## Appears in

- `.Values.ingressMiddlewares.traefik.$name.data`

:::tip

- See available middleware keys [here](/common/middlewares).
- This options apply only when `type: buffering`.

:::

---

## `maxRequestBodyBytes`

Define the maxRequestBodyBytes

|            |                                                             |
| ---------- | ----------------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.maxRequestBodyBytes` |
| Type       | `int`                                                       |
| Required   | ❌                                                           |
| Helm `tpl` | ❌                                                           |
| Default    | -                                                           |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        maxRequestBodyBytes: 1024
```

---

## `memRequestBodyBytes`

Define the memRequestBodyBytes

|            |                                                             |
| ---------- | ----------------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.memRequestBodyBytes` |
| Type       | `int`                                                       |
| Required   | ❌                                                           |
| Helm `tpl` | ❌                                                           |
| Default    | -                                                           |

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        memRequestBodyBytes: 1024
```

---

## `maxResponseBodyBytes`

Define the maxResponseBodyBytes

|            |                                                              |
| ---------- | ------------------------------------------------------------ |
| Key        | `ingressMiddlewares.traefik.$name.data.maxResponseBodyBytes` |
| Type       | `int`                                                        |
| Required   | ❌                                                            |
| Helm `tpl` | ❌                                                            |
| Default    | -                                                            |

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        maxResponseBodyBytes: 1024
```

---

## `memResponseBodyBytes`

Define the memResponseBodyBytes

|            |                                                              |
| ---------- | ------------------------------------------------------------ |
| Key        | `ingressMiddlewares.traefik.$name.data.memResponseBodyBytes` |
| Type       | `int`                                                        |
| Required   | ❌                                                            |
| Helm `tpl` | ❌                                                            |
| Default    | -                                                            |

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        memResponseBodyBytes: 1024
```

---

## `retryExpression`

Define the retryExpression

|            |                                                         |
| ---------- | ------------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.retryExpression` |
| Type       | `string`                                                |
| Required   | ❌                                                       |
| Helm `tpl` | ❌                                                       |
| Default    | -                                                       |

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        retryExpression: "some-expression"
```

---

## Full Examples

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      enabled: true
      type: buffering
      data:
        maxRequestBodyBytes: 1024
        memRequestBodyBytes: 1024
        maxResponseBodyBytes: 1024
        memResponseBodyBytes: 1024
        retryExpression: "some-expression"
```
