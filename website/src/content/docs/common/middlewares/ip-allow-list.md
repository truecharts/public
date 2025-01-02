---
title: IP Allow List Middleware
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares/ip-allow-list#full-examples) section for complete examples.
- Upstream documentation for this middleware can be found [here](https://doc.traefik.io/traefik/middlewares/http/ipallowlist)

:::

## Appears in

- `.Values.middlewares.$name.data`

:::tip

- See available middleware keys [here](/common/middlewares).
- This options apply only when `type: ip-allow-list`.

:::

---

## `sourceRange`

Define the sourceRange

|            |                                      |
| ---------- | ------------------------------------ |
| Key        | `middlewares.$name.data.sourceRange` |
| Type       | `list` of `string`                   |
| Required   | ✅                                    |
| Helm `tpl` | ❌                                    |
| Default    | -                                    |

Example

```yaml
middlewares:
  middleware-name:
    data:
      sourceRange:
        - some-source-range
```

---

## `ipStrategy`

Define the ipStrategy

|            |                                     |
| ---------- | ----------------------------------- |
| Key        | `middlewares.$name.data.ipStrategy` |
| Type       | `map`                               |
| Required   | ✅                                   |
| Helm `tpl` | ❌                                   |
| Default    | `{}`                                |

Example

```yaml
middlewares:
  middleware-name:
    data:
      ipStrategy: {}
```

---

### `ipStrategy.depth`

Define the ipStrategy.depth

|            |                                           |
| ---------- | ----------------------------------------- |
| Key        | `middlewares.$name.data.ipStrategy.depth` |
| Type       | `int`                                     |
| Required   | ✅                                         |
| Helm `tpl` | ❌                                         |
| Default    | -                                         |

Example

```yaml
middlewares:
  middleware-name:
    data:
      ipStrategy:
        depth: 1
```

---

### `ipStrategy.excludedIPs`

Define the ipStrategy.excludedIPs

|            |                                                 |
| ---------- | ----------------------------------------------- |
| Key        | `middlewares.$name.data.ipStrategy.excludedIPs` |
| Type       | `list` of `string`                              |
| Required   | ✅                                               |
| Helm `tpl` | ❌                                               |
| Default    | -                                               |

Example

```yaml
middlewares:
  middleware-name:
    data:
      ipStrategy:
        excludedIPs:
          - some-excluded-ip
```

---

## Full Examples

```yaml
middlewares:
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
