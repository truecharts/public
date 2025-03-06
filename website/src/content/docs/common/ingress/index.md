---
title: Ingress
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/ingress#full-examples) section for complete examples.

:::

## Appears in

- `.Values.ingress`

## Naming scheme

- Primary: `$FullName` (release-name-chart-name)
- Non-Primary: `$FullName-$IngressName` (release-name-chart-name-ingress-name)

:::tip

- Replace references to `$name` with the actual name you want to use.

:::

---

## Target Selector

- `targetSelector` (dict): Define the `service: port` to assign the ingress
- `targetSelector` (empty): Assign the ingress to the primary `service: port`

---

## `ingress`

Create Ingress objects

|            |           |
| ---------- | --------- |
| Key        | `ingress` |
| Type       | `map`     |
| Required   | ❌         |
| Helm `tpl` | ❌         |
| Default    | `{}`      |

Example

```yaml
ingress: {}
```

---

### `$name`

Define Ingress

|            |                 |
| ---------- | --------------- |
| Key        | `ingress.$name` |
| Type       | `map`           |
| Required   | ✅               |
| Helm `tpl` | ❌               |
| Default    | `{}`            |

Example

```yaml
ingress:
  ingress-name: {}
```

---

#### `enabled`

Enables or Disables the Ingress

|            |                         |
| ---------- | ----------------------- |
| Key        | `ingress.$name.enabled` |
| Type       | `bool`                  |
| Required   | ✅                       |
| Helm `tpl` | ✅                       |
| Default    | `false`                 |

Example

```yaml
ingress:
  ingress-name:
    enabled: true
```

---

#### `primary`

Define the primary ingress

|            |                         |
| ---------- | ----------------------- |
| Key        | `ingress.$name.primary` |
| Type       | `bool`                  |
| Required   | ✅                       |
| Helm `tpl` | ❌                       |
| Default    | `false`                 |

Example

```yaml
ingress:
  ingress-name:
    primary: true
```

---

#### `expandObjectName`

Define if the object name should be expanded

|            |                                  |
| ---------- | -------------------------------- |
| Key        | `ingress.$name.expandObjectName` |
| Type       | `bool`                           |
| Required   | ❌                                |
| Helm `tpl` | ❌                                |
| Default    | `false`                          |

Example

```yaml
ingress:
  ingress-name:
    expandObjectName: true
```

---

#### `required`

Define if the ingress is required

|            |                          |
| ---------- | ------------------------ |
| Key        | `ingress.$name.required` |
| Type       | `bool`                   |
| Required   | ❌                        |
| Helm `tpl` | ❌                        |
| Default    | `false`                  |

Example

```yaml
ingress:
  ingress-name:
    required: true
```

---

#### `namespace`

Define the namespace for this object

|            |                           |
| ---------- | ------------------------- |
| Key        | `ingress.$name.namespace` |
| Type       | `string`                  |
| Required   | ❌                         |
| Helm `tpl` | ✅                         |
| Default    | `""`                      |

Example

```yaml
ingress:
  ingress-name:
    namespace: some-namespace
```

---

#### `labels`

Additional labels for ingress

|            |                        |
| ---------- | ---------------------- |
| Key        | `ingress.$name.labels` |
| Type       | `map`                  |
| Required   | ❌                      |
| Helm `tpl` | ✅ (On value only)      |
| Default    | `{}`                   |

Example

```yaml
ingress:
  ingress-name:
    labels:
      key: value
```

---

#### `annotations`

Additional annotations for ingress

|            |                             |
| ---------- | --------------------------- |
| Key        | `ingress.$name.annotations` |
| Type       | `map`                       |
| Required   | ❌                           |
| Helm `tpl` | ✅ (On value only)           |
| Default    | `{}`                        |

Example

```yaml
ingress:
  ingress-name:
    annotations:
      key: value
```

---

#### `ingressClassName`

Define the ingress class name for this object

|            |                                  |
| ---------- | -------------------------------- |
| Key        | `ingress.$name.ingressClassName` |
| Type       | `string`                         |
| Required   | ❌                                |
| Helm `tpl` | ✅                                |
| Default    | `nil`                            |

Example

```yaml
ingress:
  ingress-name:
    ingressClassName: some-ingress-class-name
```

---

#### `targetSelector`

Define the `service: port` to assign the ingress

|            |                                |
| ---------- | ------------------------------ |
| Key        | `ingress.$name.targetSelector` |
| Type       | `dict`                         |
| Required   | ❌                              |
| Helm `tpl` | ❌                              |
| Default    | `{}`                           |

Example

```yaml
ingress:
  ingress-name:
    targetSelector:
      service-name: port-name
```

---

#### `hosts`

Define the hosts for this ingress

