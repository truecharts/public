---
title: Certificate
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/certificate#full-examples) section for complete examples.

:::

## Appears in

- `.Values.certificate`

## Naming scheme

- `$FullName-$CertificateName` (release-name-chart-name-certificateName)

:::tip

- Replace references to `$name` with the actual name you want to use.

:::

---

## `certificate`

Define certificates

|            |               |
| ---------- | ------------- |
| Key        | `certificate` |
| Type       | `map`         |
| Required   | ❌            |
| Helm `tpl` | ❌            |
| Default    | `{}`          |

Example

```yaml
certificate: {}
```

---

### `$name`

Define certificate

|            |                     |
| ---------- | ------------------- |
| Key        | `certificate.$name` |
| Type       | `map`               |
| Required   | ✅                  |
| Helm `tpl` | ❌                  |
| Default    | `{}`                |

Example

```yaml
certificate:
  certificate-name: {}
```

---

#### `enabled`

Enables or Disables the certificate

|            |                             |
| ---------- | --------------------------- |
| Key        | `certificate.$name.enabled` |
| Type       | `bool`                      |
| Required   | ✅                          |
| Helm `tpl` | ✅                          |
| Default    | `false`                     |

Example

```yaml
certificate:
  certificate-name:
    enabled: true
```

---

#### `namespace`

Define the namespace for this object

|            |                               |
| ---------- | ----------------------------- |
| Key        | `certificate.$name.namespace` |
| Type       | `string`                      |
| Required   | ❌                            |
| Helm `tpl` | ✅ (On value only)            |
| Default    | `""`                          |

Example

```yaml
certificate:
  certificate-name:
    namespace: some-namespace
```

---

#### `labels`

Define the labels for this certificate

|            |                            |
| ---------- | -------------------------- |
| Key        | `certificate.$name.labels` |
| Type       | `map`                      |
| Required   | ❌                         |
| Helm `tpl` | ✅ (On value only)         |
| Default    | `{}`                       |

Example

```yaml
certificate:
  certificate-name:
    labels:
      key: value
```

---

#### `annotations`

Define the annotations for this certificate

|            |                                 |
| ---------- | ------------------------------- |
| Key        | `certificate.$name.annotations` |
| Type       | `map`                           |
| Required   | ❌                              |
| Helm `tpl` | ✅ (On value only)              |
| Default    | `{}`                            |

Example

```yaml
certificate:
  certificate-name:
    annotations:
      key: value
```

---

#### `certificateIssuer`

Define the certificate issuer for this certificate

|            |                                       |
| ---------- | ------------------------------------- |
| Key        | `certificate.$name.certificateIssuer` |
| Type       | `string`                              |
| Required   | ✅                                    |
| Helm `tpl` | ✅                                    |
| Default    | `""`                                  |

Example

```yaml
certificate:
  certificate-name:
    certificateIssuer: some-issuer
```

---

#### `hosts`

Define the hosts for this certificate

|            |                           |
| ---------- | ------------------------- |
| Key        | `certificate.$name.hosts` |
| Type       | `list` of `string`        |
| Required   | ✅                        |
| Helm `tpl` | ✅ (On each entry)        |
| Default    | `false`                   |

Example

```yaml
certificate:
  certificate-name:
    hosts:
      - host1
      - host2
```

---

#### `certificateSecretTemplate`

Define the certificate secret template for this certificate

:::note

At least one of the following keys must be defined

[`labels`](/common/certificate#labels-1), [`annotations`](/common/certificate#annotations-1)

:::

|            |                                               |
| ---------- | --------------------------------------------- |
| Key        | `certificate.$name.certificateSecretTemplate` |
| Type       | `map`                                         |
| Required   | ❌                                            |
| Helm `tpl` | ❌                                            |
| Default    | `{}`                                          |

Example

```yaml
certificate:
  certificate-name:
    certificateSecretTemplate: {}
```

---

##### `labels`

Define the labels for this certificate secret template

|            |                                                      |
| ---------- | ---------------------------------------------------- |
| Key        | `certificate.$name.certificateSecretTemplate.labels` |
| Type       | `map`                                                |
| Required   | ❌                                                   |
| Helm `tpl` | ✅ (On value only)                                   |
| Default    | `{}`                                                 |

Example

```yaml
certificate:
  certificate-name:
    certificateSecretTemplate:
      labels:
        key: value
```

---

##### `annotations`

Define the annotations for this certificate secret template

|            |                                                           |
| ---------- | --------------------------------------------------------- |
| Key        | `certificate.$name.certificateSecretTemplate.annotations` |
| Type       | `map`                                                     |
| Required   | ❌                                                        |
| Helm `tpl` | ✅ (On value only)                                        |
| Default    | `{}`                                                      |

Example

```yaml
certificate:
  certificate-name:
    certificateSecretTemplate:
      annotations:
        key: value
```

---

## Full Examples

```yaml
certificate:
  my-certificate1:
    enabled: true
    hosts:
      - "{{ .Values.host }}"
    certificateIssuer: "{{ .Values.issuer }}"
  my-certificate2:
    enabled: true
    hosts:
      - host2
    certificateIssuer: some-other-issuer
    certificateSecretTemplate:
      labels:
        label1: label1
        label2: label2
      annotations:
        annotation1: annotation1
        annotation2: annotation2
```
