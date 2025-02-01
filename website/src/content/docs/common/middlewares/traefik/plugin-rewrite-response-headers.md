---
title: Plugin Rewrite Response Headers Middleware
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares/traefik/plugin-rewrite-response-headers#full-examples) section for complete examples.
- Upstream documentation for this middleware can be found [here](https://github.com/XciD/traefik-plugin-rewrite-headers/)

:::

## Appears in

- `.Values.ingressMiddlewares.traefik.$name.data`

:::tip

- See available middleware keys [here](/common/middlewares).
- This options apply only when `type: plugin-rewrite-response-headers`.

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
| Default    | `rewriteResponseHeaders`                           |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        pluginName: my-plugin-name
```

---

## `rewrites`

Define the rewrites

|            |                                                  |
| ---------- | ------------------------------------------------ |
| Key        | `ingressMiddlewares.traefik.$name.data.rewrites` |
| Type       | `list` of `map`                                  |
| Required   | ✅                                                |
| Helm `tpl` | ❌                                                |
| Default    | -                                                |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        rewrites:
          - header: some-header
            regex: some-regex
            replacement: some-replacement
```

---

### `rewrites[].header`

Define the header

|            |                                                         |
| ---------- | ------------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.rewrites.header` |
| Type       | `string`                                                |
| Required   | ✅                                                       |
| Helm `tpl` | ❌                                                       |
| Default    | -                                                       |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        rewrites:
          - header: some-header
```

---

### `rewrites[].regex`

Define the regex

|            |                                               |
| ---------- | --------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.regex` |
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
        rewrites:
          - regex: some-regex
```

---

### `rewrites[].replacement`

Define the replacement

|            |                                                     |
| ---------- | --------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.replacement` |
| Type       | `string`                                            |
| Required   | ✅                                                   |
| Helm `tpl` | ❌                                                   |
| Default    | -                                                   |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        rewrites:
          - replacement: some-replacement
```

---

## Full Examples

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      enabled: true
      type: plugin-rewrite-response-headers
      data:
        pluginName: my-plugin-name
        rewrites:
          - header: some-header
            regex: some-regex
            replacement: some-replacement
          - header: some-other-header
            regex: some-other-regex
            replacement: some-other-replacement
```
