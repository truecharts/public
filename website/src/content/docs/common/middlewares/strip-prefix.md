---
title: Strip Prefix Middleware
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares/strip-prefix#full-examples) section for complete examples.
- Upstream documentation for this middleware can be found [here](https://doc.traefik.io/traefik/middlewares/http/stripprefix)

:::

## Appears in

- `.Values.middlewares.$name.data`

:::tip

- See available middleware keys [here](/common/middlewares).
- This options apply only when `type: strip-prefix`.

:::

---

## `prefix`

Define the prefixes

|            |                                 |
| ---------- | ------------------------------- |
| Key        | `middlewares.$name.data.prefix` |
| Type       | `list` of `string`              |
| Required   | ✅                               |
| Helm `tpl` | ❌                               |
| Default    | -                               |

Example

```yaml
middlewares:
  middleware-name:
    data:
      prefix:
        - /some-prefix
        - /some-other-prefix
```

---

## `forceSlash`

Define the forceSlash

|            |                                     |
| ---------- | ----------------------------------- |
| Key        | `middlewares.$name.data.forceSlash` |
| Type       | `bool`                              |
| Required   | ❌                                   |
| Helm `tpl` | ❌                                   |
| Default    | -                                   |

Example

```yaml
middlewares:
  middleware-name:
    data:
      forceSlash: true
```

---

## Full Examples

```yaml
middlewares:
  middleware-name:
    enabled: true
    type: strip-prefix
    data:
      prefix:
        - /some-prefix
        - /some-other-prefix
      forceSlash: true
```
