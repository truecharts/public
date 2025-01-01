---
title: Plugin Real IP Middleware
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares/plugin-theme-park#full-examples) section for complete examples.
- Upstream documentation for this middleware can be found [here](https://github.com/jramsgz/traefik-real-ip)

:::

## Appears in

- `.Values.middlewares.$name.data`

:::tip

- See available middleware keys [here](/common/middlewares).
- This options apply only when `type: plugin-real-ip`.

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
| Default    | `traefik-real-ip`                   |

Example

```yaml
middlewares:
  middleware-name:
    data:
      pluginName: my-plugin-name
```

---

## `excludednets`

Define the excludednets

|            |                                       |
| ---------- | ------------------------------------- |
| Key        | `middlewares.$name.data.excludednets` |
| Type       | `list` of `string`                    |
| Required   | ✅                                     |
| Helm `tpl` | ❌                                     |
| Default    | -                                     |

Example

```yaml
middlewares:
  middleware-name:
    data:
      excludednets:
        - some-excluded-net
        - some-other-excluded-net
```

---

## Full Examples

```yaml
middlewares:
  middleware-name:
    enabled: true
    type: plugin-real-ip
    data:
      pluginName: my-plugin-name
      excludednets:
        - some-excluded-net
        - some-other-excluded-net
```
