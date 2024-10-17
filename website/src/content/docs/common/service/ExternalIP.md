---
title: ExternalIP
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/service/externalip#full-examples) section for complete examples.
- See the [Service](/common/service) documentation for more information

:::

## Appears in

- `.Values.service.$name`

:::tip

- See available service keys [here](/common/service).
- This options apply only when `type: ExternalIP`.

:::

---

## `externalIP`

Configure External IP type

|            |                            |
| ---------- | -------------------------- |
| Key        | `service.$name.externalIP` |
| Type       | `string`                   |
| Required   | ✅                         |
| Helm `tpl` | ✅                         |
| Default    | `""`                       |

Example

```yaml
service:
  some-service:
    externalIP: 1.2.3.4
```

---

## `useSlice`

Define whether to use `EndpointSlice` or `Endpoint`

|            |                          |
| ---------- | ------------------------ |
| Key        | `service.$name.useSlice` |
| Type       | `bool`                   |
| Required   | ❌                       |
| Helm `tpl` | ❌                       |
| Default    | `true`                   |

Example

```yaml
service:
  some-service:
    useSlice: false
```

---

## `addressType`

Define the addressType for External IP

|            |                             |
| ---------- | --------------------------- |
| Key        | `service.$name.addressType` |
| Type       | `string`                    |
| Required   | ❌                          |
| Helm `tpl` | ✅                          |
| Default    | `IPv4`                      |

Valid Values:

- `IPv4`
- `IPv6`
- `FQDN`

Example

```yaml
service:
  some-service:
    addressType: IPv6
```

---

## `appProtocol`

Define the appProtocol for External IP

|            |                             |
| ---------- | --------------------------- |
| Key        | `service.$name.appProtocol` |
| Type       | `string`                    |
| Required   | ❌                          |
| Helm `tpl` | ✅                          |
| Default    | `""`                        |

Example

```yaml
service:
  some-service:
    appProtocol: http
```

---

## Full Examples

```yaml
service:
  # Special type
  service-externalip:
    enabled: true
    primary: true
    type: ExternalIP
    useSlice: true
    externalIP: 1.1.1.1
    addressType: IPv4
    appProtocol: http
    publishNotReadyAddresses: true
    externalIPs:
      - 10.200.230.34
    sessionAffinity: ClientIP
    externalTrafficPolicy: Cluster
    ports:
      port-name:
        enabled: true
        primary: true
        targetSelector: container-name
        port: 80
        targetPort: 8080
        protocol: HTTP
```
