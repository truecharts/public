---
title: Webhook
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/webhook#full-examples) section for complete examples.

:::

---

## Appears in

- `.Values.webhook`

## Naming scheme

- `$FullName-$WebhookName` (release-name-chart-name-webhook-name)

:::tip

- Replace references to `$name` with the actual name you want to use.

:::

---

## `webhook`

Create webhook objects

|            |           |
| ---------- | --------- |
| Key        | `webhook` |
| Type       | `map`     |
| Required   | ❌        |
| Helm `tpl` | ❌        |
| Default    | `{}`      |

Example

```yaml
webhook: {}
```

---

### `$name`

Define a webhook object with the given name

|            |                 |
| ---------- | --------------- |
| Key        | `webhook.$name` |
| Type       | `map`           |
| Required   | ✅              |
| Helm `tpl` | ❌              |
| Default    | `{}`            |

Example

```yaml
webhook:
  webhook-name: {}
```

---

#### `enabled`

Enables or Disables the webhook

|            |                         |
| ---------- | ----------------------- |
| Key        | `webhook.$name.enabled` |
| Type       | `bool`                  |
| Required   | ✅                      |
| Helm `tpl` | ✅                      |
| Default    | `false`                 |

Example

```yaml
webhook:
  webhook-name:
    enabled: true
```

---

#### `namespace`

Define the namespace for this object

|            |                           |
| ---------- | ------------------------- |
| Key        | `webhook.$name.namespace` |
| Type       | `string`                  |
| Required   | ❌                        |
| Helm `tpl` | ✅ (On value only)        |
| Default    | `""`                      |

Example

```yaml
webhook:
  webhook-name:
    namespace: some-namespace
```

---

#### `labels`

Additional labels for webhook

|            |                        |
| ---------- | ---------------------- |
| Key        | `webhook.$name.labels` |
| Type       | `map`                  |
| Required   | ❌                     |
| Helm `tpl` | ✅ (On value only)     |
| Default    | `{}`                   |

Example

```yaml
webhook:
  webhook-name:
    labels:
      key: value
      keytpl: "{{ .Values.some.value }}"
```

---

#### `annotations`

Additional annotations for webhook

|            |                             |
| ---------- | --------------------------- |
| Key        | `webhook.$name.annotations` |
| Type       | `map`                       |
| Required   | ❌                          |
| Helm `tpl` | ✅ (On value only)          |
| Default    | `{}`                        |

Example

```yaml
webhook:
  webhook-name:
    annotations:
      key: value
      keytpl: "{{ .Values.some.value }}"
```

---

#### `type`

Define the type of the webhook.

|            |                      |
| ---------- | -------------------- |
| Key        | `webhook.$name.type` |
| Type       | `string`             |
| Required   | ✅                   |
| Helm `tpl` | ✅                   |
| Default    | `""`                 |

Valid Values:

- `mutating`
- `validating`

Example

```yaml
webhook:
  webhook-name:
    type: mutating
```

---

#### `webhooks`

Define the webhooks.

|            |                          |
| ---------- | ------------------------ |
| Key        | `webhook.$name.webhooks` |
| Type       | `list` of `map`          |
| Required   | ✅                       |
| Helm `tpl` | ❌                       |
| Default    | `[]`                     |

Example

```yaml
webhook:
  webhook-name:
    webhooks: []
```

---

##### `webhooks[].name`

Define the webhook name

|            |                                 |
| ---------- | ------------------------------- |
| Key        | `webhook.$name.webhooks[].name` |
| Type       | `string`                        |
| Required   | ✅                              |
| Helm `tpl` | ✅                              |
| Default    | `""`                            |

Example

```yaml
webhook:
  webhook-name:
    webhooks:
      - name: webhook-name
```

---

##### `webhooks[].failurePolicy`

Define the failurePolicy for the webhook

|            |                                          |
| ---------- | ---------------------------------------- |
| Key        | `webhook.$name.webhooks[].failurePolicy` |
| Type       | `string`                                 |
| Required   | ❌                                       |
| Helm `tpl` | ✅                                       |
| Default    | `""`                                     |

Valid Values:

- `Ignore`
- `Fail`

Example

```yaml
webhook:
  webhook-name:
    webhooks:
      - ailurePolicy: Fail
```

---

##### `webhooks[].matchPolicy`

Define the matchPolicy for the webhook

|            |                                        |
| ---------- | -------------------------------------- |
| Key        | `webhook.$name.webhooks[].matchPolicy` |
| Type       | `string`                               |
| Required   | ❌                                     |
| Helm `tpl` | ✅                                     |
| Default    | `""`                                   |

Valid Values:

- `Exact`
- `Equivalent`

Example

```yaml
webhook:
  webhook-name:
    webhooks:
      - matchPolicy: Exact
```

---

##### `webhooks[].sideEffects`

Define the sideEffects for the webhook

|            |                                        |
| ---------- | -------------------------------------- |
| Key        | `webhook.$name.webhooks[].sideEffects` |
| Type       | `string`                               |
| Required   | ❌                                     |
| Helm `tpl` | ✅                                     |
| Default    | `""`                                   |

Valid Values:

