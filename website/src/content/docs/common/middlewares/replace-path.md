---
title: Replace Path Middleware
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares/replace-path#full-examples) section for complete examples.
- Upstream documentation for this middleware can be found [here](https://doc.traefik.io/traefik/middlewares/http/replacepath)

:::

## Appears in

- `.Values.middlewares.$name.data`

:::tip

- See available middleware keys [here](/common/middlewares).
- This options apply only when `type: replace-path`.

:::

---

## `path`

Define the path

|            |                               |
| ---------- | ----------------------------- |
| Key        | `middlewares.$name.data.path` |
| Type       | `string`                      |
| Required   | ✅                             |
| Helm `tpl` | ❌                             |
| Default    | -                             |

Example

```yaml
middlewares:
  middleware-name:
    data:
      path: /some-path
```

---

## Full Examples

```yaml
middlewares:
  middleware-name:
    enabled: true
    type: replace-path
    data:
      path: /some-path
```
