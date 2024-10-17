---
title: Env
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/container/env#full-examples) section for complete examples.

:::

:::tip

Variable names will be scanned for duplicates across all
[secrets](/common/secret), [configmaps](/common/configmap),
[env](/common/container/env), [envList](/common/container/envlist) and [fixedEnv](/common/container/fixedenv)
and will throw an error if it finds any.

:::

## Appears in

- `.Values.workload.$name.podSpec.containers.$name`
- `.Values.workload.$name.podSpec.initContainers.$name`

---

## `env`

Define env(s) for the container

|            |                                               |
| ---------- | --------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.env` |
| Type       | `map`                                         |
| Required   | ❌                                            |
| Helm `tpl` | ✅ (Only value)                               |
| Default    | `{}`                                          |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          env: {}
```

---

### `env.$key`

Define the env key

|            |                                                    |
| ---------- | -------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.env.$key` |
| Type       | `string` or `map`                                  |
| Required   | ✅                                                 |
| Helm `tpl` | ✅ (Only on value, when it's a string)             |
| Default    | `""`                                               |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          env:
            ENV_NAME: ""
```

---

#### `env.$key.configMapKeyRef`

Define variable from configMapKeyRef

|            |                                                                    |
| ---------- | ------------------------------------------------------------------ |
| Key        | `workload.$name.podSpec.containers.$name.env.$key.configMapKeyRef` |
| Type       | `map`                                                              |
| Required   | ❌                                                                 |
| Helm `tpl` | ❌                                                                 |
| Default    | `{}`                                                               |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          env:
            ENV_NAME:
              configMapKeyRef: {}
```

---

##### `env.$key.configMapKeyRef.name`

Define the configMap name

:::note

This will be automatically expanded to `fullname-secret-name`.
You can opt out of this by setting [`expandObjectName`](/common/container/env#envkeyconfigmapkeyrefexpandobjectname) to `false`

:::

|            |                                                                         |
| ---------- | ----------------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.env.$key.configMapKeyRef.name` |
| Type       | `string`                                                                |
| Required   | ✅                                                                      |
| Helm `tpl` | ✅                                                                      |
| Default    | `""`                                                                    |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          env:
            ENV_NAME:
              configMapKeyRef:
                name: some-configmap-name
```

---

##### `env.$key.configMapKeyRef.key`

Define the configMap key

|            |                                                                        |
| ---------- | ---------------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.env.$key.configMapKeyRef.key` |
| Type       | `string`                                                               |
| Required   | ✅                                                                     |
| Helm `tpl` | ❌                                                                     |
| Default    | `""`                                                                   |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          env:
            ENV_NAME:
              configMapKeyRef:
                key: some-configmap-key
```

---

##### `env.$key.configMapKeyRef.expandObjectName`

Whether to expand (adding the fullname as prefix) the configmap name

|            |                                                                                     |
| ---------- | ----------------------------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.env.$key.configMapKeyRef.expandObjectName` |
| Type       | `bool`                                                                              |
| Required   | ❌                                                                                  |
| Helm `tpl` | ❌                                                                                  |
| Default    | `true`                                                                              |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          env:
            ENV_NAME:
              configMapKeyRef:
                expandObjectName: false
```

---

#### `env.$key.secretKeyRef`

Define variable from secretKeyRef

|            |                                                                 |
| ---------- | --------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.env.$key.secretKeyRef` |
| Type       | `map`                                                           |
| Required   | ❌                                                              |
| Helm `tpl` | ❌                                                              |
| Default    | `{}`                                                            |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          env:
            ENV_NAME:
              secretKeyRef: {}
```

---

##### `env.$key.secretKeyRef.name`

Define the secret name

:::note

This will be automatically expanded to `fullname-secret-name`.
You can opt out of this by setting [`expandObjectName`](/common/container/env#envkeysecretkeyrefexpandobjectname) to `false`

:::

|            |                                                                      |
| ---------- | -------------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.env.$key.secretKeyRef.name` |
| Type       | `string`                                                             |
| Required   | ✅                                                                   |
| Helm `tpl` | ✅                                                                   |
| Default    | `""`                                                                 |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          env:
            ENV_NAME:
              secretKeyRef:
                name: some-secret-name
```

---

##### `env.$key.secretKeyRef.key`

Define the secret key

|            |                                                                     |
| ---------- | ------------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.env.$key.secretKeyRef.key` |
| Type       | `string`                                                            |
| Required   | ✅                                                                  |
| Helm `tpl` | ❌                                                                  |
| Default    | `""`                                                                |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          env:
            ENV_NAME:
              secretKeyRef:
                key: some-secret-key
```

---

##### `env.$key.secretKeyRef.expandObjectName`

Whether to expand (adding the fullname as prefix) the secret name

|            |                                                                                  |
| ---------- | -------------------------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.env.$key.secretKeyRef.expandObjectName` |
| Type       | `bool`                                                                           |
| Required   | ❌                                                                               |
| Helm `tpl` | ❌                                                                               |
| Default    | `true`                                                                           |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          env:
            ENV_NAME:
              secretKeyRef:
                expandObjectName: false
```

---

#### `env.$key.fieldRef`

Define variable from fieldRef

|            |                                                             |
| ---------- | ----------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.env.$key.fieldRef` |
| Type       | `map`                                                       |
| Required   | ❌                                                          |
| Helm `tpl` | ❌                                                          |
| Default    | `{}`                                                        |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          env:
            ENV_NAME:
              fieldRef: {}
```

---

##### `env.$key.fieldRef.fieldPath`

Define the field path

|            |                                                                       |
| ---------- | --------------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.env.$key.fieldRef.fieldPath` |
| Type       | `string`                                                              |
| Required   | ✅                                                                    |
| Helm `tpl` | ❌                                                                    |
| Default    | `""`                                                                  |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          env:
            ENV_NAME:
              fieldRef:
                fieldPath: metadata.name
```

---

##### `env.$key.fieldRef.apiVersion`

Define the apiVersion

|            |                                                                        |
| ---------- | ---------------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.env.$key.fieldRef.apiVersion` |
| Type       | `string`                                                               |
| Required   | ❌                                                                     |
| Helm `tpl` | ❌                                                                     |
| Default    | `""`                                                                   |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          env:
            ENV_NAME:
              fieldRef:
                apiVersion: v1
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
          env:
            ENV_NAME1: ENV_VALUE
            ENV_NAME2: "{{ .Values.some.path }}"
            ENV_NAME3:
              configMapKeyRef:
                # This will be expanded to 'fullname-configmap-name'
                name: configmap-name
                key: configmap-key
            ENV_NAME4:
              secretKeyRef:
                name: secret-name
                key: secret-key
                expandObjectName: false
            ENV_NAME5:
              fieldRef:
                fieldPath: metadata.name
                apiVersion: v1
```
