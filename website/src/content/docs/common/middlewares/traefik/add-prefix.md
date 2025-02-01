---
title: Add Prefix Middleware
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares/traefik/add-prefix#full-examples) section for complete examples.
- Upstream documentation for this middleware can be found [here](https://doc.traefik.io/traefik/middlewares/http/addprefix)

:::

## Appears in

- `.Values.ingressMiddlewares.traefik.$name.data`

:::tip

- See available middleware keys [here](/common/middlewares).
- This options apply only when `type: add-prefix`.

:::

---

## `prefix`

Define the prefix

|            |                                                |
| ---------- | ---------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.prefix` |
| Type       | `string`                                       |
| Required   | ✅                                              |
| Helm `tpl` | ❌                                              |
| Default    | -                                              |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        prefix: some-prefix
```

---

## Full Examples

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      enabled: true
      type: add-prefix
      data:
        prefix: some-prefix
```
