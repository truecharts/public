---
title: Plugin Bouncer Middleware
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares/plugin-bouncer#full-examples) section for complete examples.
- Upstream documentation for this middleware can be found [here](github.com/maxlerebourg/crowdsec-bouncer-traefik-plugin)

:::

## Appears in

- `.Values.middlewares.$name.data`

:::tip

- See available middleware keys [here](/common/middlewares).
- This options apply only when `type: plugin-bouncer`.

:::

---

## `pluginName`

Define the pluginName

|            |                                     |
| ---------- | ----------------------------------- |
| Key        | `middlewares.$name.data.pluginName` |
| Type       | `string`                            |
| Required   | ❌                                   |
| Helm `tpl` | ❌                                   |
| Default    | `bouncer`                           |

Example

```yaml
middlewares:
  middleware-name:
    data:
      pluginName: my-plugin-name
```

---

## `enabled`

Define the enabled

|            |                                  |
| ---------- | -------------------------------- |
| Key        | `middlewares.$name.data.enabled` |
| Type       | `bool`                           |
| Required   | ✅                                |
| Helm `tpl` | ❌                                |
| Default    | -                                |

Example

```yaml
middlewares:
  middleware-name:
    data:
      enabled: true
```

---

## `logLevel`

Define the logLevel

|            |                                   |
| ---------- | --------------------------------- |
| Key        | `middlewares.$name.data.logLevel` |
| Type       | `string`                          |
| Required   | ❌                                 |
| Helm `tpl` | ❌                                 |
| Default    | -                                 |

Example

```yaml
middlewares:
  middleware-name:
    data:
      logLevel: DEBUG
```

---

## `updateIntervalSeconds`

Define the updateIntervalSeconds

|            |                                                |
| ---------- | ---------------------------------------------- |
| Key        | `middlewares.$name.data.updateIntervalSeconds` |
| Type       | `int`                                          |
| Required   | ❌                                              |
| Helm `tpl` | ❌                                              |
| Default    | -                                              |

Example

```yaml
middlewares:
  middleware-name:
    data:
      updateIntervalSeconds: 60
```

---

## `updateMaxFailure`

Define the updateMaxFailure

|            |                                           |
| ---------- | ----------------------------------------- |
| Key        | `middlewares.$name.data.updateMaxFailure` |
| Type       | `int`                                     |
| Required   | ❌                                         |
| Helm `tpl` | ❌                                         |
| Default    | -                                         |

Example

```yaml
middlewares:
  middleware-name:
    data:
      updateMaxFailure: 0
```

---

## `defaultDecisionSeconds`

Define the defaultDecisionSeconds

|            |                                                 |
| ---------- | ----------------------------------------------- |
| Key        | `middlewares.$name.data.defaultDecisionSeconds` |
| Type       | `int`                                           |
| Required   | ❌                                               |
| Helm `tpl` | ❌                                               |
| Default    | -                                               |

Example

```yaml
middlewares:
  middleware-name:
    data:
      defaultDecisionSeconds: 60
```

---

## `httpTimeoutSeconds`

Define the httpTimeoutSeconds

|            |                                             |
| ---------- | ------------------------------------------- |
| Key        | `middlewares.$name.data.httpTimeoutSeconds` |
| Type       | `int`                                       |
| Required   | ❌                                           |
| Helm `tpl` | ❌                                           |
| Default    | -                                           |

Example

```yaml
middlewares:
  middleware-name:
    data:
      httpTimeoutSeconds: 10
```

---

## `crowdsecMode`

Define the crowdsecMode

|            |                                   |
| ---------- | --------------------------------- |
| Key        | `middlewares.$name.data.crowdsec` |
| Type       | `string`                          |
| Required   | ❌                                 |
| Helm `tpl` | ❌                                 |
| Default    | -                                 |

Example

```yaml
middlewares:
  middleware-name:
    data:
      crowdsecMode: live
```

---

## `crowdsecAppsecEnabled`

Define the crowdsecAppsecEnabled

|            |                                                |
| ---------- | ---------------------------------------------- |
| Key        | `middlewares.$name.data.crowdsecAppsecEnabled` |
| Type       | `bool`                                         |
| Required   | ❌                                              |
| Helm `tpl` | ❌                                              |
| Default    | -                                              |

Example

```yaml
middlewares:
  middleware-name:
    data:
      crowdsecAppsecEnabled: false
```

---

