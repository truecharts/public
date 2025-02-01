---
title: Replace Path Middleware
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares/traefik/replace-path#full-examples) section for complete examples.
- Upstream documentation for this middleware can be found [here](https://doc.traefik.io/traefik/middlewares/http/replacepath)

:::

## Appears in

- `.Values.ingressMiddlewares.traefik.$name.data`

:::tip

- See available middleware keys [here](/common/middlewares).
- This options apply only when `type: replace-path`.

:::

---

## `path`

Define the path

|            |                                              |
| ---------- | -------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.path` |
| Type       | `string`                                     |
| Required   | ✅                                            |
| Helm `tpl` | ❌                                            |
| Default    | -                                            |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        path: /some-path
```

---

## Full Examples

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      enabled: true
      type: replace-path
      data:
        path: /some-path
```
