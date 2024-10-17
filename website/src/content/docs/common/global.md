---
title: Global
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/global#full-examples) section for complete examples.

:::

## Appears in

- `.Values.global`

---

## Defaults

```yaml
global:
  labels: {}
  annotations: {}
  namespace: ""
  minNodePort: 9000
  stopAll: false
  metallb:
    addServiceAnnotations: true
  traefik:
    addServiceAnnotations: true
    fixedMiddlewares:
      - name: chain-basic
        namespace: ""
    allowCorsMiddlewares:
      - name: tc-opencors-chain
        namespace: ""
```

---

## `labels`

Additional Labels that apply to all objects

|            |                    |
| ---------- | ------------------ |
| Key        | `global.labels`    |
| Type       | `map`              |
| Required   | ❌                 |
| Helm `tpl` | ✅ (On value only) |
| Default    | `{}`               |

Example

```yaml
global:
  labels:
    key: value
```

---

## `annotations`

Additional Annotations that apply to all objects

|            |                      |
| ---------- | -------------------- |
| Key        | `global.annotations` |
| Type       | `map`                |
| Required   | ❌                   |
| Helm `tpl` | ✅ (On value only)   |
| Default    | `{}`                 |

Example

```yaml
global:
  annotations:
    key: value
```

---

## `namespace`

Namespace to apply to all objects, also applies to chart deps

|            |                    |
| ---------- | ------------------ |
| Key        | `global.namespace` |
| Type       | `string`           |
| Required   | ❌                 |
| Helm `tpl` | ✅                 |
| Default    | `""`               |

Example

```yaml
global:
  namespace: ""
```

---

## `minNodePort`

Minimum Node Port Allowed

|            |                      |
| ---------- | -------------------- |
| Key        | `global.minNodePort` |
| Type       | `int`                |
| Required   | ✅                   |
| Helm `tpl` | ❌                   |
| Default    | `9000`               |

Example

```yaml
global:
  minNodePort: 9000
```

---

## `stopAll`

Applies different techniques to stop all objects in the chart and its dependencies

|            |                  |
| ---------- | ---------------- |
| Key        | `global.stopAll` |
| Type       | `bool`           |
| Required   | ❌               |
| Helm `tpl` | ❌               |
| Default    | `false`          |

Example

```yaml
global:
  stopAll: false
```

## `metallb`

Settings for metallb integration

|            |                  |
| ---------- | ---------------- |
| Key        | `global.metallb` |
| Type       | `map`            |
| Required   | ❌               |
| Helm `tpl` | ❌               |

Default

```yaml
global:
  metallb:
    addServiceAnnotations: true
```

Example

```yaml
global:
  metallb:
    addServiceAnnotations: false
```

---

## `traefik`

Settings for traefik integration

|            |                  |
| ---------- | ---------------- |
| Key        | `global.traefik` |
| Type       | `map`            |
| Required   | ❌               |
| Helm `tpl` | ❌               |

Default

```yaml
global:
  traefik:
    addServiceAnnotations: true
    fixedMiddlewares:
      - name: chain-basic
        namespace: ""
    allowCorsMiddlewares:
      - name: tc-opencors-chain
        namespace: ""
```

Example

```yaml
global:
  traefik:
    addServiceAnnotations: false
    fixedMiddlewares: []
    allowCorsMiddlewares: []
```

---

### `traefik.addServiceAnnotations`

Add annotations to services for traefik

|            |                                        |
| ---------- | -------------------------------------- |
| Key        | `global.traefik.addServiceAnnotations` |
| Type       | `bool`                                 |
| Required   | ❌                                     |
| Helm `tpl` | ❌                                     |
| Default    | `true`                                 |

Example

```yaml
global:
  traefik:
    addServiceAnnotations: true
```

---

### `traefik.fixedMiddlewares`

See documentation [here](/common/ingress/traefik#fixedmiddlewares)

Default

```yaml
global:
  traefik:
    fixedMiddlewares:
      - name: chain-basic
        namespace: ""
```

---

#### `traefik.fixedMiddlewares[].name`

See documentation [here](/common/ingress/traefik#fixedmiddlewaresname)

Example

```yaml
global:
  traefik:
    fixedMiddlewares:
      - name: my-custom-middleware
```

---

#### `traefik.fixedMiddlewares[].namespace`

See documentation [here](/common/ingress/traefik#fixedmiddlewaresnamespace)

Example

```yaml
global:
  traefik:
    fixedMiddlewares:
      - name: my-custom-middleware
        namespace: my-namespace
```

---

### `traefik.allowCorsMiddlewares`

Middlewares for traefik to apply when allowCors is enabled in the ingress

|            |                                       |
| ---------- | ------------------------------------- |
| Key        | `global.traefik.allowCorsMiddlewares` |
| Type       | `list` of `map`                       |
| Required   | ❌                                    |
| Helm `tpl` | ❌                                    |

Default

```yaml
global:
  traefik:
    allowCorsMiddlewares:
      - name: tc-opencors-chain
        namespace: ""
```

Example

```yaml
global:
  traefik:
    allowCorsMiddlewares:
      - name: my-custom-middleware
        namespace: my-namespace
```

---

#### `traefik.allowCorsMiddlewares[].name`

Name of the middleware

|            |                                              |
| ---------- | -------------------------------------------- |
| Key        | `global.traefik.allowCorsMiddlewares[].name` |
| Type       | `string`                                     |
| Required   | ❌                                           |
| Helm `tpl` | ❌                                           |
| Default    | `""`                                         |

Example

```yaml
global:
  traefik:
    allowCorsMiddlewares:
      - name: my-custom-middleware
```

---

#### `traefik.allowCorsMiddlewares[].namespace`

Namespace of the middleware

:::tip

If not defined, helm will do a lookup and try to find the namespace of the middleware.
If more than one namespaces are found, it will throw an error.

:::

|            |                                                   |
| ---------- | ------------------------------------------------- |
| Key        | `global.traefik.allowCorsMiddlewares[].namespace` |
| Type       | `string`                                          |
| Required   | ❌                                                |
| Helm `tpl` | ❌                                                |
| Default    | `""`                                              |

Example

```yaml
global:
  traefik:
    allowCorsMiddlewares:
      - name: my-custom-middleware
        namespace: my-namespace
```

---

## Full Examples

```yaml
global:
  labels:
    key: value
  annotations:
    key: value
  namespace: ""
  minNodePort: 9000
  stopAll: false
  metallb:
    addServiceAnnotations: true
  traefik:
    addServiceAnnotations: true
    fixedMiddlewares:
      - name: chain-basic
        namespace: ""
    allowCorsMiddlewares:
      - name: tc-opencors-chain
        namespace: ""
```
