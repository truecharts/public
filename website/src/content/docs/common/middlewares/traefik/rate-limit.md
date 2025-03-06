---
title: Rate Limit Middleware
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares/traefik/rate-limit#full-examples) section for complete examples.
- Upstream documentation for this middleware can be found [here](https://doc.traefik.io/traefik/middlewares/http/ratelimit)

:::

## Appears in

- `.Values.ingressMiddlewares.traefik.$name.data`

:::tip

- See available middleware keys [here](/common/middlewares).
- This options apply only when `type: rate-limit`.

:::

---

## `average`

Define the average rate limit

|            |                                                 |
| ---------- | ----------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.average` |
| Type       | `int`                                           |
| Required   | ❌                                               |
| Helm `tpl` | ❌                                               |
| Default    | -                                               |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        average: 1000
```

---

## `burst`

Define the burst rate limit

|            |                                               |
| ---------- | --------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.burst` |
| Type       | `int`                                         |
| Required   | ❌                                             |
| Helm `tpl` | ❌                                             |
| Default    | -                                             |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        burst: 1000
```

---

## Full Examples

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      enabled: true
      type: rate-limit
      data:
        average: 1000
        burst: 1000
```
