---
title: Homepage Integration
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/ingress/homepage#full-examples) section for complete examples.

:::

## Appears in

- `.Values.ingress.$name.integration.homepage`

:::tip

- Replace references to `$name` with the actual name you want to use.

:::

---

## `enabled`

Enables or Disables the homepage integration

|            |                                               |
| ---------- | --------------------------------------------- |
| Key        | `ingress.$name.integrations.homepage.enabled` |
| Type       | `bool`                                        |
| Required   | ✅                                             |
| Helm `tpl` | ❌                                             |
| Default    | `false`                                       |

Example

```yaml
ingress:
  ingress-name:
    integrations:
      homepage:
        enabled: true
```

---

## `name`

Define the name for the application

:::note

Sets the `gethomepage.dev/name` annotation

:::

|            |                                            |
| ---------- | ------------------------------------------ |
| Key        | `ingress.$name.integrations.homepage.name` |
| Type       | `string`                                   |
| Required   | ❌                                          |
| Helm `tpl` | ❌                                          |
| Default    | The Release Name                           |

Example

```yaml
ingress:
  ingress-name:
    integrations:
      homepage:
        name: some-name
```

---

## `description`

Define the description for the application

:::note

Sets the `gethomepage.dev/description` annotation

:::

|            |                                                   |
| ---------- | ------------------------------------------------- |
| Key        | `ingress.$name.integrations.homepage.description` |
| Type       | `string`                                          |
| Required   | ❌                                                 |
| Helm `tpl` | ❌                                                 |
| Default    | The Description of the Chart                      |

Example

```yaml
ingress:
  ingress-name:
    integrations:
      homepage:
        description: some-description
```

---

## `group`

Define the group for the application

:::note

Sets the `gethomepage.dev/group` annotation

:::

|            |                                             |
| ---------- | ------------------------------------------- |
| Key        | `ingress.$name.integrations.homepage.group` |
| Type       | `string`                                    |
| Required   | ❌                                           |
| Helm `tpl` | ❌                                           |
| Default    | `""`                                        |

Example

```yaml
ingress:
  ingress-name:
    integrations:
      homepage:
        group: some-group
```

---

## `icon`

Define the icon for the application

:::note

Sets the `gethomepage.dev/icon` annotation

:::

|            |                                            |
| ---------- | ------------------------------------------ |
| Key        | `ingress.$name.integrations.homepage.icon` |
| Type       | `string`                                   |
| Required   | ❌                                          |
| Helm `tpl` | ❌                                          |
| Default    | The Chart Icon                             |

Example

```yaml
ingress:
  ingress-name:
    integrations:
      homepage:
        icon: some-icon
```

---

## `href`

Define the href for the application

:::note

Sets the `gethomepage.dev/href` annotation

:::

|            |                                            |
| ---------- | ------------------------------------------ |
| Key        | `ingress.$name.integrations.homepage.href` |
| Type       | `string`                                   |
| Required   | ❌                                          |
| Helm `tpl` | ❌                                          |
| Default    | The first ingress host                     |

Example

```yaml
ingress:
  ingress-name:
    integrations:
      homepage:
        href: some-href
```

---

## `weight`

Define the weight for the application

:::note

Sets the `gethomepage.dev/weight` annotation

:::

|            |                                              |
| ---------- | -------------------------------------------- |
| Key        | `ingress.$name.integrations.homepage.weight` |
| Type       | `int`                                        |
| Required   | ❌                                            |
| Helm `tpl` | ❌                                            |
| Default    | unset                                        |

Example

```yaml
ingress:
  ingress-name:
    integrations:
      homepage:
        weight: 0
```

---

## `podSelector`

Define the pods to select

:::note

Sets the `gethomepage.dev/pod-selector` annotation

:::

|            |                                                   |
| ---------- | ------------------------------------------------- |
| Key        | `ingress.$name.integrations.homepage.podSelector` |
| Type       | `list` of `string`                                |
| Required   | ❌                                                 |
| Helm `tpl` | ❌                                                 |
| Default    | `[]`                                              |

Example

```yaml
ingress:
  ingress-name:
    integrations:
      homepage:
        podSelector:
          - main
          - nginx
```

---

## `widget`

Define configuration for the widget

|            |                                              |
| ---------- | -------------------------------------------- |
| Key        | `ingress.$name.integrations.homepage.widget` |
| Type       | `map`                                        |
| Required   | ❌                                            |
| Helm `tpl` | ❌                                            |
| Default    | `{}`                                         |

Example

```yaml
ingress:
  ingress-name:
    integrations:
      homepage:
        widget: {}
```

