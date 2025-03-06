---
title: Headers Middleware
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares/traefik/headers#full-examples) section for complete examples.
- Upstream documentation for this middleware can be found [here](https://doc.traefik.io/traefik/middlewares/http/headers)

:::

## Appears in

- `.Values.ingressMiddlewares.traefik.$name.data`

:::tip

- See available middleware keys [here](/common/middlewares).
- This options apply only when `type: headers`.

:::

---

## `customRequestHeaders`

Define the customRequestHeaders

|            |                                                              |
| ---------- | ------------------------------------------------------------ |
| Key        | `ingressMiddlewares.traefik.$name.data.customRequestHeaders` |
| Type       | `map`                                                        |
| Required   | ❌                                                            |
| Helm `tpl` | ❌                                                            |
| Default    | -                                                            |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        customRequestHeaders:
          some-name: some-value
          some-other-name: some-other-value
```

---

## `customResponseHeaders`

Define the customResponseHeaders

|            |                                                               |
| ---------- | ------------------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.customResponseHeaders` |
| Type       | `map`                                                         |
| Required   | ❌                                                             |
| Helm `tpl` | ❌                                                             |
| Default    | -                                                             |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        customResponseHeaders:
          some-name: some-value
          some-other-name: some-other-value
```

---

## `accessControlAllowCredentials`

Define the accessControlAllowCredentials

|            |                                                                       |
| ---------- | --------------------------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.accessControlAllowCredentials` |
| Type       | `bool`                                                                |
| Required   | ❌                                                                     |
| Helm `tpl` | ❌                                                                     |
| Default    | -                                                                     |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        accessControlAllowCredentials: true
```

---

## `accessControlAllowHeaders`

Define the accessControlAllowHeaders

|            |                                                                   |
| ---------- | ----------------------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.accessControlAllowHeaders` |
| Type       | `list` of `string`                                                |
| Required   | ❌                                                                 |
| Helm `tpl` | ❌                                                                 |
| Default    | -                                                                 |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        accessControlAllowHeaders:
          - some-header
          - some-other-header
```

---

## `accessControlAllowMethods`

Define the accessControlAllowMethods

|            |                                                                   |
| ---------- | ----------------------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.accessControlAllowMethods` |
| Type       | `list` of `string`                                                |
| Required   | ❌                                                                 |
| Helm `tpl` | ❌                                                                 |
| Default    | -                                                                 |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        accessControlAllowMethods:
          - GET
          - POST
          - PUT
          - DELETE
```

---

## `accessControlAllowOriginList`

Define the accessControlAllowOriginList

|            |                                                                      |
| ---------- | -------------------------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.accessControlAllowOriginList` |
| Type       | `list` of `string`                                                   |
| Required   | ❌                                                                    |
| Helm `tpl` | ❌                                                                    |
| Default    | -                                                                    |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        accessControlAllowOriginList:
          - some-origin
          - some-other-origin
```

---

## `accessControlAllowOriginListRegex`

Define the accessControlAllowOriginListRegex

|            |                                                                      |
| ---------- | -------------------------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.accessControlAllowOriginList` |
| Type       | `list` of `string`                                                   |
| Required   | ❌                                                                    |
| Helm `tpl` | ❌                                                                    |
| Default    | -                                                                    |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        accessControlAllowOriginListRegex:
          - some-origin-regex
          - some-other-origin-regex
```

---

## `accessControlExposeHeaders`

Define the accessControlExposeHeaders

|            |                                                                    |
| ---------- | ------------------------------------------------------------------ |
| Key        | `ingressMiddlewares.traefik.$name.data.accessControlExposeHeaders` |
| Type       | `list` of `string`                                                 |
| Required   | ❌                                                                  |
| Helm `tpl` | ❌                                                                  |
| Default    | -                                                                  |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        accessControlExposeHeaders:
          - some-header
          - some-other-header
```

---

## `accessControlMaxAge`

Define the accessControlMaxAge

|            |                                                             |
| ---------- | ----------------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.accessControlMaxAge` |
| Type       | `int`                                                       |
| Required   | ❌                                                           |
| Helm `tpl` | ❌                                                           |
| Default    | -                                                           |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        accessControlMaxAge: 1000
```

---

## `addVaryHeader`

Define the addVaryHeader

|            |                                                       |
| ---------- | ----------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.addVaryHeader` |
| Type       | `bool`                                                |
| Required   | ❌                                                     |
| Helm `tpl` | ❌                                                     |
| Default    | -                                                     |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        addVaryHeader: true
```

---

## `allowedHosts`

Define the allowedHosts

|            |                                                      |
| ---------- | ---------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.allowedHosts` |
| Type       | `list` of `string`                                   |
| Required   | ❌                                                    |
| Helm `tpl` | ❌                                                    |
| Default    | -                                                    |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        allowedHosts:
          - some-host
          - some-other-host
```

---

## `hostsProxyHeaders`

Define the hostsProxyHeaders

|            |                                                           |
| ---------- | --------------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.hostsProxyHeaders` |
| Type       | `list` of `string`                                        |
| Required   | ❌                                                         |
| Helm `tpl` | ❌                                                         |
| Default    | -                                                         |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        hostsProxyHeaders:
          - some-header
          - some-other-header
```

---

## `sslProxyHeaders`

Define the sslProxyHeaders

|            |                                                         |
| ---------- | ------------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.sslProxyHeaders` |
| Type       | `map`                                                   |
| Required   | ❌                                                       |
| Helm `tpl` | ❌                                                       |
| Default    | -                                                       |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        sslProxyHeaders:
          some-header: some-value
          some-other-header: some-other-value
```

---

## `stsSeconds`

Define the stsSeconds

|            |                                                    |
| ---------- | -------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.stsSeconds` |
| Type       | `int`                                              |
| Required   | ❌                                                  |
| Helm `tpl` | ❌                                                  |
| Default    | -                                                  |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        stsSeconds: 1000
```

---

## `stsIncludeSubdomains`

Define the stsIncludeSubdomains

|            |                                                              |
| ---------- | ------------------------------------------------------------ |
| Key        | `ingressMiddlewares.traefik.$name.data.stsIncludeSubdomains` |
| Type       | `bool`                                                       |
| Required   | ❌                                                            |
| Helm `tpl` | ❌                                                            |
| Default    | -                                                            |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        stsIncludeSubdomains: true
```

---

## `stsPreload`

Define the stsPreload

|            |                                                    |
| ---------- | -------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.stsPreload` |
| Type       | `bool`                                             |
| Required   | ❌                                                  |
| Helm `tpl` | ❌                                                  |
| Default    | -                                                  |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        stsPreload: true
```

---

## `forceSTSHeader`

Define the forceSTSHeader

|            |                                                        |
| ---------- | ------------------------------------------------------ |
| Key        | `ingressMiddlewares.traefik.$name.data.forceSTSHeader` |
| Type       | `bool`                                                 |
| Required   | ❌                                                      |
| Helm `tpl` | ❌                                                      |
| Default    | -                                                      |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        forceSTSHeader: true
```

---

## `frameDeny`

Define the frameDeny

|            |                                                   |
| ---------- | ------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.frameDeny` |
| Type       | `bool`                                            |
| Required   | ❌                                                 |
| Helm `tpl` | ❌                                                 |
| Default    | -                                                 |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        frameDeny: true
```

---

## `customFrameOptionsValue`

Define the customFrameOptionsValue

|            |                                                                 |
| ---------- | --------------------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.customFrameOptionsValue` |
| Type       | `string`                                                        |
| Required   | ❌                                                               |
| Helm `tpl` | ❌                                                               |
| Default    | -                                                               |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        customFrameOptionsValue: some-value
```

---

## `contentTypeNosniff`

Define the contentTypeNosniff

|            |                                                            |
| ---------- | ---------------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.contentTypeNosniff` |
| Type       | `bool`                                                     |
| Required   | ❌                                                          |
| Helm `tpl` | ❌                                                          |
| Default    | -                                                          |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        contentTypeNosniff: true
```

---

## `browserXssFilter`

Define the browserXssFilter

|            |                                                          |
| ---------- | -------------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.browserXssFilter` |
| Type       | `bool`                                                   |
| Required   | ❌                                                        |
| Helm `tpl` | ❌                                                        |
| Default    | -                                                        |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        browserXssFilter: true
```

---

## `customBrowserXSSValue`

Define the customBrowserXSSValue

|            |                                                               |
| ---------- | ------------------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.customBrowserXSSValue` |
| Type       | `string`                                                      |
| Required   | ❌                                                             |
| Helm `tpl` | ❌                                                             |
| Default    | -                                                             |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        customBrowserXSSValue: some-value
```

---

## `contentSecurityPolicy`

Define the contentSecurityPolicy

|            |                                                               |
| ---------- | ------------------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.contentSecurityPolicy` |
| Type       | `string`                                                      |
| Required   | ❌                                                             |
| Helm `tpl` | ❌                                                             |
| Default    | -                                                             |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        contentSecurityPolicy: some-value
```

---

## `contentSecurityPolicyReportOnly`

Define the contentSecurityPolicyReportOnly

|            |                                                               |
| ---------- | ------------------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.contentSecurityPolicy` |
| Type       | `bool`                                                        |
| Required   | ❌                                                             |
| Helm `tpl` | ❌                                                             |
| Default    | -                                                             |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        contentSecurityPolicyReportOnly: true
```

---

## `publicKey`

Define the publicKey

|            |                                                   |
| ---------- | ------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.publicKey` |
| Type       | `string`                                          |
| Required   | ❌                                                 |
| Helm `tpl` | ❌                                                 |
| Default    | -                                                 |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        publicKey: some-public-key
```

---

## `referrerPolicy`

Define the referrerPolicy

|            |                                                        |
| ---------- | ------------------------------------------------------ |
| Key        | `ingressMiddlewares.traefik.$name.data.referrerPolicy` |
| Type       | `string`                                               |
| Required   | ❌                                                      |
| Helm `tpl` | ❌                                                      |
| Default    | -                                                      |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        referrerPolicy: some-referrer-policy
```

---

## `permissionsPolicy`

Define the permissionsPolicy

|            |                                                           |
| ---------- | --------------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.permissionsPolicy` |
| Type       | `string`                                                  |
| Required   | ❌                                                         |
| Helm `tpl` | ❌                                                         |
| Default    | -                                                         |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        permissionsPolicy: some-permissions-policy
```

---

## `isDevelopment`

Define the isDevelopment

|            |                                                       |
| ---------- | ----------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.isDevelopment` |
| Type       | `bool`                                                |
| Required   | ❌                                                     |
| Helm `tpl` | ❌                                                     |
| Default    | -                                                     |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        isDevelopment: true
```

---

## Full Examples

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      enabled: true
      type: headers
      data:
        customRequestHeaders:
          some-name: some-value
          some-other-name: some-other-value
        customResponseHeaders:
          some-name: some-value
          some-other-name: some-other-value
        accessControlAllowCredentials: true
        accessControlAllowHeaders:
          - some-header
          - some-other-header
        accessControlAllowMethods:
          - GET
          - DELETE
        accessControlAllowOriginList:
          - some-origin
          - some-other-origin
        accessControlAllowOriginListRegex:
          - some-origin-regex
          - some-other-origin-regex
        accessControlExposeHeaders:
          - some-header
          - some-other-header
        accessControlMaxAge: 1000
        addVaryHeader: true
        allowedHosts:
          - some-host
          - some-other-host
        hostsProxyHeaders:
          - some-header
          - some-other-header
        sslProxyHeaders:
          some-header: some-value
          some-other-header: some-other-value
        stsSeconds: 1000
        stsIncludeSubdomains: true
        stsPreload: true
        forceSTSHeader: true
        frameDeny: true
        customFrameOptionsValue: some-value
        contentTypeNosniff: true
        browserXssFilter: true
        customBrowserXSSValue: some-value
        contentSecurityPolicy: some-value
        contentSecurityPolicyReportOnly: true
        publicKey: some-public-key
        referrerPolicy: some-referrer-policy
        permissionsPolicy: some-permissions-policy
        isDevelopment: true
```
