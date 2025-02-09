---
title: Traefik Integration
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/ingress/traefik#full-examples) section for complete examples.

:::

## Appears in

- `.Values.ingress.$name.integration.traefik`

:::tip

- Replace references to `$name` with the actual name you want to use.

:::

---

## `enabled`

Enables or Disables the traefik integration

|            |                                              |
| ---------- | -------------------------------------------- |
| Key        | `ingress.$name.integrations.traefik.enabled` |
| Type       | `bool`                                       |
| Required   | ❌                                            |
| Helm `tpl` | ❌                                            |
| Default    | `false`                                      |

Example

```yaml
ingress:
  ingress-name:
    integrations:
      traefik:
        enabled: true
```

---

## `entrypoints`

Define the entrypoints for this traefik integration

|            |                                                  |
| ---------- | ------------------------------------------------ |
| Key        | `ingress.$name.integrations.traefik.entrypoints` |
| Type       | `list`                                           |
| Required   | ❌                                                |
| Helm `tpl` | ❌                                                |
| Default    | `["websecure"]`                                  |

---

## `forceTLS`

Force TLS on this ingress

:::note

Adds the `traefik.ingress.kubernetes.io/router.tls` annotation.

It does that both with this set OR when [entrypoints](/common/ingress/traefik#entrypoints) include `websecure`

:::

|            |                                               |
| ---------- | --------------------------------------------- |
| Key        | `ingress.$name.integrations.traefik.forceTLS` |
| Type       | `bool`                                        |
| Required   | ❌                                             |
| Helm `tpl` | ❌                                             |
| Default    | `true`                                        |

Example

```yaml
ingress:
  ingress-name:
    integrations:
      traefik:
        forceTLS: true
```

---

## `middlewares`

The middlewares for this traefik integration

|            |                                                  |
| ---------- | ------------------------------------------------ |
| Key        | `ingress.$name.integrations.traefik.middlewares` |
| Type       | `list` of `map`                                  |
| Required   | ❌                                                |
| Helm `tpl` | ❌                                                |
| Default    | `[]`                                             |

Example

```yaml
ingress:
  ingress-name:
    integrations:
      traefik:
        middlewares:
          - name: my-middleware
            namespace: ""
```

---

### `middlewares[].name`

The name of the middleware

|            |                                                         |
| ---------- | ------------------------------------------------------- |
| Key        | `ingress.$name.integrations.traefik.middlewares[].name` |
| Type       | `string`                                                |
| Required   | ❌                                                       |
| Helm `tpl` | ❌                                                       |
| Default    | `""`                                                    |

Example

```yaml
ingress:
  ingress-name:
    integrations:
      traefik:
        middlewares:
          - name: my-middleware
            namespace: ""
```

---

### `middlewares[].namespace`

The namespace of the middleware

:::tip

If not defined, the current namespace will be used.

:::

|            |                                                              |
| ---------- | ------------------------------------------------------------ |
| Key        | `ingress.$name.integrations.traefik.middlewares[].namespace` |
| Type       | `string`                                                     |
| Required   | ❌                                                            |
| Helm `tpl` | ❌                                                            |
| Default    | `""`                                                         |

Example

```yaml
ingress:
  ingress-name:
    integrations:
      traefik:
        middlewares:
          - name: my-middleware
            namespace: my-namespace
```

---

### `middlewares[].expandObjectName`

Whether to expand the middleware name

|            |                                                                     |
| ---------- | ------------------------------------------------------------------- |
| Key        | `ingress.$name.integrations.traefik.middlewares[].expandObjectName` |
| Type       | `bool`                                                              |
| Required   | ❌                                                                   |
| Helm `tpl` | ❌                                                                   |
| Default    | `true`                                                              |

Example

```yaml
ingress:
  ingress-name:
    integrations:
      traefik:
        middlewares:
          - name: my-middleware
            expandObjectName: false
```

---

## `chartMiddlewares`

Same as [middlewares](#middlewares) but meant to be used by the chart developer
to define some custom middleware specific to this ingress.

|            |                                                       |
| ---------- | ----------------------------------------------------- |
| Key        | `ingress.$name.integrations.traefik.chartMiddlewares` |
| Type       | `list` of `map`                                       |
| Required   | ❌                                                     |
| Helm `tpl` | ❌                                                     |
| Default    | `[]`                                                  |

Example

```yaml
ingress:
  ingress-name:
    integrations:
      traefik:
        chartMiddlewares:
          - name: my-middleware
```

---

## Full Examples

```yaml
ingress:
  ingress-name:
    integrations:
      traefik:
        enabled: true
        entrypoints:
          - websecure
        forceTLS: true
        middlewares:
          - name: my-middleware
            namespace: ""
            expandObjectName: false
        chartMiddlewares:
          - name: my-middleware
```
