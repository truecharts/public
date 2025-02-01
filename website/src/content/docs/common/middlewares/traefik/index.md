---
title: Traefik Middlewares
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares/traefik#full-examples) section for complete examples.

:::

## Appears in

- `.Values.ingressMiddlewares.traefik`

:::tip

- Replace references to `$name` with the actual name you want to use.

:::

---

## `type`

Define the type for this object

Available types:

- [add-prefix](/common/middlewares/traefik/add-prefix)
- [basic-auth](/common/middlewares/traefik/basic-auth)
- [buffering](/common/middlewares/traefik/buffering)
- [chain](/common/middlewares/traefik/chain)
- [compress](/common/middlewares/traefik/compress)
- [content-type](/common/middlewares/traefik/content-type)
- [forward-auth](/common/middlewares/traefik/forward-auth)
- [headers](/common/middlewares/traefik/headers)
- [ip-allow-list](/common/middlewares/traefik/ip-allow-list)
- [plugin-bouncer](/common/middlewares/traefik/plugin-bouncer)
- [plugin-geoblock](/common/middlewares/traefik/plugin-geoblock)
- [plugin-mod-security](/common/middlewares/traefik/plugin-mod-security)
- [plugin-real-ip](/common/middlewares/traefik/plugin-real-ip)
- [plugin-rewrite-response-headers](/common/middlewares/traefik/plugin-rewrite-response-headers)
- [plugin-theme-park](/common/middlewares/traefik/plugin-theme-park)
- [rate-limit](/common/middlewares/traefik/rate-limit)
- [redirect-regex](/common/middlewares/traefik/redirect-regex)
- [redirect-scheme](/common/middlewares/traefik/redirect-scheme)
- [replace-path-regex](/common/middlewares/traefik/replace-path-regex)
- [replace-path](/common/middlewares/traefik/replace-path)
- [retry](/common/middlewares/traefik/retry)
- [strip-prefix-regex](/common/middlewares/traefik/strip-prefix-regex)
- [strip-prefix](/common/middlewares/traefik/strip-prefix)

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
      data:
        key: value
```