## `crowdsecAppsecHost`

Define the crowdsecAppsecHost

|            |                                             |
| ---------- | ------------------------------------------- |
| Key        | `middlewares.$name.data.crowdsecAppsecHost` |
| Type       | `string`                                    |
| Required   | ❌                                           |
| Helm `tpl` | ❌                                           |
| Default    | -                                           |

Example

```yaml
middlewares:
  middleware-name:
    data:
      crowdsecAppsecHost: crowdsec:7422
```

---

## `crowdsecAppsecFailureBlock`

Define the crowdsecAppsecFailureBlock

|            |                                                     |
| ---------- | --------------------------------------------------- |
| Key        | `middlewares.$name.data.crowdsecAppsecFailureBlock` |
| Type       | `bool`                                              |
| Required   | ❌                                                   |
| Helm `tpl` | ❌                                                   |
| Default    | -                                                   |

Example

```yaml
middlewares:
  middleware-name:
    data:
      crowdsecAppsecFailureBlock: true
```

---

## `crowdsecAppsecUnreachableBlock`

Define the crowdsecAppsecUnreachableBlock

|            |                                                         |
| ---------- | ------------------------------------------------------- |
| Key        | `middlewares.$name.data.crowdsecAppsecUnreachableBlock` |
| Type       | `bool`                                                  |
| Required   | ❌                                                       |
| Helm `tpl` | ❌                                                       |
| Default    | -                                                       |

Example

```yaml
middlewares:
  middleware-name:
    data:
      crowdsecAppsecUnreachableBlock: true
```

---

## `crowdsecLapiKey`

Define the crowdsecLapiKey

|            |                                          |
| ---------- | ---------------------------------------- |
| Key        | `middlewares.$name.data.crowdsecLapiKey` |
| Type       | `string`                                 |
| Required   | ❌                                        |
| Helm `tpl` | ❌                                        |
| Default    | -                                        |

Example

```yaml
middlewares:
  middleware-name:
    data:
      crowdsecLapiKey: privateKey-foo
```

---

## `crowdsecLapiHost`

Define the crowdsecLapiHost

|            |                                           |
| ---------- | ----------------------------------------- |
| Key        | `middlewares.$name.data.crowdsecLapiHost` |
| Type       | `string`                                  |
| Required   | ❌                                         |
| Helm `tpl` | ❌                                         |
| Default    | -                                         |

Example

```yaml
middlewares:
  middleware-name:
    data:
      crowdsecLapiHost: crowdsec:8080
```

---

## `crowdsecLapiScheme`

Define the crowdsecLapiScheme

|            |                                   |
| ---------- | --------------------------------- |
| Key        | `middlewares.$name.data.crowdsec` |
| Type       | `string`                          |
| Required   | ❌                                 |
| Helm `tpl` | ❌                                 |
| Default    | -                                 |

Example

```yaml
middlewares:
  middleware-name:
    data:
      crowdsecLapiScheme: http
```

---

## `crowdsecLapiTLSInsecureVerify`

Define the crowdsecLapiTLSInsecureVerify

|            |                                                        |
| ---------- | ------------------------------------------------------ |
| Key        | `middlewares.$name.data.crowdsecLapiTLSInsecureVerify` |
| Type       | `bool`                                                 |
| Required   | ❌                                                      |
| Helm `tpl` | ❌                                                      |
| Default    | -                                                      |

Example

```yaml
middlewares:
  middleware-name:
    data:
      crowdsecLapiTLSInsecureVerify: false
```

---

## `crowdsecCapiMachineId`

Define the crowdsecCapiMachineId

|            |                                                |
| ---------- | ---------------------------------------------- |
| Key        | `middlewares.$name.data.crowdsecCapiMachineId` |
| Type       | `string`                                       |
| Required   | ❌                                              |
| Helm `tpl` | ❌                                              |
| Default    | -                                              |

Example

```yaml
middlewares:
  middleware-name:
    data:
      crowdsecCapiMachineId: login
```

---

## `crowdsecCapiPassword`

Define the crowdsecCapiPassword

|            |                                               |
| ---------- | --------------------------------------------- |
| Key        | `middlewares.$name.data.crowdsecCapiPassword` |
| Type       | `string`                                      |
| Required   | ❌                                             |
| Helm `tpl` | ❌                                             |
| Default    | -                                             |

Example

```yaml
middlewares:
  middleware-name:
    data:
      crowdsecCapiPassword: password
```

