---
title: Cert Manager Integration
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/ingress/certmanager#full-examples) section for complete examples.

:::

## Appears in

- `.Values.ingress.$name.integration.certManager`

:::tip

- Replace references to `$name` with the actual name you want to use.

:::

---

## `enabled`

Enables or Disables the cert-manager integration

|            |                                                  |
| ---------- | ------------------------------------------------ |
| Key        | `ingress.$name.integrations.certManager.enabled` |
| Type       | `bool`                                           |
| Required   | ✅                                               |
| Helm `tpl` | ❌                                               |
| Default    | `false`                                          |

Example

```yaml
ingress:
  ingress-name:
    integrations:
      certManager:
        enabled: true
```

---

## `certificateIssuer`

Define the certificate issuer for this cert-manager integration

|            |                                                            |
| ---------- | ---------------------------------------------------------- |
| Key        | `ingress.$name.integrations.certManager.certificateIssuer` |
| Type       | `string`                                                   |
| Required   | ❌                                                         |
| Helm `tpl` | ❌                                                         |
| Default    | `""`                                                       |

Example

```yaml
ingress:
  ingress-name:
    integrations:
      certManager:
        certificateIssuer: some-issuer
```

---

## Full Examples

```yaml
ingress:
  ingress-name:
    integrations:
      certManager:
        enabled: true
        certificateIssuer: some-issuer
```
