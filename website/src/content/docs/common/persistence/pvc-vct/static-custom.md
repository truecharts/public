---
title: Static Custom
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/persistence/pvc-vct/static-custom#full-examples) section for complete examples.

:::

## Appears in

- `.Values.persistence.$name.static`

:::tip

- See available persistence keys [here](/common/persistence).
- This options apply only when `type: pvc` or `type: vct` and `mode: custom`.

:::

---

## `driver`

Define the custom driver

|            |                                   |
| ---------- | --------------------------------- |
| Key        | `persistence.$name.static.driver` |
| Type       | `string`                          |
| Required   | ✅                                |
| Helm `tpl` | ❌                                |
| Default    | `""`                              |

Example

```yaml
persistence:
  smb-vol:
    type: pvc
    static:
      driver: some-driver
```

---

## `provisioner`

Define the custom provisioner

|            |                                        |
| ---------- | -------------------------------------- |
| Key        | `persistence.$name.static.provisioner` |
| Type       | `string`                               |
| Required   | ✅                                     |
| Helm `tpl` | ❌                                     |
| Default    | `""`                                   |

Example

```yaml
persistence:
  smb-vol:
    type: pvc
    static:
      provisioner: some-provisioner
```

---

## Full Examples

```yaml
persistence:
  smb-vol:
    type: pvc
    static:
      mode: custom
      driver: some-driver
      provisioner: some-provisioner
```
