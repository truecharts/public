---
title: Strip Prefix Regex Middleware
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares/strip-prefix-regex#full-examples) section for complete examples.
- Upstream documentation for this middleware can be found [here](https://doc.traefik.io/traefik/middlewares/http/stripprefixregex)

:::

## Appears in

- `.Values.middlewares.$name.data`

:::tip

- See available middleware keys [here](/common/middlewares).
- This options apply only when `type: strip-prefix-regex`.

:::

---

## `regex`

Define the regexes

|            |                                |
| ---------- | ------------------------------ |
| Key        | `middlewares.$name.data.regex` |
| Type       | `list` of `string`             |
| Required   | ✅                              |
| Helm `tpl` | ❌                              |
| Default    | -                              |

Example

```yaml
middlewares:
  middleware-name:
    data:
      regex:
        - some-regex
        - some-other-regex
```

---

## Full Examples

```yaml
middlewares:
  middleware-name:
    enabled: true
    type: strip-prefix-regex
    data:
      regex:
        - some-regex
        - some-other-regex
```
