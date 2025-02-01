---
title: Chain Middleware
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares/traefik/chain#full-examples) section for complete examples.
- Upstream documentation for this middleware can be found [here](https://doc.traefik.io/traefik/middlewares/http/chain)

:::

## Appears in

- `.Values.ingressMiddlewares.traefik.$name.data`

:::tip

- See available middleware keys [here](/common/middlewares).
- This options apply only when `type: chain`.

:::

---

## `middlewares`

Define the middlewares

|            |                                                     |
| ---------- | --------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.middlewares` |
| Type       | `list` of `map`                                     |
| Required   | ✅                                                   |
| Helm `tpl` | ❌                                                   |
| Default    | -                                                   |

Example

```yaml
middlewares:
  traefik:
    middleware-name:
      data:
        middlewares: []
```

---

### `middlewares[].name`

Define the middleware name

|            |                                                          |
| ---------- | -------------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.middlewares.name` |
| Type       | `string`                                                 |
| Required   | ✅                                                        |
| Helm `tpl` | ❌                                                        |
| Default    | -                                                        |

Example

```yaml
middlewares:
  traefik:
    middleware-name:
      data:
        middlewares:
          - name: some-name
```

---

### `middlewares[].expandObjectName`

Define the middleware expandObjectName

|            |                                                                      |
| ---------- | -------------------------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.middlewares.expandObjectName` |
| Type       | `bool`                                                               |
| Required   | ✅                                                                    |
| Helm `tpl` | ❌                                                                    |
| Default    | `true`                                                               |

Example

```yaml
middlewares:
  traefik:
    middleware-name:
      data:
        middlewares:
          - name: some-name
            expandObjectName: false
```

---

## Full Examples

```yaml
middlewares:
  traefik:
    middleware-name:
      enabled: true
      type: chain
      data:
        middlewares:
          - name: some-middleware
          - name: some-other-middleware
            expandObjectName: false
```
