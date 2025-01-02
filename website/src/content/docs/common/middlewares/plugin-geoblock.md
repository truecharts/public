---
title: Plugin Geoblock Middleware
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/middlewares/plugin-geoblock#full-examples) section for complete examples.
- Upstream documentation for this middleware can be found [here](https://github.com/PascalMinder/geoblock)

:::

## Appears in

- `.Values.middlewares.$name.data`

:::tip

- See available middleware keys [here](/common/middlewares).
- This options apply only when `type: plugin-geoblock`.

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
| Default    | `GeoBlock`                          |

Example

```yaml
middlewares:
  middleware-name:
    data:
      pluginName: my-plugin-name
```

---

## `api`

Define the api

|            |                              |
| ---------- | ---------------------------- |
| Key        | `middlewares.$name.data.api` |
| Type       | `string`                     |
| Required   | ✅                            |
| Helm `tpl` | ❌                            |
| Default    | -                            |

Example

```yaml
middlewares:
  middleware-name:
    data:
      api: https://api.geoblock.org/v2/geoblock
```

---

## `allowLocalRequests`

Define the allowLocalRequests

|            |                                             |
| ---------- | ------------------------------------------- |
| Key        | `middlewares.$name.data.allowLocalRequests` |
| Type       | `bool`                                      |
| Required   | ❌                                           |
| Helm `tpl` | ❌                                           |
| Default    | -                                           |

Example

```yaml
middlewares:
  middleware-name:
    data:
      allowLocalRequests: true
```

---

## `logLocalRequests`

Define the logLocalRequests

|            |                                           |
| ---------- | ----------------------------------------- |
| Key        | `middlewares.$name.data.logLocalRequests` |
| Type       | `bool`                                    |
| Required   | ❌                                         |
| Helm `tpl` | ❌                                         |
| Default    | -                                         |

Example

```yaml
middlewares:
  middleware-name:
    data:
      logLocalRequests: true
```

---

## `logAllowedRequests`

Define the logAllowedRequests

|            |                                             |
| ---------- | ------------------------------------------- |
| Key        | `middlewares.$name.data.logAllowedRequests` |
| Type       | `bool`                                      |
| Required   | ❌                                           |
| Helm `tpl` | ❌                                           |
| Default    | -                                           |

Example

```yaml
middlewares:
  middleware-name:
    data:
      logAllowedRequests: true
```

---

## `logApiRequests`

Define the logApiRequests

|            |                                         |
| ---------- | --------------------------------------- |
| Key        | `middlewares.$name.data.logApiRequests` |
| Type       | `bool`                                  |
| Required   | ❌                                       |
| Helm `tpl` | ❌                                       |
| Default    | -                                       |

Example

```yaml
middlewares:
  middleware-name:
    data:
      logApiRequests: true
```

---

## `apiTimeoutMs`

Define the apiTimeoutMs

|            |                                       |
| ---------- | ------------------------------------- |
| Key        | `middlewares.$name.data.apiTimeoutMs` |
| Type       | `int`                                 |
| Required   | ❌                                     |
| Helm `tpl` | ❌                                     |
| Default    | -                                     |

Example

```yaml
middlewares:
  middleware-name:
    data:
      apiTimeoutMs: 1000
```

---

## `cacheSize`

Define the cacheSize

|            |                                    |
| ---------- | ---------------------------------- |
| Key        | `middlewares.$name.data.cacheSize` |
| Type       | `int`                              |
| Required   | ❌                                  |
| Helm `tpl` | ❌                                  |
| Default    | -                                  |

Example

```yaml
middlewares:
  middleware-name:
    data:
      cacheSize: 1000
```

---

## `forceMonthlyUpdate`

Define the forceMonthlyUpdate

|            |                                             |
| ---------- | ------------------------------------------- |
| Key        | `middlewares.$name.data.forceMonthlyUpdate` |
| Type       | `bool`                                      |
| Required   | ❌                                           |
| Helm `tpl` | ❌                                           |
| Default    | -                                           |

Example

```yaml
middlewares:
  middleware-name:
    data:
      forceMonthlyUpdate: true
```

---

## `allowUnknownCountries`

Define the allowUnknownCountries

|            |                                                |
| ---------- | ---------------------------------------------- |
| Key        | `middlewares.$name.data.allowUnknownCountries` |
| Type       | `bool`                                         |
| Required   | ❌                                              |
| Helm `tpl` | ❌                                              |
| Default    | -                                              |

Example

```yaml
middlewares:
  middleware-name:
    data:
      allowUnknownCountries: true
```

---

## `unknownCountryApiResponse`

Define the unknownCountryApiResponse

|            |                                                    |
| ---------- | -------------------------------------------------- |
| Key        | `middlewares.$name.data.unknownCountryApiResponse` |
| Type       | `string`                                           |
| Required   | ❌                                                  |
| Helm `tpl` | ❌                                                  |
| Default    | -                                                  |

Example

```yaml
middlewares:
  middleware-name:
    data:
      unknownCountryApiResponse: some-value
```

---

## `blackListMode`

Define the blackListMode

|            |                                        |
| ---------- | -------------------------------------- |
| Key        | `middlewares.$name.data.blackListMode` |
| Type       | `bool`                                 |
| Required   | ❌                                      |
| Helm `tpl` | ❌                                      |
| Default    | -                                      |

Example

```yaml
middlewares:
  middleware-name:
    data:
      blackListMode: true
```

---

## `silentStartUp`

Define the silentStartUp

|            |                                        |
| ---------- | -------------------------------------- |
| Key        | `middlewares.$name.data.silentStartUp` |
| Type       | `bool`                                 |
| Required   | ❌                                      |
| Helm `tpl` | ❌                                      |
| Default    | -                                      |

Example

```yaml
middlewares:
  middleware-name:
    data:
      silentStartUp: true
```

---

## `addCountryHeader`

Define the addCountryHeader

|            |                                           |
| ---------- | ----------------------------------------- |
| Key        | `middlewares.$name.data.addCountryHeader` |
| Type       | `bool`                                    |
| Required   | ❌                                         |
| Helm `tpl` | ❌                                         |
| Default    | -                                         |

Example

```yaml
middlewares:
  middleware-name:
    data:
      addCountryHeader: true
```

---

## `countries`

Define the countries

|            |                                    |
| ---------- | ---------------------------------- |
| Key        | `middlewares.$name.data.countries` |
| Type       | `list` of `string`                 |
| Required   | ✅                                  |
| Helm `tpl` | ❌                                  |
| Default    | -                                  |

Example

```yaml
middlewares:
  middleware-name:
    data:
      countries:
        - some-country
        - some-other-country
```

---

## Full Examples

```yaml
middlewares:
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
