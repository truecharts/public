---
title: Buffering Middleware
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares/buffering#full-examples) section for complete examples.
- Upstream documentation for this middleware can be found [here](https://doc.traefik.io/traefik/middlewares/http/buffering)

:::

## Appears in

- `.Values.middlewares.$name.data`

:::tip

- See available middleware keys [here](/common/middlewares).
- This options apply only when `type: buffering`.

:::

---

## `maxRequestBodyBytes`

Define the maxRequestBodyBytes

|            |                                              |
| ---------- | -------------------------------------------- |
| Key        | `middlewares.$name.data.maxRequestBodyBytes` |
| Type       | `int`                                        |
| Required   | ❌                                            |
| Helm `tpl` | ❌                                            |
| Default    | -                                            |

Example

```yaml
middlewares:
  middleware-name:
    data:
      maxRequestBodyBytes: 1024
```

---

## `memRequestBodyBytes`

Define the memRequestBodyBytes

|            |                                              |
| ---------- | -------------------------------------------- |
| Key        | `middlewares.$name.data.memRequestBodyBytes` |
| Type       | `int`                                        |
| Required   | ❌                                            |
| Helm `tpl` | ❌                                            |
| Default    | -                                            |

```yaml
middlewares:
  middleware-name:
    data:
      memRequestBodyBytes: 1024
```

---

## `maxResponseBodyBytes`

Define the maxResponseBodyBytes

|            |                                               |
| ---------- | --------------------------------------------- |
| Key        | `middlewares.$name.data.maxResponseBodyBytes` |
| Type       | `int`                                         |
| Required   | ❌                                             |
| Helm `tpl` | ❌                                             |
| Default    | -                                             |

```yaml
middlewares:
  middleware-name:
    data:
      maxResponseBodyBytes: 1024
```

---

## `memResponseBodyBytes`

Define the memResponseBodyBytes

|            |                                               |
| ---------- | --------------------------------------------- |
| Key        | `middlewares.$name.data.memResponseBodyBytes` |
| Type       | `int`                                         |
| Required   | ❌                                             |
| Helm `tpl` | ❌                                             |
| Default    | -                                             |

```yaml
middlewares:
  middleware-name:
    data:
      memResponseBodyBytes: 1024
```

---

## `retryExpression`

Define the retryExpression

|            |                                          |
| ---------- | ---------------------------------------- |
| Key        | `middlewares.$name.data.retryExpression` |
| Type       | `string`                                 |
| Required   | ❌                                        |
| Helm `tpl` | ❌                                        |
| Default    | -                                        |

```yaml
middlewares:
  middleware-name:
    data:
      retryExpression: "some-expression"
```

---

## Full Examples

```yaml
middlewares:
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
