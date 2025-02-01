---
title: Forward Auth Middleware
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares/traefik/forward-auth#full-examples) section for complete examples.
- Upstream documentation for this middleware can be found [here](https://doc.traefik.io/traefik/middlewares/http/forwardauth)

:::

## Appears in

- `.Values.ingressMiddlewares.traefik.$name.data`

:::tip

- See available middleware keys [here](/common/middlewares).
- This options apply only when `type: forward-auth`.

:::

---

## `address`

Define the address

|            |                                                 |
| ---------- | ----------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.address` |
| Type       | `string`                                        |
| Required   | ✅                                               |
| Helm `tpl` | ❌                                               |
| Default    | -                                               |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        address: some-address
```

---

## `authResponseHeadersRegex`

Define the authResponseHeadersRegex

|            |                                                                  |
| ---------- | ---------------------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.authResponseHeadersRegex` |
| Type       | `string`                                                         |
| Required   | ✅                                                                |
| Helm `tpl` | ❌                                                                |
| Default    | -                                                                |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        authResponseHeadersRegex: some-regex
```

---

## `trustForwardHeader`

Define the trustForwardHeader

|            |                                                            |
| ---------- | ---------------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.trustForwardHeader` |
| Type       | `bool`                                                     |
| Required   | ✅                                                          |
| Helm `tpl` | ❌                                                          |
| Default    | `false`                                                    |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        trustForwardHeader: true
```

---

## `authResponseHeaders`

Define the authResponseHeaders

|            |                                                             |
| ---------- | ----------------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.authResponseHeaders` |
| Type       | `list` of `string`                                          |
| Required   | ✅                                                           |
| Helm `tpl` | ❌                                                           |
| Default    | `[]`                                                        |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        authResponseHeaders:
          - some-header
```

---

## `authRequestHeaders`

Define the authRequestHeaders

|            |                                                            |
| ---------- | ---------------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.authRequestHeaders` |
| Type       | `list` of `string`                                         |
| Required   | ✅                                                          |
| Helm `tpl` | ❌                                                          |
| Default    | `[]`                                                       |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        authRequestHeaders:
          - some-header
```

---

## `tls`

Define the tls

|            |                                             |
| ---------- | ------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.tls` |
| Type       | `map`                                       |
| Required   | ✅                                           |
| Helm `tpl` | ❌                                           |
| Default    | `{}`                                        |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        tls: {}
```

---

### `tls.insecureSkipVerify`

Define the tls.insecureSkipVerify

|            |                                                                |
| ---------- | -------------------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.tls.insecureSkipVerify` |
| Type       | `bool`                                                         |
| Required   | ✅                                                              |
| Helm `tpl` | ❌                                                              |
| Default    | `false`                                                        |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        tls:
          insecureSkipVerify: true
```

---

## Full Examples

```yaml
ingressMiddlewares:
  traefik:
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
