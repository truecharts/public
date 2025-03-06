---
title: Plugin Geoblock Middleware
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares/traefik/plugin-geoblock#full-examples) section for complete examples.
- Upstream documentation for this middleware can be found [here](https://github.com/PascalMinder/geoblock)

:::

## Appears in

- `.Values.ingressMiddlewares.traefik.$name.data`

:::tip

- See available middleware keys [here](/common/middlewares).
- This options apply only when `type: plugin-geoblock`.

:::

---

## `pluginName`

Define the pluginName

|            |                                                    |
| ---------- | -------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.pluginName` |
| Type       | `string`                                           |
| Required   | ❌                                                  |
| Helm `tpl` | ❌                                                  |
| Default    | `GeoBlock`                                         |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        pluginName: my-plugin-name
```

---

## `api`

Define the api

|            |                                             |
| ---------- | ------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.api` |
| Type       | `string`                                    |
| Required   | ✅                                           |
| Helm `tpl` | ❌                                           |
| Default    | -                                           |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        api: https://api.geoblock.org/v2/geoblock
```

---

## `allowLocalRequests`

Define the allowLocalRequests

|            |                                                            |
| ---------- | ---------------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.allowLocalRequests` |
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
        allowLocalRequests: true
```

---

## `logLocalRequests`

Define the logLocalRequests

|            |                                                          |
| ---------- | -------------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.logLocalRequests` |
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
        logLocalRequests: true
```

---

## `logAllowedRequests`

Define the logAllowedRequests

|            |                                                            |
| ---------- | ---------------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.logAllowedRequests` |
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
        logAllowedRequests: true
```

---

## `logApiRequests`

Define the logApiRequests

|            |                                                        |
| ---------- | ------------------------------------------------------ |
| Key        | `ingressMiddlewares.traefik.$name.data.logApiRequests` |
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
        logApiRequests: true
```

---

## `apiTimeoutMs`

Define the apiTimeoutMs

|            |                                                      |
| ---------- | ---------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.apiTimeoutMs` |
| Type       | `int`                                                |
| Required   | ❌                                                    |
| Helm `tpl` | ❌                                                    |
| Default    | -                                                    |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        apiTimeoutMs: 1000
```

---

## `cacheSize`

Define the cacheSize

|            |                                                   |
| ---------- | ------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.cacheSize` |
| Type       | `int`                                             |
| Required   | ❌                                                 |
| Helm `tpl` | ❌                                                 |
| Default    | -                                                 |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        cacheSize: 1000
```

---

## `forceMonthlyUpdate`

Define the forceMonthlyUpdate

|            |                                                            |
| ---------- | ---------------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.forceMonthlyUpdate` |
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
        forceMonthlyUpdate: true
```

---

## `allowUnknownCountries`

Define the allowUnknownCountries

|            |                                                               |
| ---------- | ------------------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.allowUnknownCountries` |
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
        allowUnknownCountries: true
```

---

## `unknownCountryApiResponse`

Define the unknownCountryApiResponse

|            |                                                                   |
| ---------- | ----------------------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.unknownCountryApiResponse` |
| Type       | `string`                                                          |
| Required   | ❌                                                                 |
| Helm `tpl` | ❌                                                                 |
| Default    | -                                                                 |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        unknownCountryApiResponse: some-value
```

---

## `blackListMode`

Define the blackListMode

|            |                                                       |
| ---------- | ----------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.blackListMode` |
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
        blackListMode: true
```

---

## `silentStartUp`

Define the silentStartUp

|            |                                                       |
| ---------- | ----------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.silentStartUp` |
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
        silentStartUp: true
```

---

## `addCountryHeader`

Define the addCountryHeader

|            |                                                          |
| ---------- | -------------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.addCountryHeader` |
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
        addCountryHeader: true
```

---

## `countries`

Define the countries

|            |                                                   |
| ---------- | ------------------------------------------------- |
| Key        | `ingressMiddlewares.traefik.$name.data.countries` |
| Type       | `list` of `string`                                |
| Required   | ✅                                                 |
| Helm `tpl` | ❌                                                 |
| Default    | -                                                 |

Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      data:
        countries:
          - some-country
          - some-other-country
```

---

## Full Examples

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      enabled: true
      type: plugin-geoblock
      data:
        api: https://api.geoblock.org/v2/geoblock
        allowLocalRequests: true
        logLocalRequests: true
        logAllowedRequests: true
        logApiRequests: true
        apiTimeoutMs: 1000
        cacheSize: 1000
        forceMonthlyUpdate: true
        allowUnknownCountries: true
        unknownCountryApiResponse: some-value
        blackListMode: some-value
        silentStartUp: true
        addCountryHeader: true
        countries:
          - some-country
          - some-other-country
```
