---
title: Image Pull Secret
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/imagepullsecret#full-examples) section for complete examples.

:::

## Appears in

- `.Values.imagePullSecret`

## Naming scheme

- `$FullName-$ImagePullSecretName` (release-name-chart-name-imagePullSecretName)

:::tip

- Replace references to `$name` with the actual name you want to use.

:::

---

## Target Selector

- `targetSelectAll` (bool): Whether to assign the secret to all pods or not. `targetSelector` is ignored in this case
- `targetSelector` (list): Define the pod(s) to assign the secret
- `targetSelector` (empty): Assign the secret to the primary pod

---

## `imagePullSecret`

Define image pull secrets

|            |                   |
| ---------- | ----------------- |
| Key        | `imagePullSecret` |
| Type       | `map`             |
| Required   | ❌                 |
| Helm `tpl` | ❌                 |
| Default    | `{}`              |

Example

```yaml
imagePullSecret: {}
```

---

### `$name`

Define image pull secret

|            |                         |
| ---------- | ----------------------- |
| Key        | `imagePullSecret.$name` |
| Type       | `map`                   |
| Required   | ✅                       |
| Helm `tpl` | ❌                       |
| Default    | `{}`                    |

Example

```yaml
imagePullSecret:
  pull-secret-name: {}
```

---

#### `enabled`

Enables or Disables the image pull secret

|            |                                 |
| ---------- | ------------------------------- |
| Key        | `imagePullSecret.$name.enabled` |
| Type       | `bool`                          |
| Required   | ✅                               |
| Helm `tpl` | ✅                               |
| Default    | `false`                         |

Example

```yaml
imagePullSecret:
  pull-secret-name:
    enabled: true
```

---

#### `existingSecret`

Define the existing secret name

:::note

If this is defined, only the following keys are used:

- `enabled`
- `targetSelectAll`
- `targetSelector`

:::

|            |                                        |
| ---------- | -------------------------------------- |
| Key        | `imagePullSecret.$name.existingSecret` |
| Type       | `string`                               |
| Required   | ❌                                      |
| Helm `tpl` | ❌                                      |
| Default    | -                                      |

Example

```yaml
imagePullSecret:
  pull-secret-name:
    enabled: true
    existingSecret: some-existing-secret
```

---

#### `namespace`

Define the namespace for this object

|            |                                   |
| ---------- | --------------------------------- |
| Key        | `imagePullSecret.$name.namespace` |
| Type       | `string`                          |
| Required   | ❌                                 |
| Helm `tpl` | ✅ (On value only)                 |
| Default    | `""`                              |

Example

```yaml
imagePullSecret:
  pull-secret-name:
    namespace: some-namespace
```

---

#### `labels`

Additional labels for image pull secret

|            |                                |
| ---------- | ------------------------------ |
| Key        | `imagePullSecret.$name.labels` |
| Type       | `map`                          |
| Required   | ❌                              |
| Helm `tpl` | ✅ (On value only)              |
| Default    | `{}`                           |

Example

```yaml
imagePullSecret:
  pull-secret-name:
    labels:
      key: value
```

---

#### `annotations`

Additional annotations for image pull secret

|            |                                     |
| ---------- | ----------------------------------- |
| Key        | `imagePullSecret.$name.annotations` |
| Type       | `map`                               |
| Required   | ❌                                   |
| Helm `tpl` | ✅ (On value only)                   |
| Default    | `{}`                                |

Example

```yaml
imagePullSecret:
  pull-secret-name:
    annotations:
      key: value
```

---

#### `targetSelectAll`

Whether to assign the secret to all pods or not

|            |                                         |
| ---------- | --------------------------------------- |
| Key        | `imagePullSecret.$name.targetSelectAll` |
| Type       | `bool`                                  |
| Required   | ❌                                       |
| Helm `tpl` | ❌                                       |
| Default    | unset                                   |

Example

```yaml
imagePullSecret:
  pull-secret-name:
    targetSelectAll: true
```

---

#### `targetSelector`

Define the pod(s) to assign the secret

|            |                                        |
| ---------- | -------------------------------------- |
| Key        | `imagePullSecret.$name.targetSelector` |
| Type       | `list` of `string`                     |
| Required   | ❌                                      |
| Helm `tpl` | ❌                                      |
| Default    | `[]`                                   |

Example

```yaml
imagePullSecret:
  pull-secret-name:
    targetSelector:
      - workload-name1
      - workload-name2
```

---

#### `data`

Define the data of the image pull secret

|            |                              |
| ---------- | ---------------------------- |
| Key        | `imagePullSecret.$name.data` |
| Type       | `map`                        |
| Required   | ✅                            |
| Helm `tpl` | ❌                            |
| Default    | `{}`                         |

Example

```yaml
imagePullSecret:
  pull-secret-name:
    data: {}
```

---

##### `data.registry`

Define the registry of the image pull secret

|            |                                       |
| ---------- | ------------------------------------- |
| Key        | `imagePullSecret.$name.data.registry` |
| Type       | `string`                              |
| Required   | ✅                                     |
| Helm `tpl` | ✅                                     |
| Default    | `""`                                  |

Example

```yaml
imagePullSecret:
  pull-secret-name:
    data:
      registry: quay.io
```

---

##### `data.username`

Define the username of the image pull secret

|            |                                       |
| ---------- | ------------------------------------- |
| Key        | `imagePullSecret.$name.data.username` |
| Type       | `string`                              |
| Required   | ✅                                     |
| Helm `tpl` | ✅                                     |
| Default    | `""`                                  |

Example

```yaml
imagePullSecret:
  pull-secret-name:
    data:
      username: my_user
```

---

##### `data.password`

Define the password of the image pull secret

|            |                                       |
| ---------- | ------------------------------------- |
| Key        | `imagePullSecret.$name.data.password` |
| Type       | `string`                              |
| Required   | ✅                                     |
| Helm `tpl` | ✅                                     |
| Default    | `""`                                  |

Example

```yaml
imagePullSecret:
  pull-secret-name:
    data:
      password: my_pass
```

---

##### `data.email`

Define the email of the image pull secret

|            |                                    |
| ---------- | ---------------------------------- |
| Key        | `imagePullSecret.$name.data.email` |
| Type       | `string`                           |
| Required   | ✅                                  |
| Helm `tpl` | ✅                                  |
| Default    | `""`                               |

Example

```yaml
imagePullSecret:
  pull-secret-name:
    data:
      email: my_email@example.com
```

---

## Full Examples

```yaml
imagePullSecret:

  pull-secret-name:
    enabled: true
    namespace: some-namespace
    labels:
      key: value
      keytpl: "{{ .Values.some.value }}"
    annotations:
      key: value
      keytpl: "{{ .Values.some.value }}"
      data:
        registry: quay.io
        username: my_user
        password: my_pass
        email: my_mail@example.com
      targetSelectAll: true

  other-pull-secret-name:
    enabled: true
    namespace: some-namespace
      data:
        registry: "{{ .Values.my_registry }}"
        username: "{{ .Values.my_user }}"
        password: "{{ .Values.my_pass }}"
        email: "{{ .Values.my_mail }}"
      targetSelector:
        - workload-name1
        - workload-name2
```
