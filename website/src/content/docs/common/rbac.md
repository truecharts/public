---
title: RBAC
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/rbac#full-examples) section for complete examples.

:::

## Appears in

- `.Values.rbac`

## Naming scheme

- Primary: `$FullName` (release-name-chart-name)
- Non-Primary: `$FullName-$RBACName` (release-name-chart-name-RBACName)

:::tip

- Replace references to `$name` with the actual name you want to use.

:::

---

## Target Selector

- `allServiceAccounts` (bool): Whether to assign all service accounts or not to the (Cluster)RoleBinding
- `serviceAccounts` (list): Define the service account(s) to assign the (Cluster)RoleBinding
- `serviceAccounts` (empty): Assign the primary service account to the primary rbac

---

## `rbac`

Create rbac objects

|            |        |
| ---------- | ------ |
| Key        | `rbac` |
| Type       | `map`  |
| Required   | ❌     |
| Helm `tpl` | ❌     |
| Default    | `{}`   |

Example

```yaml
rbac: {}
```

---

### `$name`

Define rbac

|            |              |
| ---------- | ------------ |
| Key        | `rbac.$name` |
| Type       | `map`        |
| Required   | ✅           |
| Helm `tpl` | ❌           |
| Default    | `{}`         |

Example

```yaml
rbac:
  rbac-name: {}
```

---

#### `enabled`

Enables or Disables the rbac

|            |                      |
| ---------- | -------------------- |
| Key        | `rbac.$name.enabled` |
| Type       | `bool`               |
| Required   | ✅                   |
| Helm `tpl` | ✅                   |
| Default    | `false`              |

Example

```yaml
rbac:
  rbac-name:
    enabled: true
```

---

#### `primary`

Sets the rbac as primary

|            |                      |
| ---------- | -------------------- |
| Key        | `rbac.$name.primary` |
| Type       | `bool`               |
| Required   | ❌                   |
| Helm `tpl` | ❌                   |
| Default    | `false`              |

Example

```yaml
rbac:
  rbac-name:
    primary: true
```

---

#### `namespace`

Define the namespace for this object (Only when clusterWide is false)

|            |                        |
| ---------- | ---------------------- |
| Key        | `rbac.$name.namespace` |
| Type       | `string`               |
| Required   | ❌                     |
| Helm `tpl` | ✅                     |
| Default    | `""`                   |

Example

```yaml
rbac:
  rbac-name:
    namespace: some-namespace
```

---

#### `clusterWide`

Sets the rbac as cluster wide (ClusterRole, ClusterRoleBinding)

|            |                          |
| ---------- | ------------------------ |
| Key        | `rbac.$name.clusterWide` |
| Type       | `bool`                   |
| Required   | ❌                       |
| Helm `tpl` | ❌                       |
| Default    | `false`                  |

Example

```yaml
rbac:
  rbac-name:
    clusterWide: true
```

---

#### `labels`

Additional labels for rbac

|            |                     |
| ---------- | ------------------- |
| Key        | `rbac.$name.labels` |
| Type       | `map`               |
| Required   | ❌                  |
| Helm `tpl` | ✅ (On value only)  |
| Default    | `{}`                |

Example

```yaml
rbac:
  rbac-name:
    labels:
      key: value
```

---

#### `annotations`

Additional annotations for rbac

|            |                          |
| ---------- | ------------------------ |
| Key        | `rbac.$name.annotations` |
| Type       | `map`                    |
| Required   | ❌                       |
| Helm `tpl` | ✅ (On value only)       |
| Default    | `{}`                     |

Example

```yaml
rbac:
  rbac-name:
    annotations:
      key: value
```

---

#### `allServiceAccounts`

Whether to assign all service accounts or not to the (Cluster)RoleBinding

|            |                                 |
| ---------- | ------------------------------- |
| Key        | `rbac.$name.allServiceAccounts` |
| Type       | `bool`                          |
| Required   | ❌                              |
| Helm `tpl` | ❌                              |
| Default    | unset                           |

Example

```yaml
rbac:
  rbac-name:
    allServiceAccounts: true
```

---

#### `serviceAccounts`

Define the service account(s) to assign the (Cluster)RoleBinding

|            |                              |
| ---------- | ---------------------------- |
| Key        | `rbac.$name.serviceAccounts` |
| Type       | `list`                       |
| Required   | ❌                           |
| Helm `tpl` | ❌                           |
| Default    | `[]`                         |

Example

```yaml
rbac:
  rbac-name:
    serviceAccounts:
      - service-account-name
```

---

#### `rules`

Define the `rules` for the (Cluster)Role

|            |                    |
| ---------- | ------------------ |
| Key        | `rbac.$name.rules` |
| Type       | `list`             |
| Required   | ✅                 |
| Helm `tpl` | ❌                 |
| Default    | `[]`               |

