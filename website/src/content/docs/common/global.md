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
```

---

## `labels`

Additional Labels that apply to all objects

|            |                   |
| ---------- | ----------------- |
| Key        | `global.labels`   |
| Type       | `map`             |
| Required   | ❌                 |
| Helm `tpl` | ✅ (On value only) |
| Default    | `{}`              |

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
| Required   | ❌                    |
| Helm `tpl` | ✅ (On value only)    |
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
| Required   | ❌                  |
| Helm `tpl` | ✅                  |
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
| Required   | ✅                    |
| Helm `tpl` | ❌                    |
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
| Required   | ❌                |
| Helm `tpl` | ❌                |
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
| Required   | ❌                |
| Helm `tpl` | ❌                |

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
| Required   | ❌                |
| Helm `tpl` | ❌                |

Default

```yaml
global:
  traefik:
    addServiceAnnotations: true
```

Example

```yaml
global:
  traefik:
    addServiceAnnotations: false
```

---

### `traefik.addServiceAnnotations`

Add annotations to services for traefik

|            |                                        |
| ---------- | -------------------------------------- |
| Key        | `global.traefik.addServiceAnnotations` |
| Type       | `bool`                                 |
| Required   | ❌                                      |
| Helm `tpl` | ❌                                      |
| Default    | `true`                                 |

Example

```yaml
global:
  traefik:
    addServiceAnnotations: true
```

---

### `traefik.commonMiddlewares`

Define middlewares that will be applied to all ingresses

|            |                                     |
| ---------- | ----------------------------------- |
| Key        | `global.traefik.commonMiddlewares`  |
| Type       | `list`                              |
| Required   | ❌                                   |
| Helm `tpl` | ❌                                   |
| Default    | `[{name: tc-basic-secure-headers}]` |

Example

```yaml
global:
  traefik:
    commonMiddlewares:
      - name: tc-basic-secure-headers
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
    commonMiddlewares:
      - name: tc-basic-secure-headers
```
