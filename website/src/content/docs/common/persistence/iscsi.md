---
title: iSCSI
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/persistence/iscsi#full-examples) section for complete examples.

:::

## Appears in

- `.Values.persistence.$name`

:::tip

- See available persistence keys [here](/common/persistence).
- This options apply only when `type: iscsi`.

:::

---

## `iscsi`

Define the iSCSI

|            |                           |
| ---------- | ------------------------- |
| Key        | `persistence.$name.iscsi` |
| Type       | `map`                     |
| Required   | ✅                        |
| Helm `tpl` | ❌                        |
| Default    | `{}`                      |

Example

```yaml
persistence:
  iscsi-vol:
    iscsi: {}
```

---

### `fsType`

Define the fsType

|            |                            |
| ---------- | -------------------------- |
| Key        | `persistence.$name.fsType` |
| Type       | `string`                   |
| Required   | ❌                         |
| Helm `tpl` | ✅                         |
| Default    | `""`                       |

Valid Values

- `ext4`
- `xfs`
- `ntfs`

Example

```yaml
persistence:
  iscsi-vol:
    iscsi:
      fsType: ext4
```

---

### `targetPortal`

Define the targetPortal

|            |                                  |
| ---------- | -------------------------------- |
| Key        | `persistence.$name.targetPortal` |
| Type       | `string`                         |
| Required   | ✅                               |
| Helm `tpl` | ✅                               |
| Default    | `""`                             |

Example

```yaml
persistence:
  iscsi-vol:
    iscsi:
      targetPortal: some.target.portal
```

---

### `iqn`

Define the iqn

|            |                         |
| ---------- | ----------------------- |
| Key        | `persistence.$name.iqn` |
| Type       | `string`                |
| Required   | ✅                      |
| Helm `tpl` | ✅                      |
| Default    | `""`                    |

Example

```yaml
persistence:
  iscsi-vol:
    iscsi:
      iqn: some.iqn
```

---

### `lun`

Define the lun

|            |                         |
| ---------- | ----------------------- |
| Key        | `persistence.$name.lun` |
| Type       | `int`                   |
| Required   | ✅                      |
| Helm `tpl` | ✅                      |
| Default    | `""`                    |

Example

```yaml
persistence:
  iscsi-vol:
    iscsi:
      lun: 0
```

---

### `initiatorName`

Define the initiatorName

|            |                                   |
| ---------- | --------------------------------- |
| Key        | `persistence.$name.initiatorName` |
| Type       | `string`                          |
| Required   | ❌                                |
| Helm `tpl` | ✅                                |
| Default    | `""`                              |

Example

```yaml
persistence:
  iscsi-vol:
    iscsi:
      initiatorName: some.initiator.name
```

---

### `iscsiInterface`

Define the iscsiInterface

|            |                                    |
| ---------- | ---------------------------------- |
| Key        | `persistence.$name.iscsiInterface` |
| Type       | `string`                           |
| Required   | ❌                                 |
| Helm `tpl` | ✅                                 |
| Default    | `""`                               |

Example

```yaml
persistence:
  iscsi-vol:
    iscsi:
      iscsiInterface: some.interface
```

---

### `portals`

Define the portals

|            |                             |
| ---------- | --------------------------- |
| Key        | `persistence.$name.portals` |
| Type       | `list` of `string`          |
| Required   | ❌                          |
| Helm `tpl` | ✅ (On entries only)        |
| Default    | `[]`                        |

Example

```yaml
persistence:
  iscsi-vol:
    iscsi:
      portals:
        - some.portal.1
        - some.portal.2
```

---

### `authDiscovery`

Define the authDiscovery

|            |                                         |
| ---------- | --------------------------------------- |
| Key        | `persistence.$name.iscsi.authDiscovery` |
| Type       | `map`                                   |
| Required   | ❌                                      |
| Helm `tpl` | ❌                                      |
| Default    | `{}`                                    |

Example

```yaml
persistence:
  iscsi-vol:
    iscsi:
      authDiscovery: {}
```

---

#### `authDiscovery.username`

Define the username

|            |                                                  |
| ---------- | ------------------------------------------------ |
| Key        | `persistence.$name.iscsi.authDiscovery.username` |
| Type       | `string`                                         |
| Required   | ❌                                               |
| Helm `tpl` | ✅                                               |
| Default    | `""`                                             |

