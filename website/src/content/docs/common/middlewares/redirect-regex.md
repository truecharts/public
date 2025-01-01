---
title: Redirect Regex Middleware
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares/redirect-regex#full-examples) section for complete examples.
- Upstream documentation for this middleware can be found [here](https://doc.traefik.io/traefik/middlewares/http/redirectregex)

:::

## Appears in

- `.Values.middlewares.$name.data`

:::tip

- See available middleware keys [here](/common/middlewares).
- This options apply only when `type: redirect-regex`.

:::

---

## `regex`

Define the regex

|            |                                |
| ---------- | ------------------------------ |
| Key        | `middlewares.$name.data.regex` |
| Type       | `string`                       |
| Required   | ✅                              |
| Helm `tpl` | ❌                              |
| Default    | -                              |

Example

```yaml
middlewares:
  middleware-name:
    data:
      regex: some-regex
```

---

## `replacement`

Define the replacement

|            |                                      |
| ---------- | ------------------------------------ |
| Key        | `middlewares.$name.data.replacement` |
| Type       | `string`                             |
| Required   | ✅                                    |
| Helm `tpl` | ❌                                    |
| Default    | -                                    |

Example

```yaml
middlewares:
  middleware-name:
    data:
      replacement: some-replacement
```

---

## `permanent`

Define the permanent

|            |                                    |
| ---------- | ---------------------------------- |
| Key        | `middlewares.$name.data.permanent` |
| Type       | `bool`                             |
| Required   | ❌                                  |
| Helm `tpl` | ❌                                  |
| Default    | -                                  |

Example

```yaml
middlewares:
  middleware-name:
    data:
      permanent: true
```

---

## Full Examples

```yaml
middlewares:
  middleware-name:
    enabled: true
    type: redirect-regex
    data:
      regex: some-regex
      replacement: some-replacement
      permanent: true
```