|            |                       |
| ---------- | --------------------- |
| Key        | `ingress.$name.hosts` |
| Type       | `list` of `map`       |
| Required   | ✅                     |
| Helm `tpl` | ❌                     |
| Default    | `[]`                  |

Example

```yaml
ingress:
  ingress-name:
    hosts: []
```

---

##### `hosts[].host`

Define the host for this ingress

|            |                              |
| ---------- | ---------------------------- |
| Key        | `ingress.$name.hosts[].host` |
| Type       | `string`                     |
| Required   | ✅                            |
| Helm `tpl` | ✅                            |
| Default    | `""`                         |

Example

```yaml
ingress:
  ingress-name:
    hosts:
      - host: chart-example.local
```

---

##### `hosts[].paths`

Define the paths for this ingress

|            |                               |
| ---------- | ----------------------------- |
| Key        | `ingress.$name.hosts[].paths` |
| Type       | `list` of `map`               |
| Required   | ✅                             |
| Helm `tpl` | ❌                             |
| Default    | `[]`                          |

Example

```yaml
ingress:
  ingress-name:
    hosts:
      - host: chart-example.local
        paths: []
```

---

###### `hosts[].paths[].path`

Define the path for this ingress

|            |                                      |
| ---------- | ------------------------------------ |
| Key        | `ingress.$name.hosts[].paths[].path` |
| Type       | `string`                             |
| Required   | ✅                                    |
| Helm `tpl` | ✅                                    |
| Default    | `""`                                 |

Example

```yaml
ingress:
  ingress-name:
    hosts:
      - host: chart-example.local
        paths:
          - path: /
```

---

###### `hosts[].paths[].pathType`

Define the path type for this ingress

|            |                                          |
| ---------- | ---------------------------------------- |
| Key        | `ingress.$name.hosts[].paths[].pathType` |
| Type       | `string`                                 |
| Required   | ❌                                        |
| Helm `tpl` | ✅                                        |
| Default    | `Prefix`                                 |

Example

```yaml
ingress:
  ingress-name:
    hosts:
      - host: chart-example.local
        paths:
          - path: /
            pathType: Prefix
```

---

###### `hosts[].paths[].overrideService`

Overrides the "selected" service for this path

|            |                                                 |
| ---------- | ----------------------------------------------- |
| Key        | `ingress.$name.hosts[].paths[].overrideService` |
| Type       | `dict`                                          |
| Required   | ❌                                               |
| Helm `tpl` | ❌                                               |
| Default    | `{}`                                            |

Example

```yaml
ingress:
  ingress-name:
    hosts:
      - host: chart-example.local
        paths:
          - path: /
            pathType: Prefix
            overrideService: {}
```

---

###### `hosts[].paths[].overrideService.name`

Define the service name for this path

|            |                                                      |
| ---------- | ---------------------------------------------------- |
| Key        | `ingress.$name.hosts[].paths[].overrideService.name` |
| Type       | `string`                                             |
| Required   | ✅                                                    |
| Helm `tpl` | ❌                                                    |
| Default    | `""`                                                 |

Example

```yaml
ingress:
  ingress-name:
    hosts:
      - host: chart-example.local
        paths:
          - path: /
            pathType: Prefix
            overrideService:
              name: main
```

---

###### `hosts[].paths[].overrideService.expandObjectName`

Define if the override service object name should be expanded

|            |                                                                  |
| ---------- | ---------------------------------------------------------------- |
| Key        | `ingress.$name.hosts[].paths[].overrideService.expandObjectName` |
| Type       | `bool`                                                           |
| Required   | ❌                                                                |
| Helm `tpl` | ✅                                                                |
| Default    | `true`                                                           |

Example

```yaml
ingress:
  ingress-name:
    hosts:
      - host: chart-example.local
        paths:
          - path: /
            pathType: Prefix
            overrideService:
              name: main
              expandObjectName: false
```

---

###### `hosts[].paths[].overrideService.port`

Define the service port for this path

|            |                                                      |
| ---------- | ---------------------------------------------------- |
| Key        | `ingress.$name.hosts[].paths[].overrideService.port` |
| Type       | `int`                                                |
| Required   | ✅                                                    |
| Helm `tpl` | ❌                                                    |
| Default    | unset                                                |

Example

```yaml
ingress:
  ingress-name:
    hosts:
      - host: chart-example.local
        paths:
          - path: /
            pathType: Prefix
            overrideService:
              port: 80
```

---

#### `tls`

Define the TLS for this ingress

|            |                     |
| ---------- | ------------------- |
| Key        | `ingress.$name.tls` |
| Type       | `list` of `map`     |
| Required   | ✅                   |
| Helm `tpl` | ❌                   |
| Default    | `[]`                |

Example

```yaml
ingress:
  ingress-name:
    tls: []
```