- `None`
- `NoneOnDryRun`

Example

```yaml
webhook:
  webhook-name:
    webhooks:
      - sideEffects: None
```

---

##### `webhooks[].reinvocationPolicy`

Define the reinvocationPolicy for the webhook

|            |                                               |
| ---------- | --------------------------------------------- |
| Key        | `webhook.$name.webhooks[].reinvocationPolicy` |
| Type       | `string`                                      |
| Required   | ❌                                            |
| Helm `tpl` | ✅                                            |
| Default    | `""`                                          |

Valid Values:

- `Never`
- `IfNeeded`

Example

```yaml
webhook:
  webhook-name:
    webhooks:
      - reinvocationPolicy: Never
```

---

##### `webhooks[].timeoutSeconds`

Define the timeoutSeconds for the webhook

|            |                                           |
| ---------- | ----------------------------------------- |
| Key        | `webhook.$name.webhooks[].timeoutSeconds` |
| Type       | `int`                                     |
| Required   | ❌                                        |
| Helm `tpl` | ✅                                        |
| Default    | `""`                                      |

Example

```yaml
webhook:
  webhook-name:
    webhooks:
      - timeoutSeconds: 30
```

---

##### `webhooks[].admissionReviewVersions`

Define the admissionReviewVersions for the webhook

|            |                                                    |
| ---------- | -------------------------------------------------- |
| Key        | `webhook.$name.webhooks[].admissionReviewVersions` |
| Type       | `list` of `string`                                 |
| Required   | ✅                                                 |
| Helm `tpl` | ✅                                                 |
| Default    | `[]`                                               |

Example

```yaml
webhook:
  webhook-name:
    webhooks:
      - admissionReviewVersions:
          - v1
          - v1beta1
```

---

##### `webhooks[].clientConfig`

Define the clientConfig for the webhook

|            |                                         |
| ---------- | --------------------------------------- |
| Key        | `webhook.$name.webhooks[].clientConfig` |
| Type       | `map`                                   |
| Required   | ✅                                      |
| Helm `tpl` | ❌                                      |
| Default    | `{}`                                    |

---

###### `webhooks[].clientConfig.caBundle`

Define the caBundle in clientConfig for the webhook

|            |                                                  |
| ---------- | ------------------------------------------------ |
| Key        | `webhook.$name.webhooks[].clientConfig.caBundle` |
| Type       | `string`                                         |
| Required   | ❌                                               |
| Helm `tpl` | ✅                                               |
| Default    | `""`                                             |

Example

```yaml
webhook:
  webhook-name:
    webhooks:
      - clientConfig:
          caBundle: ""
```

###### `webhooks[].clientConfig.url`

Define the url in clientConfig for the webhook, required if service is not defined in clientConfig

|            |                                             |
| ---------- | ------------------------------------------- |
| Key        | `webhook.$name.webhooks[].clientConfig.url` |
| Type       | `string`                                    |
| Required   | ❌                                          |
| Helm `tpl` | ✅                                          |
| Default    | `""`                                        |

Example

```yaml
webhook:
  webhook-name:
    webhooks:
      - clientConfig:
          url: ""
```

---

###### `webhooks[].clientConfig.service`

Define the service in clientConfig for the webhook, required if url is not defined in clientConfig

|            |                                                 |
| ---------- | ----------------------------------------------- |
| Key        | `webhook.$name.webhooks[].clientConfig.service` |
| Type       | `map`                                           |
| Required   | ❌                                              |
| Helm `tpl` | ❌                                              |
| Default    | `{}`                                            |

Example

```yaml
webhook:
  webhook-name:
    webhooks:
      - clientConfig:
          service: {}
```

---

###### `webhooks[].clientConfig.service.name`

Define the service name in clientConfig for the webhook

|            |                                                      |
| ---------- | ---------------------------------------------------- |
| Key        | `webhook.$name.webhooks[].clientConfig.service.name` |
| Type       | `string`                                             |
| Required   | ✅                                                   |
| Helm `tpl` | ✅                                                   |
| Default    | `""`                                                 |

Example

```yaml
webhook:
  webhook-name:
    webhooks:
      - clientConfig:
          service:
            name: ""
```

---

###### `webhooks[].clientConfig.service.namespace`

Define the service namespace in clientConfig for the webhook

|            |                                                           |
| ---------- | --------------------------------------------------------- |
| Key        | `webhook.$name.webhooks[].clientConfig.service.namespace` |
| Type       | `string`                                                  |
| Required   | ✅                                                        |
| Helm `tpl` | ✅                                                        |
| Default    | `""`                                                      |

Example

```yaml
webhook:
  webhook-name:
    webhooks:
      - clientConfig:
          service:
            namespace: ""
```

---

###### `webhooks[].clientConfig.service.path`

Define the service path in clientConfig for the webhook

|            |                                                      |
| ---------- | ---------------------------------------------------- |
| Key        | `webhook.$name.webhooks[].clientConfig.service.path` |
| Type       | `string`                                             |
| Required   | ❌                                                   |
| Helm `tpl` | ✅                                                   |
| Default    | `""`                                                 |

Example

