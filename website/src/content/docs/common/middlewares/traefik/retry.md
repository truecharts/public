---
title: Retry Middleware
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares/traefik/retry#full-examples) section for complete examples.
- Upstream documentation for this middleware can be found [here](https://doc.traefik.io/traefik/middlewares/http/retry)

:::

## Appears in

- `.Values.ingressMiddlewares.traefik.$name.data`

:::tip

- See available middleware keys [here](/common/middlewares).
- This options apply only when `type: retry`.

:::

---

## `attempts`

Define the path

|            |                                                  |
| ---------- | ------------------------------------------------ |
| Key        | `ingressMiddlewares.traefik.$name.data.attempts` |
| Type       | `string`                                         |
| Required   | ✅                                                |
| Helm `tpl` | ❌                                                |
| Default    | -                                                |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        attempts: 3
```

---

## `initialInterval`

Define the initialInterval

|            |                                                         |
| ---------- | ------------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.initialInterval` |
| Type       | `string`                                                |
| Required   | ❌                                                       |
| Helm `tpl` | ❌                                                       |
| Default    | -                                                       |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        initialInterval: 1000
```

---

## Full Examples

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      enabled: true
      type: retry
      data:
        attempts: 3
        initialInterval: 1000
```