---

##### `tls[].hosts`

Define the hosts for this TLS

|            |                            |
| ---------- | -------------------------- |
| Key        | `ingress.$name.tls[].host` |
| Type       | `list` of `string`         |
| Required   | ✅                          |
| Helm `tpl` | ✅ (On each entry)          |
| Default    | `[]`                       |

Example

```yaml
ingress:
  ingress-name:
    tls:
      - hosts:
          - chart-example.local
```

---

##### `tls[].secretName`

Define the secret name for this TLS

|            |                                  |
| ---------- | -------------------------------- |
| Key        | `ingress.$name.tls[].secretName` |
| Type       | `string`                         |
| Required   | ❌                                |
| Helm `tpl` | ✅                                |
| Default    | `""`                             |

Example

```yaml
ingress:
  ingress-name:
    tls:
      - hosts:
          - chart-example.local
        secretName: chart-example-tls
```

---

##### `tls[].certificateIssuer`

Define the certificate issuer for this TLS

|            |                                         |
| ---------- | --------------------------------------- |
| Key        | `ingress.$name.tls[].certificateIssuer` |
| Type       | `string`                                |
| Required   | ❌                                       |
| Helm `tpl` | ❌                                       |
| Default    | `""`                                    |

Example

```yaml
ingress:
  ingress-name:
    tls:
      - hosts:
          - chart-example.local
        certificateIssuer: some-issuer
```

---

##### `tls[].clusterIssuer`

Define the cluster issuer for this TLS

|            |                                     |
| ---------- | ----------------------------------- |
| Key        | `ingress.$name.tls[].clusterIssuer` |
| Type       | `string`                            |
| Required   | ❌                                   |
| Helm `tpl` | ✅                                   |
| Default    | `""`                                |

Example

```yaml
ingress:
  ingress-name:
    tls:
      - hosts:
          - chart-example.local
        clusterIssuer: some-issuer
```

---

#### `integrations`

Define the integrations for this ingress

|            |                              |
| ---------- | ---------------------------- |
| Key        | `ingress.$name.integrations` |
| Type       | `map`                        |
| Required   | ❌                            |
| Helm `tpl` | ❌                            |
| Default    | `{}`                         |

Example

```yaml
ingress:
  ingress-name:
    integrations: {}
```

---

##### `integrations.certManager`

Define the cert-manager integration for this ingress

See more details in [Cert Manager Integration](/common/ingress/certmanager)

|            |                                          |
| ---------- | ---------------------------------------- |
| Key        | `ingress.$name.integrations.certManager` |
| Type       | `map`                                    |
| Required   | ❌                                        |
| Helm `tpl` | ❌                                        |
| Default    | `{}`                                     |

Example

```yaml
ingress:
  ingress-name:
    integrations:
      certManager: {}
```

---

##### `integrations.traefik`

Define the traefik integration for this ingress

See more details in [Traefik Integration](/common/ingress/traefik)

|            |                                      |
| ---------- | ------------------------------------ |
| Key        | `ingress.$name.integrations.traefik` |
| Type       | `map`                                |
| Required   | ❌                                    |
| Helm `tpl` | ❌                                    |
| Default    | `{}`                                 |

Example

```yaml
ingress:
  ingress-name:
    integrations:
      traefik: {}
```

---

##### `integrations.homepage`

Define the homepage integration for this ingress

See more details in [Homepage Integration](/common/ingress/homepage)

|            |                                       |
| ---------- | ------------------------------------- |
| Key        | `ingress.$name.integrations.homepage` |
| Type       | `map`                                 |
| Required   | ❌                                     |
| Helm `tpl` | ❌                                     |
| Default    | `{}`                                  |

Example

```yaml
ingress:
  ingress-name:
    integrations:
      homepage: {}
```

---

## Full Examples

```yaml
ingress:
  main:
    enabled: false
    primary: true
    required: false
    expandObjectName: false
    labels:
      key: value
    annotations:
      key: value
    ingressClassName: ""
    targetSelector:
      main: main
    hosts:
      - host: chart-example.local
        paths:
          - path: /
            pathType: Prefix
            overrideService:
              name: main
              port: 80
    tls:
      - hosts:
          - chart-example.local
        secretName: chart-example-tls
        # OR
        certificateIssuer: ""
    integrations:
      certManager:
        enabled: false
        certificateIssuer: ""
      traefik:
        enabled: true
        entrypoints:
          - websecure
        forceTLS: true
        middlewares:
          - name: my-middleware
            namespace: ""
      homepage:
        enabled: false
        name: ""
        description: ""
        group: ""
        icon: ""
        widget:
          type: ""
          url: ""
          custom:
            key: value
          customkv:
            - key: some key
              value: some value
```
