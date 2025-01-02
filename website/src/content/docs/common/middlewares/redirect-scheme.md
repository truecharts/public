---
title: Redirect Scheme Middleware
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares/redirect-scheme#full-examples) section for complete examples.
- Upstream documentation for this middleware can be found [here](https://doc.traefik.io/traefik/middlewares/http/redirectscheme)

:::

## Appears in

- `.Values.middlewares.$name.data`

:::tip

- See available middleware keys [here](/common/middlewares).
- This options apply only when `type: redirect-scheme`.

:::

---

## `scheme`

Define the scheme

|            |                                 |
| ---------- | ------------------------------- |
| Key        | `middlewares.$name.data.scheme` |
| Type       | `string`                        |
| Required   | ✅                               |
| Helm `tpl` | ❌                               |
| Default    | -                               |

Example

```yaml
middlewares:
  middleware-name:
    data:
      scheme: https
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
    type: redirect-scheme
    data:
      scheme: https
      permanent: true
```