```yaml
webhook:
  webhook-name:
    webhooks:
      - clientConfig:
          service:
            path: ""
```

---

###### `webhooks[].clientConfig.service.port`

Define the service port in clientConfig for the webhook

|            |                                                      |
| ---------- | ---------------------------------------------------- |
| Key        | `webhook.$name.webhooks[].clientConfig.service.port` |
| Type       | `int`                                                |
| Required   | ❌                                                   |
| Helm `tpl` | ✅                                                   |
| Default    | unset                                                |

Example

```yaml
webhook:
  webhook-name:
    webhooks:
      - clientConfig:
          service:
            port: 443
```

---

#### `webhooks[].rules`

Define the rules for the webhook

|            |                                  |
| ---------- | -------------------------------- |
| Key        | `webhook.$name.webhooks[].rules` |
| Type       | `list` of `map`                  |
| Required   | ✅                               |
| Helm `tpl` | ❌                               |
| Default    | `[]`                             |

Example

```yaml
webhook:
  webhook-name:
    webhooks:
      - rules: []
```

---

##### `webhooks[].rules[].scope`

Define the scope of the rule for the webhook

|            |                                          |
| ---------- | ---------------------------------------- |
| Key        | `webhook.$name.webhooks[].rules[].scope` |
| Type       | `string`                                 |
| Required   | ❌                                       |
| Helm `tpl` | ✅                                       |
| Default    | `""`                                     |

Valid Values:

- `Cluster`
- `Namespaced`
- `*`

Example

```yaml
webhook:
  webhook-name:
    webhooks:
      - rules:
          - scope: Cluster
```

---

##### `webhooks[].rules[].apiGroups`

Define the apiGroups of the rule for the webhook

|            |                                              |
| ---------- | -------------------------------------------- |
| Key        | `webhook.$name.webhooks[].rules[].apiGroups` |
| Type       | `list` of `string`                           |
| Required   | ✅                                           |
| Helm `tpl` | ✅ (On entries only)                         |
| Default    | `[]`                                         |

Example

```yaml
webhook:
  webhook-name:
    webhooks:
      - rules:
          - apiGroups:
              - ""
              - "apps"
```

---

##### `webhooks[].rules[].apiVersions`

Define the apiVersions of the rule for the webhook

|            |                                                |
| ---------- | ---------------------------------------------- |
| Key        | `webhook.$name.webhooks[].rules[].apiVersions` |
| Type       | `list` of `string`                             |
| Required   | ✅                                             |
| Helm `tpl` | ✅ (On entries only)                           |
| Default    | `[]`                                           |

Example

```yaml
webhook:
  webhook-name:
    webhooks:
      - rules:
          - apiGroups:
              - v1
              - v1beta1
```

---

##### `webhooks[].rules[].operations`

Define the operations of the rule for the webhook

|            |                                               |
| ---------- | --------------------------------------------- |
| Key        | `webhook.$name.webhooks[].rules[].operations` |
| Type       | `list` of `string`                            |
| Required   | ✅                                            |
| Helm `tpl` | ✅ (On entries only)                          |
| Default    | `[]`                                          |

Example

```yaml
webhook:
  webhook-name:
    webhooks:
      - rules:
          - operations:
              - CREATE
              - UPDATE
```

---

##### `webhooks[].rules[].resources`

Define the resources of the rule for the webhook

|            |                                              |
| ---------- | -------------------------------------------- |
| Key        | `webhook.$name.webhooks[].rules[].resources` |
| Type       | `list` of `string`                           |
| Required   | ✅                                           |
| Helm `tpl` | ✅ (On entries only)                         |
| Default    | `[]`                                         |

Example

```yaml
webhook:
  webhook-name:
    webhooks:
      - rules:
          - resources:
              - pods
              - pods/status
```

---

## Full Examples

```yaml
webhook:
  webhook-name:
    enabled: true
    labels:
      key: value
      keytpl: "{{ .Values.some.value }}"
    annotations:
      key: value
      keytpl: "{{ .Values.some.value }}"
    type: mutating
    webhooks:
      - name: webhook-name
        failurePolicy: Fail
        matchPolicy: Exact
        sideEffects: None
        reinvocationPolicy: Never
        timeoutSeconds: 30
        admissionReviewVersions:
          - v1
          - v1beta1
        clientConfig:
          caBundle: ""
          url: ""
        rules:
          - scope: Cluster
            apiGroups:
              - ""
            apiVersions:
              - v1
            operations:
              - CREATE
              - UPDATE
            resources:
              - pods
              - pods/status

  other-webhook-name:
    enabled: true
    namespace: some-namespace
    type: validating
    webhooks:
      - name: other-webhook-name
        failurePolicy: Fail
        matchPolicy: Exact
        sideEffects: None
        timeoutSeconds: 30
        admissionReviewVersions:
          - v1
          - v1beta1
        clientConfig:
          caBundle: ""
          service:
            name: ""
            namespace: ""
            path: ""
            port: 443
        rules:
          - scope: Namespaced
            apiGroups:
              - ""
            apiVersions:
              - v1
            operations:
              - CREATE
              - UPDATE
            resources:
              - pods
              - pods/status
```
