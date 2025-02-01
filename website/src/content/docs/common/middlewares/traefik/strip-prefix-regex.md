---
title: Strip Prefix Regex Middleware
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares/traefik/strip-prefix-regex#full-examples) section for complete examples.
- Upstream documentation for this middleware can be found [here](https://doc.traefik.io/traefik/middlewares/http/stripprefixregex)

:::

## Appears in

- `.Values.ingressMiddlewares.traefik.$name.data`

:::tip

- See available middleware keys [here](/common/middlewares).
- This options apply only when `type: strip-prefix-regex`.

:::

---

## `regex`

Define the regexes

|            |                                               |
| ---------- | --------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.regex` |
| Type       | `list` of `string`                            |
| Required   | ✅                                             |
| Helm `tpl` | ❌                                             |
| Default    | -                                             |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        regex:
          - some-regex
          - some-other-regex
```

---

## Full Examples

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      enabled: true
      type: strip-prefix-regex
      data:
        regex:
          - some-regex
          - some-other-regex
```
