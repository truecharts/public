---
title: Addons
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/addons#full-examples) section for complete examples.

:::

## Appears in

- `.Values.addons`

:::tip

- Replace references to `$name` with the actual name you want to use.

:::

---

## `addons`

Addons to the workloads

|            |          |
| ---------- | -------- |
| Key        | `addons` |
| Type       | `map`    |
| Required   | ❌        |
| Helm `tpl` | ❌        |
| Default    | `{}`     |

Example

```yaml
addons: {}
```

---

### `addons.$addon`

COnfigure the addon

:::note

Available addons:

- CodeServer
- Netshoot
- GlueTun
- Tailscale

:::

|            |                 |
| ---------- | --------------- |
| Key        | `addons.$addon` |
| Type       | `map`           |
| Required   | ✅               |
| Helm `tpl` | ❌               |
| Default    | `{}`            |

Example

```yaml
addons:
  codeserver: {}
  netshoot: {}
  gluetun: {}
  tailscale: {}
```

---

#### `addons.$addon.enabled`

Enables or Disables the Addon

|            |                         |
| ---------- | ----------------------- |
| Key        | `addons.$addon.enabled` |
| Type       | `bool`                  |
| Required   | ✅                       |
| Helm `tpl` | ❌                       |
| Default    | `false`                 |

Example

```yaml
addons:
  codeserver:
    enabled: true
```

---

#### `addons.$addon.targetSelector`

Define the workloads to add the addon to

|            |                                |
| ---------- | ------------------------------ |
| Key        | `addons.$addon.targetSelector` |
| Type       | `list` of `string`             |
| Required   | ❌                              |
| Helm `tpl` | ❌                              |
| Default    | `["main"]`                     |

Example

```yaml
addons:
  codeserver:
    targetSelector:
      - main
      - other-workload
```

---

#### `addons.$addon.container`

Define additional options for the container

:::tip

See container options in the [container](/common/container) section.

:::

|            |                                                 |
| ---------- | ----------------------------------------------- |
| Key        | `addons.$addon.container`                       |
| Type       | `map`                                           |
| Required   | ❌                                               |
| Helm `tpl` | ❌                                               |
| Default    | Depends on the addon (See common's values.yaml) |

Example

```yaml
addons:
  codeserver:
    container: {}
```

---

#### `addons.$addon.service`

Define additional options for the service

:::tip

See service options in the [service](/common/service) section.

:::

:::note

Only applies to:

- Codeserver

:::

|            |                                                 |
| ---------- | ----------------------------------------------- |
| Key        | `addons.$addon.service`                         |
| Type       | `map`                                           |
| Required   | ❌                                               |
| Helm `tpl` | ❌                                               |
| Default    | Depends on the addon (See common's values.yaml) |

Example

```yaml
addons:
  codeserver:
    service: {}
```

---

#### `addons.$addon.ingress`

Define additional options for the ingress

:::tip

See ingress options in the [ingress](/common/ingress) section.

:::

:::note

Only applies to:

- Codeserver

:::

|            |                                                 |
| ---------- | ----------------------------------------------- |
| Key        | `addons.$addon.ingress`                         |
| Type       | `map`                                           |
| Required   | ❌                                               |
| Helm `tpl` | ❌                                               |
| Default    | Depends on the addon (See common's values.yaml) |

Example

```yaml
addons:
  codeserver:
    ingress: {}
```

---

## Full Examples

```yaml
addons:
  codeserver:
    enabled: true
    container:
      resources:
        limits:
          cpu: 3333m
          memory: 3333Mi
    service:
      enabled: true
      ports:
        codeserver:
          enabled: true
          port: 12345
          targetPort: 12345
    ingress:
      enabled: true
      hosts:
        - host: code.chart-example.local
          paths:
            - path: /
              pathType: Prefix
```
