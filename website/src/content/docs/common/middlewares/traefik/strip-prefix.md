---
title: Strip Prefix Middleware
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares/traefik/strip-prefix#full-examples) section for complete examples.
- Upstream documentation for this middleware can be found [here](https://doc.traefik.io/traefik/middlewares/http/stripprefix)

:::

## Appears in

- `.Values.ingressMiddlewares.traefik.$name.data`

:::tip

- See available middleware keys [here](/common/middlewares).
- This options apply only when `type: strip-prefix`.

:::

---

## `prefix`

Define the prefixes

|            |                                                |
| ---------- | ---------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.prefix` |
| Type       | `list` of `string`                             |
| Required   | ✅                                              |
| Helm `tpl` | ❌                                              |
| Default    | -                                              |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        prefix:
          - /some-prefix
          - /some-other-prefix
```

---

## `forceSlash`

Define the forceSlash

|            |                                                    |
| ---------- | -------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.forceSlash` |
| Type       | `bool`                                             |
| Required   | ❌                                                  |
| Helm `tpl` | ❌                                                  |
| Default    | -                                                  |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        forceSlash: true
```

---

## Full Examples

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      enabled: true
      type: strip-prefix
      data:
        prefix:
          - /some-prefix
          - /some-other-prefix
        forceSlash: true
```
