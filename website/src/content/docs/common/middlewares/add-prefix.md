---
title: Add Prefix Middleware
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares/add-prefix#full-examples) section for complete examples.
- Upstream documentation for this middleware can be found [here](https://doc.traefik.io/traefik/middlewares/http/addprefix)

:::

## Appears in

- `.Values.middlewares.$name.data`

:::tip

- See available middleware keys [here](/common/middlewares).
- This options apply only when `type: add-prefix`.

:::

---

## `prefix`

Define the prefix

|            |                                 |
| ---------- | ------------------------------- |
| Key        | `middlewares.$name.data.prefix` |
| Type       | `string`                        |
| Required   | ✅                               |
| Helm `tpl` | ❌                               |
| Default    | -                               |

Example

```yaml
middlewares:
  middleware-name:
    data:
      prefix: some-prefix
```

---

## Full Examples

```yaml
middlewares:
  middleware-name:
    enabled: true
    type: add-prefix
    data:
      prefix: some-prefix
```
