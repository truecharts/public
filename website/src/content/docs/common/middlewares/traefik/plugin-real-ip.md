---
title: Plugin Real IP Middleware
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares/traefik/plugin-theme-park#full-examples) section for complete examples.
- Upstream documentation for this middleware can be found [here](https://github.com/jramsgz/traefik-real-ip)

:::

## Appears in

- `.Values.ingressMiddlewares.traefik.$name.data`

:::tip

- See available middleware keys [here](/common/middlewares).
- This options apply only when `type: plugin-real-ip`.

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
| Default    | `traefik-real-ip`                                  |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        pluginName: my-plugin-name
```

---

## `excludednets`

Define the excludednets

|            |                                                      |
| ---------- | ---------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.excludednets` |
| Type       | `list` of `string`                                   |
| Required   | ✅                                                    |
| Helm `tpl` | ❌                                                    |
| Default    | -                                                    |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        excludednets:
          - some-excluded-net
          - some-other-excluded-net
```

---

## Full Examples

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      enabled: true
      type: plugin-real-ip
      data:
        pluginName: my-plugin-name
        excludednets:
          - some-excluded-net
          - some-other-excluded-net
```
