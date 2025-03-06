---
title: Content Type Middleware
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares/traefik/content-type#full-examples) section for complete examples.
- Upstream documentation for this middleware can be found [here](https://doc.traefik.io/traefik/middlewares/http/contenttype)

:::

## Appears in

- `.Values.ingressMiddlewares.$name.data`

:::tip

- See available middleware keys [here](/common/middlewares).
- This options apply only when `type: content-type`.

:::

---

## Full Examples

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      enabled: true
      type: content-type
```
