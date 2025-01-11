---
title: Plugin Mod Security Middleware
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares/plugin-mod-security#full-examples) section for complete examples.
- Upstream documentation for this middleware can be found [here](https://github.com/acouvreur/traefik-modsecurity-plugin)

:::

## Appears in

- `.Values.middlewares.$name.data`

:::tip

- See available middleware keys [here](/common/middlewares).
- This options apply only when `type: plugin-mod-security`.

:::

---

## `pluginName`

Define the pluginName

|            |                                     |
| ---------- | ----------------------------------- |
| Key        | `middlewares.$name.data.pluginName` |
| Type       | `string`                            |
| Required   | ❌                                   |
| Helm `tpl` | ❌                                   |
| Default    | `traefik-modsecurity-plugin`        |

Example

```yaml
middlewares:
  middleware-name:
    data:
      pluginName: my-plugin-name
```

---

## `modSecurityUrl`

Define the modSecurityUrl

|            |                                         |
| ---------- | --------------------------------------- |
| Key        | `middlewares.$name.data.modSecurityUrl` |
| Type       | `string`                                |
| Required   | ✅                                       |
| Helm `tpl` | ❌                                       |
| Default    | -                                       |

Example

```yaml
middlewares:
  middleware-name:
    data:
      modSecurityUrl: https://example.com
```

---

## `timeoutMillis`

Define the timeoutMillis

|            |                                        |
| ---------- | -------------------------------------- |
| Key        | `middlewares.$name.data.timeoutMillis` |
| Type       | `int`                                  |
| Required   | ❌                                      |
| Helm `tpl` | ❌                                      |
| Default    | -                                      |

Example

```yaml
middlewares:
  middleware-name:
    data:
      timeoutMillis: 1000
```

---

## `maxBodySize`

Define the maxBodySize

|            |                                      |
| ---------- | ------------------------------------ |
| Key        | `middlewares.$name.data.maxBodySize` |
| Type       | `int`                                |
| Required   | ❌                                    |
| Helm `tpl` | ❌                                    |
| Default    | -                                    |

Example

```yaml
middlewares:
  middleware-name:
    data:
      maxBodySize: 1024
```

---

## Full Examples

```yaml
middlewares:
  middleware-name:
    enabled: true
    type: plugin-mod-security
    data:
      pluginName: my-plugin-name
      modSecurityUrl: https://example.com
      timeoutMillis: 1000
      maxBodySize: 1024
```
