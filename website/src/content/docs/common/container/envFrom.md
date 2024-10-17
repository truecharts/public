---
title: EnvFrom
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/container/envfrom#full-examples) section for complete examples.

:::

## Appears in

- `.Values.workload.$name.podSpec.containers.$name`
- `.Values.workload.$name.podSpec.initContainers.$name`

---

## `envFrom`

Define envFrom for the container

|            |                                                   |
| ---------- | ------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.envFrom` |
| Type       | `list` of `map`                                   |
| Required   | ❌                                                |
| Helm `tpl` | ❌                                                |
| Default    | `[]`                                              |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          envFrom: []
```

---

### `envFrom.secretRef`

Define the secretRef

|            |                                                               |
| ---------- | ------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.envFrom[].secretRef` |
| Type       | `map`                                                         |
| Required   | ❌                                                            |
| Helm `tpl` | ❌                                                            |
| Default    | `{}`                                                          |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          envFrom:
            - secretRef: {}
```

---

#### `envFrom.secretRef.name`

Define the secret name

:::note

This will be automatically expanded to `fullname-secret-name`.
You can opt out of this by setting [`expandObjectName`](/common/container/envfrom#envfromsecretrefexpandobjectname) to `false`

:::

|            |                                                                    |
| ---------- | ------------------------------------------------------------------ |
| Key        | `workload.$name.podSpec.containers.$name.envFrom[].secretRef.name` |
| Type       | `string`                                                           |
| Required   | ✅                                                                 |
| Helm `tpl` | ✅                                                                 |
| Default    | `""`                                                               |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          envFrom:
            - secretRef:
                name: secret-name
```

---

#### `envFrom.secretRef.expandObjectName`

Whether to expand (adding the fullname as prefix) the secret name

|            |                                                                                |
| ---------- | ------------------------------------------------------------------------------ |
| Key        | `workload.$name.podSpec.containers.$name.envFrom[].secretRef.expandObjectName` |
| Type       | `bool`                                                                         |
| Required   | ❌                                                                             |
| Helm `tpl` | ❌                                                                             |
| Default    | `true`                                                                         |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          envFrom:
            - secretRef:
                name: secret-name
                expandObjectName: false
```

---

### `envFrom.configMapRef`

Define the configMapRef

|            |                                                                  |
| ---------- | ---------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.envFrom[].configMapRef` |
| Type       | `map`                                                            |
| Required   | ❌                                                               |
| Helm `tpl` | ❌                                                               |
| Default    | `{}`                                                             |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          envFrom:
            - configMapRef: {}
```

---

#### `envFrom.configMapRef.name`

Define the configmap name

:::note

This will be automatically expanded to `fullname-configmap-name`.
You can opt out of this by setting [`expandObjectName`](/common/container/envfrom#envfromconfigmaprefexpandobjectname) to `false`

:::

|            |                                                                       |
| ---------- | --------------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.envFrom[].configMapRef.name` |
| Type       | `string`                                                              |
| Required   | ✅                                                                    |
| Helm `tpl` | ✅                                                                    |
| Default    | `""`                                                                  |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          envFrom:
            - configMapRef:
                name: configmap-name
```

---

#### `envFrom.configMapRef.expandObjectName`

Whether to expand (adding the fullname as prefix) the configmap name

|            |                                                                                   |
| ---------- | --------------------------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.envFrom[].configMapRef.expandObjectName` |
| Type       | `bool`                                                                            |
| Required   | ❌                                                                                |
| Helm `tpl` | ❌                                                                                |
| Default    | `true`                                                                            |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          envFrom:
            - configMapRef:
                name: configmap-name
                expandObjectName: false
```

---

## Full Examples

```yaml
workload:
  workload-name:
    enabled: true
    primary: true
    podSpec:
      containers:
        container-name:
          enabled: true
          primary: true
          envFrom:
            - secretRef:
                # This will be expanded to `fullname-secret-name`
                name: secret-name
            - configMapRef:
                name: configmap-name
                expandObjectName: false
```
