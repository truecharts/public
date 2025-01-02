---
title: Compress Middleware
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares/compress#full-examples) section for complete examples.
- Upstream documentation for this middleware can be found [here](https://doc.traefik.io/traefik/middlewares/http/compress)

:::

## Appears in

- `.Values.middlewares.$name.data`

:::tip

- See available middleware keys [here](/common/middlewares).
- This options apply only when `type: compress`.

:::

---

## Full Examples

```yaml
middlewares:
  middleware-name:
    enabled: true
    type: compress
```
