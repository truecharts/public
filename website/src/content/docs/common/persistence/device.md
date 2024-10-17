---
title: Device
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/persistence/device#full-examples) section for complete examples.

:::

## Appears in

- `.Values.persistence.$name`

:::tip

- See available persistence keys [here](/common/persistence).
- This options apply only when `type: device`.

:::

---

## Notes

Type `device` is almost identical to `hostPath`. The only difference is that when a `device` type is defined,
we take additional actions, like adding `supplementalGroups` or setting `hostPathType` automatically
to the container assigned, so it can utilize the device.

---

## `hostPath`

Define the hostPath

|            |                              |
| ---------- | ---------------------------- |
| Key        | `persistence.$name.hostPath` |
| Type       | `string`                     |
| Required   | ✅                           |
| Helm `tpl` | ✅                           |
| Default    | `""`                         |

Example

```yaml
persistence:
  device-vol:
    hostPath: /path/to/host
```

---

## `hostPathType`

Define the hostPathType

|            |                                  |
| ---------- | -------------------------------- |
| Key        | `persistence.$name.hostPathType` |
| Type       | `string`                         |
| Required   | ❌                               |
| Helm `tpl` | ✅                               |
| Default    | `""`                             |

Example

```yaml
persistence:
  device-vol:
    hostPathType: BlockDevice
```

---

## Full Examples

```yaml
persistence:
  dev-vol:
    enabled: true
    type: device
    hostPath: /path/to/host
    hostPathType: BlockDevice
```