---

### `widget.enabled`

Enables or Disables the widget

|            |                                                      |
| ---------- | ---------------------------------------------------- |
| Key        | `ingress.$name.integrations.homepage.widget.enabled` |
| Type       | `bool`                                               |
| Required   | ❌                                                    |
| Helm `tpl` | ❌                                                    |
| Default    | `true`                                               |

Example

```yaml
ingress:
  ingress-name:
    integrations:
      homepage:
        widget:
          enabled: true
```

---

### `widget.type`

Define the type of the widget

:::note

Sets the `gethomepage.dev/widget.type` annotation

:::

|            |                                                   |
| ---------- | ------------------------------------------------- |
| Key        | `ingress.$name.integrations.homepage.widget.type` |
| Type       | `string`                                          |
| Required   | ❌                                                 |
| Helm `tpl` | ❌                                                 |
| Default    | The Chart Name                                    |

Example

```yaml
ingress:
  ingress-name:
    integrations:
      homepage:
        widget:
          type: some-type
```

---

### `widget.version`

Define the version of the widget

:::note

Sets the `gethomepage.dev/widget.version` annotation

:::

|            |                                                      |
| ---------- | ---------------------------------------------------- |
| Key        | `ingress.$name.integrations.homepage.widget.version` |
| Type       | `int`                                                |
| Required   | ❌                                                    |
| Helm `tpl` | ❌                                                    |
| Default    | `1`                                                  |

Example

```yaml
ingress:
  ingress-name:
    integrations:
      homepage:
        widget:
          version: 1
```

---

### `widget.url`

Define the url for the widget

:::note

Sets the `gethomepage.dev/widget.url` annotation

:::

|            |                                                  |
| ---------- | ------------------------------------------------ |
| Key        | `ingress.$name.integrations.homepage.widget.url` |
| Type       | `string`                                         |
| Required   | ❌                                                |
| Helm `tpl` | ❌                                                |
| Default    | The first ingress host                           |

Example

```yaml
ingress:
  ingress-name:
    integrations:
      homepage:
        widget:
          url: some-url
```

---

### `widget.custom`

Define custom annotations for the widget

:::note

Sets the `gethomepage.dev/widget.$key` annotation

:::

|            |                                                     |
| ---------- | --------------------------------------------------- |
| Key        | `ingress.$name.integrations.homepage.widget.custom` |
| Type       | `map`                                               |
| Required   | ❌                                                   |
| Helm `tpl` | ❌                                                   |
| Default    | `{}`                                                |

Example

```yaml
ingress:
  ingress-name:
    integrations:
      homepage:
        widget:
          custom: {}
```

---

### `widget.customkv`

Define custom annotations for the widget as a list

|            |                                                       |
| ---------- | ----------------------------------------------------- |
| Key        | `ingress.$name.integrations.homepage.widget.customkv` |
| Type       | `list` of `map`                                       |
| Required   | ❌                                                     |
| Helm `tpl` | ❌                                                     |
| Default    | `[]`                                                  |

Example

```yaml
ingress:
  ingress-name:
    integrations:
      homepage:
        widget:
          customkv: []
```

---

## `widget.customkv[].key`

Define the key for the custom annotation

:::note

Sets the `gethomepage.dev/widget.$key` annotation

:::

|            |                                                             |
| ---------- | ----------------------------------------------------------- |
| Key        | `ingress.$name.integrations.homepage.widget.customkv[].key` |
| Type       | `string`                                                    |
| Required   | ✅                                                           |
| Helm `tpl` | ❌                                                           |
| Default    | `""`                                                        |

Example

```yaml
ingress:
  ingress-name:
    integrations:
      homepage:
        widget:
          customkv:
            - key: some-key
```

---

## `widget.customkv[].value`

Define the value for the custom annotation

|            |                                                               |
| ---------- | ------------------------------------------------------------- |
| Key        | `ingress.$name.integrations.homepage.widget.customkv[].value` |
| Type       | `string`                                                      |
| Required   | ✅                                                             |
| Helm `tpl` | ❌                                                             |
| Default    | `""`                                                          |

Example

```yaml
ingress:
  ingress-name:
    integrations:
      homepage:
        widget:
          customkv:
            - value: some-value
```

---

## Full Examples

```yaml
ingress:
  ingress-name:
    integrations:
      homepage:
        enabled: false
        name: ""
        description: ""
        group: ""
        icon: ""
        href: ""
        weight: 0
        podSelector: []
        widget:
          enabled: true
          type: ""
          url: ""
          custom:
            key: value
          customkv:
            - key: some key
              value: some value
```
