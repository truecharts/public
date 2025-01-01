---
title: Forward Auth Middleware
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares/forward-auth#full-examples) section for complete examples.
- Upstream documentation for this middleware can be found [here](https://doc.traefik.io/traefik/middlewares/http/forwardauth)

:::

## Appears in

- `.Values.middlewares.$name.data`

:::tip

- See available middleware keys [here](/common/middlewares).
- This options apply only when `type: forward-auth`.

:::

---

## `address`

Define the address

|            |                                  |
| ---------- | -------------------------------- |
| Key        | `middlewares.$name.data.address` |
| Type       | `string`                         |
| Required   | ✅                                |
| Helm `tpl` | ❌                                |
| Default    | -                                |

Example

```yaml
middlewares:
  middleware-name:
    data:
      address: some-address
```

---

## `authResponseHeadersRegex`

Define the authResponseHeadersRegex

|            |                                                   |
| ---------- | ------------------------------------------------- |
| Key        | `middlewares.$name.data.authResponseHeadersRegex` |
| Type       | `string`                                          |
| Required   | ✅                                                 |
| Helm `tpl` | ❌                                                 |
| Default    | -                                                 |

Example

```yaml
middlewares:
  middleware-name:
    data:
      authResponseHeadersRegex: some-regex
```

---

## `trustForwardHeader`

Define the trustForwardHeader

|            |                                             |
| ---------- | ------------------------------------------- |
| Key        | `middlewares.$name.data.trustForwardHeader` |
| Type       | `bool`                                      |
| Required   | ✅                                           |
| Helm `tpl` | ❌                                           |
| Default    | `false`                                     |

Example

```yaml
middlewares:
  middleware-name:
    data:
      trustForwardHeader: true
```

---

## `authResponseHeaders`

Define the authResponseHeaders

|            |                                              |
| ---------- | -------------------------------------------- |
| Key        | `middlewares.$name.data.authResponseHeaders` |
| Type       | `list` of `string`                           |
| Required   | ✅                                            |
| Helm `tpl` | ❌                                            |
| Default    | `[]`                                         |

Example

```yaml
middlewares:
  middleware-name:
    data:
      authResponseHeaders:
        - some-header
```

---

## `authRequestHeaders`

Define the authRequestHeaders

|            |                                             |
| ---------- | ------------------------------------------- |
| Key        | `middlewares.$name.data.authRequestHeaders` |
| Type       | `list` of `string`                          |
| Required   | ✅                                           |
| Helm `tpl` | ❌                                           |
| Default    | `[]`                                        |

Example

```yaml
middlewares:
  middleware-name:
    data:
      authRequestHeaders:
        - some-header
```

---

## `tls`

Define the tls

|            |                              |
| ---------- | ---------------------------- |
| Key        | `middlewares.$name.data.tls` |
| Type       | `map`                        |
| Required   | ✅                            |
| Helm `tpl` | ❌                            |
| Default    | `{}`                         |

Example

```yaml
middlewares:
  middleware-name:
    data:
      tls: {}
```

---

### `tls.insecureSkipVerify`

Define the tls.insecureSkipVerify

|            |                                                 |
| ---------- | ----------------------------------------------- |
| Key        | `middlewares.$name.data.tls.insecureSkipVerify` |
| Type       | `bool`                                          |
| Required   | ✅                                               |
| Helm `tpl` | ❌                                               |
| Default    | `false`                                         |

Example

```yaml
middlewares:
  middleware-name:
    data:
      tls:
        insecureSkipVerify: true
```

---

## Full Examples

```yaml
middlewares:
  middleware-name:
    enabled: true
    type: forward-auth
    data:
      address: some-address
      authResponseHeadersRegex: some-regex
      trustForwardHeader: true
      authResponseHeaders:
        - some-header
      authRequestHeaders:
        - some-header
      tls:
        insecureSkipVerify: true
```