---

## `crowdsecCapiScenarios`

Define the crowdsecCapiScenarios

|            |                                                |
| ---------- | ---------------------------------------------- |
| Key        | `middlewares.$name.data.crowdsecCapiScenarios` |
| Type       | `list` of `string`                             |
| Required   | ❌                                              |
| Helm `tpl` | ❌                                              |
| Default    | -                                              |

Example

```yaml
middlewares:
  middleware-name:
    data:
      crowdsecCapiScenarios:
        - crowdsecurity/http-path-traversal-probing
        - crowdsecurity/http-xss-probing
        - crowdsecurity/http-generic-bf
```

---

## `forwardedHeadersTrustedIPs`

Define the forwardedHeadersTrustedIPs

|            |                                                     |
| ---------- | --------------------------------------------------- |
| Key        | `middlewares.$name.data.forwardedHeadersTrustedIPs` |
| Type       | `list` of `string`                                  |
| Required   | ❌                                                   |
| Helm `tpl` | ❌                                                   |
| Default    | -                                                   |

Example

```yaml
middlewares:
  middleware-name:
    data:
      forwardedHeadersTrustedIPs:
        - 10.0.10.23/32
        - 10.0.20.0/24
```

---

## `clientTrustedIPs`

Define the clientTrustedIPs

|            |                                           |
| ---------- | ----------------------------------------- |
| Key        | `middlewares.$name.data.clientTrustedIPs` |
| Type       | `list` of `string`                        |
| Required   | ❌                                         |
| Helm `tpl` | ❌                                         |
| Default    | -                                         |

Example

```yaml
middlewares:
  middleware-name:
    data:
      clientTrustedIPs:
        - 192.168.1.0/24
```

---

## `forwardedHeadersCustomName`

Define the forwardedHeadersCustomName

|            |                                                     |
| ---------- | --------------------------------------------------- |
| Key        | `middlewares.$name.data.forwardedHeadersCustomName` |
| Type       | `string`                                            |
| Required   | ❌                                                   |
| Helm `tpl` | ❌                                                   |
| Default    | -                                                   |

Example

```yaml
middlewares:
  middleware-name:
    data:
      forwardedHeadersCustomName: X-Custom-Header
```

---

## `remediationHeadersCustomName`

Define the remediationHeadersCustomName

|            |                                                       |
| ---------- | ----------------------------------------------------- |
| Key        | `middlewares.$name.data.remediationHeadersCustomName` |
| Type       | `string`                                              |
| Required   | ❌                                                     |
| Helm `tpl` | ❌                                                     |
| Default    | -                                                     |

Example

```yaml
middlewares:
  middleware-name:
    data:
      remediationHeadersCustomName: cs-remediation
```

---

## `redisCacheEnabled`

Define the redisCacheEnabled

|            |                                            |
| ---------- | ------------------------------------------ |
| Key        | `middlewares.$name.data.redisCacheEnabled` |
| Type       | `bool`                                     |
| Required   | ❌                                          |
| Helm `tpl` | ❌                                          |
| Default    | -                                          |

Example

```yaml
middlewares:
  middleware-name:
    data:
      redisCacheEnabled: false
```

---

## `redisCacheHost`

Define the redisCacheHost

|            |                                         |
| ---------- | --------------------------------------- |
| Key        | `middlewares.$name.data.redisCacheHost` |
| Type       | `string`                                |
| Required   | ❌                                       |
| Helm `tpl` | ❌                                       |
| Default    | -                                       |

Example

```yaml
middlewares:
  middleware-name:
    data:
      redisCacheHost: "redis:6379"
```

---

## `redisCachePassword`

Define the redisCachePassword

|            |                                             |
| ---------- | ------------------------------------------- |
| Key        | `middlewares.$name.data.redisCachePassword` |
| Type       | `string`                                    |
| Required   | ❌                                           |
| Helm `tpl` | ❌                                           |
| Default    | -                                           |

Example

```yaml
middlewares:
  middleware-name:
    data:
      redisCachePassword: password
```

---

## `redisCacheDatabase`

Define the redisCacheDatabase

|            |                                             |
| ---------- | ------------------------------------------- |
| Key        | `middlewares.$name.data.redisCacheDatabase` |
| Type       | `string`                                    |
| Required   | ❌                                           |
| Helm `tpl` | ❌                                           |
| Default    | -                                           |

Example

