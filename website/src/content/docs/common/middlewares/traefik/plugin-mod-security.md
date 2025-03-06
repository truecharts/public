---
title: Plugin Mod Security Middleware
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares/traefik/plugin-mod-security#full-examples) section for complete examples.
- Upstream documentation for this middleware can be found [here](https://github.com/acouvreur/traefik-modsecurity-plugin)

:::

## Appears in

- `.Values.ingressMiddlewares.traefik.$name.data`

:::tip

- See available middleware keys [here](/common/middlewares).
- This options apply only when `type: plugin-mod-security`.

:::

---

## `pluginName`

Define the pluginName

|            |                                                    |
| ---------- | -------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.pluginName` |
| Type       | `string`                                           |
| Required   | ❌                                                  |
| Helm `tpl` | ❌                                                  |
| Default    | `traefik-modsecurity-plugin`                       |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        pluginName: my-plugin-name
```

---

## `modSecurityUrl`

Define the modSecurityUrl

|            |                                                        |
| ---------- | ------------------------------------------------------ |
| Key        | `ingressMiddlewares.traefik.$name.data.modSecurityUrl` |
| Type       | `string`                                               |
| Required   | ✅                                                      |
| Helm `tpl` | ❌                                                      |
| Default    | -                                                      |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        modSecurityUrl: https://example.com
```

---

## `timeoutMillis`

Define the timeoutMillis

|            |                                                       |
| ---------- | ----------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.timeoutMillis` |
| Type       | `int`                                                 |
| Required   | ❌                                                     |
| Helm `tpl` | ❌                                                     |
| Default    | -                                                     |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        timeoutMillis: 1000
```

---

## `maxBodySize`

Define the maxBodySize

|            |                                                     |
| ---------- | --------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.maxBodySize` |
| Type       | `int`                                               |
| Required   | ❌                                                   |
| Helm `tpl` | ❌                                                   |
| Default    | -                                                   |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        maxBodySize: 1024
```

---

## Full Examples

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      enabled: true
      type: plugin-mod-security
      data:
        pluginName: my-plugin-name
        modSecurityUrl: https://example.com
        timeoutMillis: 1000
        maxBodySize: 1024
```