Example

```yaml
rbac:
  rbac-name:
    rules: []
```

---

##### `rules[].apiGroups`

Define the `apiGroups` list for the `rules` for the (Cluster)Role

|            |                                |
| ---------- | ------------------------------ |
| Key        | `rbac.$name.rules[].apiGroups` |
| Type       | `list` of `string`             |
| Required   | ✅                             |
| Helm `tpl` | ✅ (On entries only)           |
| Default    | `[]`                           |

Example

```yaml
rbac:
  rbac-name:
    rules:
      apiGroups:
        - ""
        - extensions
```

---

##### `rules[].resources`

Define the `resources` list for the `rules` for the (Cluster)Role

|            |                                |
| ---------- | ------------------------------ |
| Key        | `rbac.$name.rules[].resources` |
| Type       | `list` of `string`             |
| Required   | ✅                             |
| Helm `tpl` | ✅ (On entries only)           |
| Default    | `[]`                           |

Example

```yaml
rbac:
  rbac-name:
    rules:
      resources:
        - pods
```

---

##### `rules[].resourceNames`

Define the `resourceNames` list for the `rules` for the (Cluster)Role

|            |                                    |
| ---------- | ---------------------------------- |
| Key        | `rbac.$name.rules[].resourceNames` |
| Type       | `list` of `string`                 |
| Required   | ❌                                 |
| Helm `tpl` | ✅ (On entries only)               |
| Default    | `[]`                               |

Example

```yaml
rbac:
  rbac-name:
    rules:
      resourceNames:
        - my-pod
```

---

##### `rules[].verbs`

Define the `verbs` list for the `rules` for the (Cluster)Role

|            |                            |
| ---------- | -------------------------- |
| Key        | `rbac.$name.rules[].verbs` |
| Type       | `list` of `string`         |
| Required   | ✅                         |
| Helm `tpl` | ✅ (On entries only)       |
| Default    | `[]`                       |

Example

```yaml
rbac:
  rbac-name:
    rules:
      verbs:
        - get
        - list
        - watch
```

---

#### `subjects`

Define `subjects` for (Cluster)RoleBinding

|            |                       |
| ---------- | --------------------- |
| Key        | `rbac.$name.subjects` |
| Type       | `list` of `map`       |
| Required   | ❌                    |
| Helm `tpl` | ❌                    |
| Default    | `[]`                  |

Example

```yaml
rbac:
  rbac-name:
    rules:
      subjects: []
```

---

##### `subjects[].kind`

Define the `kind` of `subjects` entry

|            |                              |
| ---------- | ---------------------------- |
| Key        | `rbac.$name.subjects[].kind` |
| Type       | `string`                     |
| Required   | ✅                           |
| Helm `tpl` | ✅                           |
| Default    | `""`                         |

Example

```yaml
rbac:
  rbac-name:
    subjects:
      - kind: my-kind
```

---

##### `subjects[].name`

Define the `name` of `subjects` entry

|            |                              |
| ---------- | ---------------------------- |
| Key        | `rbac.$name.subjects[].name` |
| Type       | `string`                     |
| Required   | ✅                           |
| Helm `tpl` | ✅                           |
| Default    | `""`                         |

Example

```yaml
rbac:
  rbac-name:
    subjects:
      - name: my-name
```

---

##### `subjects[].apiGroup`

Define the `apiGroup` of `subjects` entry

|            |                                  |
| ---------- | -------------------------------- |
| Key        | `rbac.$name.subjects[].apiGroup` |
| Type       | `string`                         |
| Required   | ✅                               |
| Helm `tpl` | ✅                               |
| Default    | `""`                             |

Example

```yaml
rbac:
  rbac-name:
    subjects:
      - apiGroup: my-api-group
```

---

## Full Examples

```yaml
rbac:
  rbac-name:
    enabled: true
    primary: true
    clusterWide: true
    labels:
      key: value
      keytpl: "{{ .Values.some.value }}"
    annotations:
      key: value
      keytpl: "{{ .Values.some.value }}"
    allServiceAccounts: true
    rules:
      - apiGroups:
          - ""
        resources:
          - "{{ .Values.some.value }}"
        resourceNames:
          - "{{ .Values.some.value }}"
        verbs:
          - get
          - "{{ .Values.some.value }}"
          - watch
    subjects:
      - kind: my-kind
        name: "{{ .Values.some.value }}"
        apiGroup: my-api-group

  other-rbac-name:
    enabled: true
    namespace: some-namespace
    serviceAccounts:
      - service-account-name
    rules:
      - apiGroups:
          - ""
        resources:
          - pods
        verbs:
          - get
          - list
          - watch
    subjects:
      - kind: my-kind
        name: my-name
        apiGroup: my-api-group
```