```yaml
middlewares:
  middleware-name:
    data:
      redisCacheDatabase: "5"
```

---

## `crowdsecLapiTLSCertificateAuthority`

Define the crowdsecLapiTLSCertificateAuthority

|            |                                                              |
| ---------- | ------------------------------------------------------------ |
| Key        | `middlewares.$name.data.crowdsecLapiTLSCertificateAuthority` |
| Type       | `string`                                                     |
| Required   | ❌                                                            |
| Helm `tpl` | ❌                                                            |
| Default    | -                                                            |

Example

```yaml
middlewares:
  middleware-name:
    data:
      crowdsecLapiTLSCertificateAuthority: |-
        -----BEGIN CERTIFICATE-----
        MIIEBzCCAu+gAwIBAgICEAAwDQYJKoZIhvcNAQELBQAwgZQxCzAJBgNVBAYTAlVT
        ...
        Q0veeNzBQXg1f/JxfeA39IDIX1kiCf71tGlT
        -----END CERTIFICATE-----
```

---

## `crowdsecLapiTLSCertificateBouncer`

Define the crowdsecLapiTLSCertificateBouncer

|            |                                                            |
| ---------- | ---------------------------------------------------------- |
| Key        | `middlewares.$name.data.crowdsecLapiTLSCertificateBouncer` |
| Type       | `string`                                                   |
| Required   | ❌                                                          |
| Helm `tpl` | ❌                                                          |
| Default    | -                                                          |

Example

```yaml
middlewares:
  middleware-name:
    data:
      crowdsecLapiTLSCertificateBouncer: |-
        -----BEGIN CERTIFICATE-----
        MIIEHjCCAwagAwIBAgIUOBTs1eqkaAUcPplztUr2xRapvNAwDQYJKoZIhvcNAQEL
        ...
        RaXAnYYUVRblS1jmePemh388hFxbmrpG2pITx8B5FMULqHoj11o2Rl0gSV6tHIHz
        N2U=
        -----END CERTIFICATE-----
```

---

## `crowdsecLapiTLSCertificateBouncerKey`

Define the crowdsecLapiTLSCertificateBouncerKey

|            |                                                               |
| ---------- | ------------------------------------------------------------- |
| Key        | `middlewares.$name.data.crowdsecLapiTLSCertificateBouncerKey` |
| Type       | `string`                                                      |
| Required   | ❌                                                             |
| Helm `tpl` | ❌                                                             |
| Default    | -                                                             |

Example

```yaml
middlewares:
  middleware-name:
    data:
      crowdsecLapiTLSCertificateBouncerKey: |-
        -----BEGIN TOTALY NOT A SECRET-----
        MIIEogIBAAKCAQEAtYQnbJqifH+ZymePylDxGGLIuxzcAUU4/ajNj+qRAdI/Ux3d
        ...
        ic5cDRo6/VD3CS3MYzyBcibaGaV34nr0G/pI+KEqkYChzk/PZRA=
        -----END TOTALY NOT A SECRET-----
```

---

## `captchaProvider`

Define the captchaProvider

|            |                                          |
| ---------- | ---------------------------------------- |
| Key        | `middlewares.$name.data.captchaProvider` |
| Type       | `string`                                 |
| Required   | ❌                                        |
| Helm `tpl` | ❌                                        |
| Default    | -                                        |

Example

```yaml
middlewares:
  middleware-name:
    data:
      captchaProvider: hcaptcha
```

---

## `captchaSiteKey`

Define the captchaSiteKey

|            |                                         |
| ---------- | --------------------------------------- |
| Key        | `middlewares.$name.data.captchaSiteKey` |
| Type       | `string`                                |
| Required   | ❌                                       |
| Helm `tpl` | ❌                                       |
| Default    | -                                       |

Example

```yaml
middlewares:
  middleware-name:
    data:
      captchaSiteKey: FIXME
```

---

## `captchaSecretKey`

Define the captchaSecretKey

|            |                                           |
| ---------- | ----------------------------------------- |
| Key        | `middlewares.$name.data.captchaSecretKey` |
| Type       | `string`                                  |
| Required   | ❌                                         |
| Helm `tpl` | ❌                                         |
| Default    | -                                         |

Example

```yaml
middlewares:
  middleware-name:
    data:
      captchaSecretKey: FIXME
```

---

## `captchaGracePeriodSeconds`

Define the captchaGracePeriodSeconds

