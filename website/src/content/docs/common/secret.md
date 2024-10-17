---
title: Secret
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/secret#full-examples) section for complete examples.

:::

## Appears in

- `.Values.secret`

## Naming scheme

- `$FullName-$SecretName` (release-name-chart-name-secret-name)

:::tip

- Replace references to `$name` with the actual name you want to use.

:::

---

## `secret`

Create Secret objects

|            |          |
| ---------- | -------- |
| Key        | `secret` |
| Type       | `map`    |
| Required   | ❌       |
| Helm `tpl` | ❌       |
| Default    | `{}`     |

Example

```yaml
secret: {}
```

---

### `$name`

Define Secret

|            |                |
| ---------- | -------------- |
| Key        | `secret.$name` |
| Type       | `map`          |
| Required   | ✅             |
| Helm `tpl` | ❌             |
| Default    | `{}`           |

Example

```yaml
secret:
  secret-name: {}
```

---

#### `enabled`

Enables or Disables the Secret

|            |                        |
| ---------- | ---------------------- |
| Key        | `secret.$name.enabled` |
| Type       | `bool`                 |
| Required   | ✅                     |
| Helm `tpl` | ✅                     |
| Default    | `false`                |

Example

```yaml
secret:
  secret-name:
    enabled: true
```

---

#### `namespace`

Define the namespace for this object

|            |                          |
| ---------- | ------------------------ |
| Key        | `secret.$name.namespace` |
| Type       | `string`                 |
| Required   | ❌                       |
| Helm `tpl` | ✅                       |
| Default    | `""`                     |

Example

```yaml
secret:
  secret-name:
    namespace: some-namespace
```

---

#### `labels`

Additional labels for secret

|            |                       |
| ---------- | --------------------- |
| Key        | `secret.$name.labels` |
| Type       | `map`                 |
| Required   | ❌                    |
| Helm `tpl` | ✅ (On value only)    |
| Default    | `{}`                  |

Example

```yaml
secret:
  secret-name:
    labels:
      key: value
```

---

#### `annotations`

Additional annotations for secret

|            |                            |
| ---------- | -------------------------- |
| Key        | `secret.$name.annotations` |
| Type       | `map`                      |
| Required   | ❌                         |
| Helm `tpl` | ✅ (On value only)         |
| Default    | `{}`                       |

Example

```yaml
secret:
  secret-name:
    annotations:
      key: value
```

---

#### `type`

Define the type of the secret

|            |                     |
| ---------- | ------------------- |
| Key        | `secret.$name.type` |
| Type       | `string`            |
| Required   | ❌                  |
| Helm `tpl` | ✅                  |
| Default    | `Opaque`            |

Example

```yaml
secret:
  secret-name:
    type: some-custom-type
```

---

#### `data`

Define the data of the secret

|            |                     |
| ---------- | ------------------- |
| Key        | `secret.$name.data` |
| Type       | `map`               |
| Required   | ✅                  |
| Helm `tpl` | ✅                  |
| Example    | `{}`                |

```yaml
secret:
  secret-name:
    data:
      key: value
```

---

## Full Examples

```yaml
secret:
  secret-name:
    enabled: true
    type: CustomSecretType
    labels:
      key: value
      keytpl: "{{ .Values.some.value }}"
    annotations:
      key: value
      keytpl: "{{ .Values.some.value }}"
    data:
      key: value

  other-secret-name:
    enabled: true
    namespace: some-namespace
    data:
      key: |
        multi line
        text value
```
