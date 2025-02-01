---
title: Basic Auth Middleware
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares/traefik/basic-auth#full-examples) section for complete examples.
- Upstream documentation for this middleware can be found [here](https://doc.traefik.io/traefik/middlewares/http/basicauth)

:::

## Appears in

- `.Values.ingressMiddlewares.traefik.$name.data`

:::tip

- See available middleware keys [here](/common/middlewares).
- This options apply only when `type: basic-auth`.

:::

---

## `users`

Define the users

:::note

If this is set, the `secret` key must not be set.

:::

|            |                                               |
| ---------- | --------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.users` |
| Type       | `list` of `map`                               |
| Required   | ✅                                             |
| Helm `tpl` | ❌                                             |
| Default    | -                                             |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        users:
          - username: some-username
            password: some-password
```

---

### `users[].username`

Define the username

|            |                                                        |
| ---------- | ------------------------------------------------------ |
| Key        | `ingressMiddlewares.traefik.$name.data.users.username` |
| Type       | `string`                                               |
| Required   | ✅                                                      |
| Helm `tpl` | ❌                                                      |
| Default    | -                                                      |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        users:
          - username: some-username
            password: some-password
```

---

### `users[].password`

Define the password

|            |                                                        |
| ---------- | ------------------------------------------------------ |
| Key        | `ingressMiddlewares.traefik.$name.data.users.password` |
| Type       | `string`                                               |
| Required   | ✅                                                      |
| Helm `tpl` | ❌                                                      |
| Default    | -                                                      |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        users:
          - username: some-username
            password: some-password
```

---

## `secret`

Define the secret

:::note

If this is set, the `users` key must not be set.

:::

|            |                                                |
| ---------- | ---------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.secret` |
| Type       | `string`                                       |
| Required   | ✅                                              |
| Helm `tpl` | ❌                                              |
| Default    | -                                              |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        secret: some-secret
```

---

## Full Examples

```yaml
ingressMiddlewares:
  traefik:
    middleware-name1:
      enabled: true
      type: basic-auth
      data:
        users:
          - username: some-username
            password: some-password
    middleware-name2:
      enabled: true
      type: basic-auth
      data:
        secret: some-secret
```
