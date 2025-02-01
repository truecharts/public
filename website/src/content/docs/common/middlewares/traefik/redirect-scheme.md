---
title: Redirect Scheme Middleware
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares/traefik/redirect-scheme#full-examples) section for complete examples.
- Upstream documentation for this middleware can be found [here](https://doc.traefik.io/traefik/middlewares/http/redirectscheme)

:::

## Appears in

- `.Values.ingressMiddlewares.traefik.$name.data`

:::tip

- See available middleware keys [here](/common/middlewares).
- This options apply only when `type: redirect-scheme`.

:::

---

## `scheme`

Define the scheme

|            |                                                |
| ---------- | ---------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.scheme` |
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
        scheme: https
```

---

## `permanent`

Define the permanent

|            |                                                   |
| ---------- | ------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.permanent` |
| Type       | `bool`                                            |
| Required   | ❌                                                 |
| Helm `tpl` | ❌                                                 |
| Default    | -                                                 |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        permanent: true
```

---

## Full Examples

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      enabled: true
      type: redirect-scheme
      data:
        scheme: https
        permanent: true
```
