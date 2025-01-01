---
title: Retry Middleware
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares/retry#full-examples) section for complete examples.
- Upstream documentation for this middleware can be found [here](https://doc.traefik.io/traefik/middlewares/http/retry)

:::

## Appears in

- `.Values.middlewares.$name.data`

:::tip

- See available middleware keys [here](/common/middlewares).
- This options apply only when `type: retry`.

:::

---

## `attempts`

Define the path

|            |                                   |
| ---------- | --------------------------------- |
| Key        | `middlewares.$name.data.attempts` |
| Type       | `string`                          |
| Required   | ✅                                 |
| Helm `tpl` | ❌                                 |
| Default    | -                                 |

Example

```yaml
middlewares:
  middleware-name:
    data:
      attempts: 3
```

---

## `initialInterval`

Define the initialInterval

|            |                                          |
| ---------- | ---------------------------------------- |
| Key        | `middlewares.$name.data.initialInterval` |
| Type       | `string`                                 |
| Required   | ❌                                        |
| Helm `tpl` | ❌                                        |
| Default    | -                                        |

Example

```yaml
middlewares:
  middleware-name:
    data:
      initialInterval: 1000
```

---

## Full Examples

```yaml
middlewares:
  middleware-name:
    enabled: true
    type: retry
    data:
      attempts: 3
      initialInterval: 1000
```