Example

```yaml
persistence:
  iscsi-vol:
    iscsi:
      authDiscovery:
        username: some.username
```

---

#### `authDiscovery.password`

Define the password

|            |                                                  |
| ---------- | ------------------------------------------------ |
| Key        | `persistence.$name.iscsi.authDiscovery.password` |
| Type       | `string`                                         |
| Required   | ❌                                               |
| Helm `tpl` | ✅                                               |
| Default    | `""`                                             |

Example

```yaml
persistence:
  iscsi-vol:
    iscsi:
      authDiscovery:
        password: some.password
```

---

#### `authDiscovery.usernameInitiator`

Define the usernameInitiator

|            |                                                           |
| ---------- | --------------------------------------------------------- |
| Key        | `persistence.$name.iscsi.authDiscovery.usernameInitiator` |
| Type       | `string`                                                  |
| Required   | ❌                                                        |
| Helm `tpl` | ✅                                                        |
| Default    | `""`                                                      |

Example

```yaml
persistence:
  iscsi-vol:
    iscsi:
      authDiscovery:
        usernameInitiator: some.usernameInitiator
```

---

#### `authDiscovery.passwordInitiator`

Define the passwordInitiator

|            |                                                           |
| ---------- | --------------------------------------------------------- |
| Key        | `persistence.$name.iscsi.authDiscovery.passwordInitiator` |
| Type       | `string`                                                  |
| Required   | ❌                                                        |
| Helm `tpl` | ✅                                                        |
| Default    | `""`                                                      |

Example

```yaml
persistence:
  iscsi-vol:
    iscsi:
      authDiscovery:
        passwordInitiator: some.passwordInitiator
```

---

### `authSession`

Define the authSession

|            |                                       |
| ---------- | ------------------------------------- |
| Key        | `persistence.$name.iscsi.authSession` |
| Type       | `map`                                 |
| Required   | ❌                                    |
| Helm `tpl` | ❌                                    |
| Default    | `{}`                                  |

Example

```yaml
persistence:
  iscsi-vol:
    iscsi:
      authSession: {}
```

---

#### `authSession.username`

Define the username

|            |                                                |
| ---------- | ---------------------------------------------- |
| Key        | `persistence.$name.iscsi.authSession.username` |
| Type       | `string`                                       |
| Required   | ❌                                             |
| Helm `tpl` | ✅                                             |
| Default    | `""`                                           |

Example

```yaml
persistence:
  iscsi-vol:
    iscsi:
      authSession:
        username: some.username
```

---

#### `authSession.password`

Define the password

|            |                                                |
| ---------- | ---------------------------------------------- |
| Key        | `persistence.$name.iscsi.authSession.password` |
| Type       | `string`                                       |
| Required   | ❌                                             |
| Helm `tpl` | ✅                                             |
| Default    | `""`                                           |

Example

```yaml
persistence:
  iscsi-vol:
    iscsi:
      authSession:
        password: some.password
```

---

## Full Examples

```yaml
persistence:
  iscsi-vol:
    enabled: true
    type: iscsi
    iscsi:
      fsType: "{{ .Values.some_fsType }}"
      targetPortal: "{{ .Values.some_targetPortal }}"
      iqn: "{{ .Values.some_iqn }}"
      lun: "{{ .Values.some_lun }}"
      initiatorName: "{{ .Values.some_initiatorName }}"
      iscsiInterface: "{{ .Values.some_interface }}"
      portals:
        - "{{ index .Values.some_portals 0 }}"
        - "{{ index .Values.some_portals 1 }}"
      authSession:
        username: "{{ .Values.username }}"
        password: "{{ .Values.password }}"
        usernameInitiator: '{{ printf "%s%s" .Values.username "Initiator" }}'
        passwordInitiator: '{{ printf "%s%s" .Values.password "Initiator" }}'
  iscsi-vol2:
    enabled: true
    type: iscsi
    iscsi:
      fsType: ext4
      targetPortal: some.target.portal
      iqn: some.iqn
      lun: 0
      initiatorName: some.initiator.name
      iscsiInterface: some.interface
      portals:
        - some.portal.1
        - some.portal.2
      authDiscovery:
        username: some.username
        password: some.password
        usernameInitiator: some.usernameInitiator
        passwordInitiator: some.passwordInitiator
```
