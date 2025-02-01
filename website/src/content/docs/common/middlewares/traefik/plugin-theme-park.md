---
title: Plugin Theme Park Middleware
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares/traefik/plugin-theme-park#full-examples) section for complete examples.
- Upstream documentation for this middleware can be found [here](https://github.com/packruler/traefik-themepark)

:::

## Appears in

- `.Values.ingressMiddlewares.traefik.$name.data`

:::tip

- See available middleware keys [here](/common/middlewares).
- This options apply only when `type: plugin-theme-park`.

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
| Default    | `traefik-themepark`                                |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        pluginName: my-plugin-name
```

---

## `app`

Define the app

|            |                                             |
| ---------- | ------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.app` |
| Type       | `string`                                    |
| Required   | ✅                                           |
| Helm `tpl` | ❌                                           |
| Default    | -                                           |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        app: sonarr
```

---

## `theme`

Define the theme

|            |                                               |
| ---------- | --------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.theme` |
| Type       | `string`                                      |
| Required   | ✅                                             |
| Helm `tpl` | ❌                                             |
| Default    | -                                             |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        theme: dark
```

---

## `baseUrl`

Define the baseUrl

|            |                                                 |
| ---------- | ----------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.baseUrl` |
| Type       | `string`                                        |
| Required   | ❌                                               |
| Helm `tpl` | ❌                                               |
| Default    | -                                               |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        baseUrl: https://example.com
```

---

## `addons`

Define the addons

|            |                                                |
| ---------- | ---------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.addons` |
| Type       | `list` of `string`                             |
| Required   | ❌                                              |
| Helm `tpl` | ❌                                              |
| Default    | -                                              |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        addons:
          - some-addon
          - some-other-addon
```

---

## Full Examples

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      enabled: true
      type: plugin-theme-park
      data:
        pluginName: my-plugin-name
        app: sonarr
        theme: dark
        baseUrl: https://example.com
        addons:
          - some-addon
          - some-other-addon
```
