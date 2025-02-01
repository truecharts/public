---
title: IP Allow List Middleware
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares/traefik/ip-allow-list#full-examples) section for complete examples.
- Upstream documentation for this middleware can be found [here](https://doc.traefik.io/traefik/middlewares/http/ipallowlist)

:::

## Appears in

- `.Values.ingressMiddlewares.traefik.$name.data`

:::tip

- See available middleware keys [here](/common/middlewares).
- This options apply only when `type: ip-allow-list`.

:::

---

## `sourceRange`

Define the sourceRange

|            |                                                     |
| ---------- | --------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.sourceRange` |
| Type       | `list` of `string`                                  |
| Required   | ✅                                                   |
| Helm `tpl` | ❌                                                   |
| Default    | -                                                   |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        sourceRange:
          - some-source-range
```

---

## `ipStrategy`

Define the ipStrategy

|            |                                                    |
| ---------- | -------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.ipStrategy` |
| Type       | `map`                                              |
| Required   | ✅                                                  |
| Helm `tpl` | ❌                                                  |
| Default    | `{}`                                               |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        ipStrategy: {}
```

---

### `ipStrategy.depth`

Define the ipStrategy.depth

|            |                                                          |
| ---------- | -------------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.ipStrategy.depth` |
| Type       | `int`                                                    |
| Required   | ✅                                                        |
| Helm `tpl` | ❌                                                        |
| Default    | -                                                        |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        ipStrategy:
          depth: 1
```

---

### `ipStrategy.excludedIPs`

Define the ipStrategy.excludedIPs

|            |                                                                |
| ---------- | -------------------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.ipStrategy.excludedIPs` |
| Type       | `list` of `string`                                             |
| Required   | ✅                                                              |
| Helm `tpl` | ❌                                                              |
| Default    | -                                                              |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        ipStrategy:
          excludedIPs:
            - some-excluded-ip
```

---

## Full Examples

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      enabled: true
      type: ip-allow-list
      data:
        sourceRange:
          - some-source-range
        ipStrategy:
          depth: 1
          excludedIPs:
            - some-excluded-ip
```
