---
title: Replace Path Regex Middleware
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares/traefik/replace-path-regex#full-examples) section for complete examples.
- Upstream documentation for this middleware can be found [here](https://doc.traefik.io/traefik/middlewares/http/replacepathregex)

:::

## Appears in

- `.Values.ingressMiddlewares.traefik.$name.data`

:::tip

- See available middleware keys [here](/common/middlewares).
- This options apply only when `type: replace-path-regex`.

:::

---

## `regex`

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
        regex: /some-path
```

---

## `replacement`

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
        replacement: /some-replacement
```

---

## Full Examples

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      enabled: true
      type: replace-path-regex
      data:
        regex: /some-path
        replacement: /some-replacement
```