|            |                                                    |
| ---------- | -------------------------------------------------- |
| Key        | `middlewares.$name.data.captchaGracePeriodSeconds` |
| Type       | `int`                                              |
| Required   | ❌                                                  |
| Helm `tpl` | ❌                                                  |
| Default    | -                                                  |

Example

```yaml
middlewares:
  middleware-name:
    data:
      captchaGracePeriodSeconds: 1800
```

---

## `captchaHTMLFilePath`

Define the captchaHTMLFilePath

|            |                                              |
| ---------- | -------------------------------------------- |
| Key        | `middlewares.$name.data.captchaHTMLFilePath` |
| Type       | `string`                                     |
| Required   | ❌                                            |
| Helm `tpl` | ❌                                            |
| Default    | -                                            |

Example

```yaml
middlewares:
  middleware-name:
    data:
      captchaHTMLFilePath: /captcha.html
```

---

## `banHTMLFilePath`

Define the banHTMLFilePath

|            |                                          |
| ---------- | ---------------------------------------- |
| Key        | `middlewares.$name.data.banHTMLFilePath` |
| Type       | `string`                                 |
| Required   | ❌                                        |
| Helm `tpl` | ❌                                        |
| Default    | -                                        |

Example

```yaml
middlewares:
  middleware-name:
    data:
      banHTMLFilePath: /ban.html
```

---

## `captchaHTMLFilePath`

Define the captchaHTMLFilePath

|            |                                              |
| ---------- | -------------------------------------------- |
| Key        | `middlewares.$name.data.captchaHTMLFilePath` |
| Type       | `string`                                     |
| Required   | ❌                                            |
| Helm `tpl` | ❌                                            |
| Default    | -                                            |

Example

```yaml
middlewares:
  middleware-name:
    data:
      captchaHTMLFilePath: /captcha.html
```

---

## Full Examples

```yaml
middlewares:
  middleware-name:
    enabled: true
    type: plugin-bouncer
    data:
      enabled: true
      logLevel: DEBUG
      updateIntervalSeconds: 60
      updateMaxFailure: 0
      defaultDecisionSeconds: 60
      httpTimeoutSeconds: 10
      crowdsecMode: live
      crowdsecAppsecEnabled: false
      crowdsecAppsecHost: crowdsec:7422
      crowdsecAppsecFailureBlock: true
      crowdsecAppsecUnreachableBlock: true
      crowdsecLapiKey: privateKey-foo
      crowdsecLapiHost: crowdsec:8080
      crowdsecLapiScheme: http
      crowdsecLapiTLSInsecureVerify: false
      crowdsecCapiMachineId: login
      crowdsecCapiPassword: password
      crowdsecCapiScenarios:
        - crowdsecurity/http-path-traversal-probing
        - crowdsecurity/http-xss-probing
        - crowdsecurity/http-generic-bf
      forwardedHeadersTrustedIPs:
        - 10.0.10.23/32
        - 10.0.20.0/24
      clientTrustedIPs:
        - 192.168.1.0/24
      forwardedHeadersCustomName: X-Custom-Header
      remediationHeadersCustomName: cs-remediation
      redisCacheEnabled: false
      redisCacheHost: "redis:6379"
      redisCachePassword: password
      redisCacheDatabase: "5"
      crowdsecLapiTLSCertificateAuthority: |-
        -----BEGIN TOTALY NOT A CERT-----
        MIIEBzCCAu+gAwIBAgICEAAwDQYJKoZIhvcNAQELBQAwgZQxCzAJBgNVBAYTAlVT
        ...
        Q0veeNzBQXg1f/JxfeA39IDIX1kiCf71tGlT
        -----END TOTALY NOT A CERT-----
      crowdsecLapiTLSCertificateBouncer: |-
        -----BEGIN TOTALY NOT A CERT-----
        MIIEHjCCAwagAwIBAgIUOBTs1eqkaAUcPplztUr2xRapvNAwDQYJKoZIhvcNAQEL
        ...
        RaXAnYYUVRblS1jmePemh388hFxbmrpG2pITx8B5FMULqHoj11o2Rl0gSV6tHIHz
        N2U=
        -----END TOTALY NOT A CERT-----
      captchaProvider: hcaptcha
      captchaSiteKey: FIXME
      captchaSecretKey: FIXME
      captchaGracePeriodSeconds: 1800
      captchaHTMLFilePath: /captcha.html
      banHTMLFilePath: /ban.html
```
