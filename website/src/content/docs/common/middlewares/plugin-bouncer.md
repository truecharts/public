---
title: Plugin Bouncer Middleware
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares/plugin-bouncer#full-examples) section for complete examples.
- Upstream documentation for this middleware can be found [here](github.com/maxlerebourg/crowdsec-bouncer-traefik-plugin)

:::

## Appears in

- `.Values.middlewares.$name.data`

:::tip

- See available middleware keys [here](/common/middlewares).
- This options apply only when `type: plugin-bouncer`.

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
| Default    | `bouncer`                           |

Example

```yaml
middlewares:
  middleware-name:
    data:
      pluginName: my-plugin-name
```

---

## Full Examples

```yaml
middlewares:
  middleware-name:
    enabled: true
    type: plugin-bouncer
    data:
      pluginName: my-plugin-name
```
