---
title: Container Options
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/containeroptions#full-examples) section for complete examples.

:::

## Appears in

- `.Values.containerOptions`

## Defaults

```yaml
containerOptions:
  NVIDIA_CAPS:
    - all
```

---

## `NVIDIA_CAPS`

Defines the NVIDIA_CAPS to be passed as an environment variable to the container.

|            |                                |
| ---------- | ------------------------------ |
| Key        | `containerOptions.NVIDIA_CAPS` |
| Type       | `list` of `string`             |
| Required   | ✅                             |
| Helm `tpl` | ❌                             |
| Default    | `["all"]`                      |

Example:

```yaml
containerOptions:
  NVIDIA_CAPS:
    - compute
    - utility
```

---

## Full Examples

```yaml
containerOptions:
  NVIDIA_CAPS:
    - compute
    - utility
```
