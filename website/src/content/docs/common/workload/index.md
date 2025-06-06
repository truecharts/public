---
title: Workload
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/workload#full-examples) section for complete examples.

:::

## Appears in

- `.Values.workload`

## Naming scheme

- Primary: `$FullName` (release-name-chart-name)
- Non-Primary: `$FullName-$WorkloadName` (release-name-chart-name-workload-name)

:::tip

Replace references to `$name` with the actual name you want to use.

:::

---

## `workload`

Define workload objects

|            |            |
| ---------- | ---------- |
| Key        | `workload` |
| Type       | `map`      |
| Required   | ❌          |
| Helm `tpl` | ❌          |
| Default    | `{}`       |

Example

```yaml
workload: {}
```

---

### `$name`

Define workload

|            |                  |
| ---------- | ---------------- |
| Key        | `workload.$name` |
| Type       | `map`            |
| Required   | ✅                |
| Helm `tpl` | ❌                |
| Default    | `{}`             |

Example

```yaml
workload:
  workload-name: {}
```

---

#### `enabled`

Enable or disable workload

|            |                          |
| ---------- | ------------------------ |
| Key        | `workload.$name.enabled` |
| Type       | `bool`                   |
| Required   | ✅                        |
| Helm `tpl` | ✅                        |
| Default    | `false`                  |

Example

```yaml
workload:
  workload-name:
    enabled: true
```

---

#### `primary`

Set workload as primary

|            |                          |
| ---------- | ------------------------ |
| Key        | `workload.$name.primary` |
| Type       | `bool`                   |
| Required   | ✅                        |
| Helm `tpl` | ❌                        |
| Default    | `false`                  |

Example

```yaml
workload:
  workload-name:
    primary: true
```

---

#### `labels`

Define labels for workload

|            |                         |
| ---------- | ----------------------- |
| Key        | `workload.$name.labels` |
| Type       | `map`                   |
| Required   | ❌                       |
| Helm `tpl` | ✅ (On value only)       |
| Default    | `{}`                    |

Example

```yaml
workload:
  workload-name:
    labels:
      key: value
```

---

#### `annotations`

Define annotations for workload

|            |                              |
| ---------- | ---------------------------- |
| Key        | `workload.$name.annotations` |
| Type       | `map`                        |
| Required   | ❌                            |
| Helm `tpl` | ✅ (On value only)            |
| Default    | `{}`                         |

Example

```yaml
workload:
  workload-name:
    annotations:
      key: value
```

---

#### `namespace`

Define the namespace for this object

|            |                            |
| ---------- | -------------------------- |
| Key        | `workload.$name.namespace` |
| Type       | `string`                   |
| Required   | ❌                          |
| Helm `tpl` | ✅ (On value only)          |
| Default    | `""`                       |

Example

```yaml
workload:
  workload-name:
    namespace: some-namespace
```

---

#### `type`

Define the kind of the workload

|            |                       |
| ---------- | --------------------- |
| Key        | `workload.$name.type` |
| Type       | `string`              |
| Required   | ✅                     |
| Helm `tpl` | ❌                     |
| Default    | `""`                  |

Valid values

- [`Deployment`](/common/workload/deployment)
- [`DaemonSet`](/common/workload/daemonset)
- [`StatefulSet`](/common/workload/statefulset)
- [`CronJob`](/common/workload/cronjob)
- [`Job`](/common/workload/job)

Example

```yaml
workload:
  workload-name:
    type: Deployment
```

---

#### `podSpec`

Define the podSpec for the workload

|            |                          |
| ---------- | ------------------------ |
| Key        | `workload.$name.podSpec` |
| Type       | `map`                    |
| Required   | ✅                        |
| Helm `tpl` | ❌                        |
| Default    | `{}`                     |

Example

```yaml
workload:
  workload-name:
    podSpec: {}
```

---

##### `labels`

Define labels for podSpec

|            |                                 |
| ---------- | ------------------------------- |
| Key        | `workload.$name.podSpec.labels` |
| Type       | `map`                           |
| Required   | ❌                               |
| Helm `tpl` | ✅ (On value only)               |
| Default    | `{}`                            |

Example

```yaml
workload:
  workload-name:
    podSpec:
      labels:
        key: value
```

---

##### `annotations`

Define annotations for podSpec

|            |                                      |
| ---------- | ------------------------------------ |
| Key        | `workload.$name.podSpec.annotations` |
| Type       | `map`                                |
| Required   | ❌                                    |
| Helm `tpl` | ✅ (On value only)                    |
| Default    | `{}`                                 |

Example

```yaml
workload:
  workload-name:
    podSpec:
      annotations:
        key: value
```

---

##### `automountServiceAccountToken`

Pod's automountServiceAccountToken

|            |                                                                     |
| ---------- | ------------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.automountServiceAccountToken`               |
| Type       | `bool`                                                              |
| Required   | ❌                                                                   |
| Helm `tpl` | ❌                                                                   |
| Default    | See default [here](/common/podoptions#automountserviceaccounttoken) |

Example

```yaml
workload:
  workload-name:
    podSpec:
      automountServiceAccountToken: true
```

---

##### `serviceAccountName`

:::note

Suggested is to use the top-level [serviceAccount](/common/serviceaccount/) key
to define the service account with `targetSelector`.

Using this key here, is out of our support scope.

:::

Define the service account name for the workload

|            |                                     |
| ---------- | ----------------------------------- |
| Key        | `workload.$name.serviceAccountName` |
| Type       | `string`                            |
| Required   | ❌                                   |
| Helm `tpl` | ✅ (On value only)                   |
| Default    | `""`                                |

Example

```yaml
workload:
  workload-name:
    serviceAccountName: some-service-account
```

Example

```yaml
workload:
  workload-name:
    podSpec:
      serviceAccountName: some-service-account
```

---

##### `hostNetwork`

Bind pod to host's network

|            |                                                    |
| ---------- | -------------------------------------------------- |
| Key        | `workload.$name.podSpec.hostNetwork`               |
| Type       | `bool`                                             |
| Required   | ❌                                                  |
| Helm `tpl` | ❌                                                  |
| Default    | See default [here](/common/podoptions#hostnetwork) |

Example

```yaml
workload:
  workload-name:
    podSpec:
      hostNetwork: true
```

##### `hostPID`

Allow pod to access host's PID namespace

|            |                                                |
| ---------- | ---------------------------------------------- |
| Key        | `workload.$name.podSpec.hostPID`               |
| Type       | `bool`                                         |
| Required   | ❌                                              |
| Helm `tpl` | ❌                                              |
| Default    | See default [here](/common/podoptions#hostpid) |

Example

```yaml
workload:
  workload-name:
    podSpec:
      hostPID: true
```

---

##### `hostIPC`

Allow pod to access host's IPC namespace

|            |                                                |
| ---------- | ---------------------------------------------- |
| Key        | `workload.$name.podSpec.hostIPC`               |
| Type       | `bool`                                         |
| Required   | ❌                                              |
| Helm `tpl` | ❌                                              |
| Default    | See default [here](/common/podoptions#hostipc) |

Example

```yaml
workload:
  workload-name:
    podSpec:
      hostIPC: true
```

---

##### `hostUsers`

Allow pod to access host's users namespace

|            |                                                  |
| ---------- | ------------------------------------------------ |
| Key        | `workload.$name.podSpec.hostUsers`               |
| Type       | `bool`                                           |
| Required   | ❌                                                |
| Helm `tpl` | ❌                                                |
| Default    | See default [here](/common/podoptions#hostusers) |

Example

```yaml
workload:
  workload-name:
    podSpec:
      hostUsers: true
```

---

##### `shareProcessNamespace`

Share Process Namespace with other containers in the pod

|            |                                                              |
| ---------- | ------------------------------------------------------------ |
| Key        | `workload.$name.podSpec.shareProcessNamespace`               |
| Type       | `bool`                                                       |
| Required   | ❌                                                            |
| Helm `tpl` | ❌                                                            |
| Default    | See default [here](/common/podoptions#shareprocessnamespace) |

Example

```yaml
workload:
  workload-name:
    podSpec:
      shareProcessNamespace: true
```

---

##### `enableServiceLinks`

Pod's enableServiceLinks

|            |                                                           |
| ---------- | --------------------------------------------------------- |
| Key        | `workload.$name.podSpec.enableServiceLinks`               |
| Type       | `bool`                                                    |
| Required   | ❌                                                         |
| Helm `tpl` | ❌                                                         |
| Default    | See default [here](/common/podoptions#enableservicelinks) |

Example

```yaml
workload:
  workload-name:
    podSpec:
      enableServiceLinks: true
```

---

##### `restartPolicy`

Pod's restartPolicy

|            |                                                      |
| ---------- | ---------------------------------------------------- |
| Key        | `workload.$name.podSpec.restartPolicy`               |
| Type       | `string`                                             |
| Required   | ❌                                                    |
| Helm `tpl` | ✅                                                    |
| Default    | See default [here](/common/podoptions#restartpolicy) |

Valid values

- `Always`
- `Never`
- `OnFailure`

Example

```yaml
workload:
  workload-name:
    podSpec:
      restartPolicy: OnFailure
```

---

##### `schedulerName`

Pod's schedulerName

|            |                                                      |
| ---------- | ---------------------------------------------------- |
| Key        | `workload.$name.podSpec.schedulerName`               |
| Type       | `string`                                             |
| Required   | ❌                                                    |
| Helm `tpl` | ✅                                                    |
| Default    | See default [here](/common/podoptions#schedulername) |

Example

```yaml
workload:
  workload-name:
    podSpec:
      schedulerName: some-scheduler
```

---

##### `priorityClassName`

Pod's priorityClassName

|            |                                                          |
| ---------- | -------------------------------------------------------- |
| Key        | `workload.$name.podSpec.priorityClassName`               |
| Type       | `string`                                                 |
| Required   | ❌                                                        |
| Helm `tpl` | ✅                                                        |
| Default    | See default [here](/common/podoptions#priorityclassname) |

Example

```yaml
workload:
  workload-name:
    podSpec:
      priorityClassName: some-priority-class-name
```

---

##### `hostname`

Pod's hostname

|            |                                   |
| ---------- | --------------------------------- |
| Key        | `workload.$name.podSpec.hostname` |
| Type       | `string`                          |
| Required   | ❌                                 |
| Helm `tpl` | ✅                                 |
| Default    | `""`                              |

Example

```yaml
workload:
  workload-name:
    podSpec:
      hostname: some-hostname
```

---

##### `terminationGracePeriodSeconds`

Pod's terminationGracePeriodSeconds

|            |                                                                      |
| ---------- | -------------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.terminationGracePeriodSeconds`               |
| Type       | `int`                                                                |
| Required   | ❌                                                                    |
| Helm `tpl` | ✅                                                                    |
| Default    | See default [here](/common/podoptions#terminationgraceperiodseconds) |

Example

```yaml
workload:
  workload-name:
    podSpec:
      terminationGracePeriodSeconds: 100
```

---

##### `nodeSelector`

Pod's nodeSelector

|            |                                                     |
| ---------- | --------------------------------------------------- |
| Key        | `workload.$name.podSpec.nodeSelector`               |
| Type       | `map`                                               |
| Required   | ❌                                                   |
| Helm `tpl` | ✅ (On value only)                                   |
| Default    | See default [here](/common/podoptions#nodeselector) |

Example

```yaml
workload:
  workload-name:
    podSpec:
      nodeSelector:
        disk_type: ssd
```

---

##### `topologySpreadConstraints`

Pod's topologySpreadConstraints

|            |                                                                  |
| ---------- | ---------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.topologySpreadConstraints`               |
| Type       | `list` of `map`                                                  |
| Required   | ❌                                                                |
| Helm `tpl` | ❌                                                                |
| Default    | See default [here](/common/podoptions#topologyspreadconstraints) |

---

##### `hostAliases`

Pod's hostAliases

|            |                                                    |
| ---------- | -------------------------------------------------- |
| Key        | `workload.$name.podSpec.hostAliases`               |
| Type       | `list` of `map`                                    |
| Required   | ❌                                                  |
| Helm `tpl` | ❌                                                  |
| Default    | See default [here](/common/podoptions#hostaliases) |

Example

```yaml
workload:
  workload-name:
    podSpec:
      hostAliases: []
```

---

###### `ip`

Pod's hostAliases ip

|            |                                         |
| ---------- | --------------------------------------- |
| Key        | `workload.$name.podSpec.hostAliases.ip` |
| Type       | `string`                                |
| Required   | ✅                                       |
| Helm `tpl` | ✅                                       |
| Default    | `""`                                    |

Example

```yaml
workload:
  workload-name:
    podSpec:
      hostAliases:
        - ip: 1.2.3.4
```

---

###### `hostnames`

Pod's hostAliases hostnames

|            |                                                |
| ---------- | ---------------------------------------------- |
| Key        | `workload.$name.podSpec.hostAliases.hostnames` |
| Type       | `list` of `string`                             |
| Required   | ✅                                              |
| Helm `tpl` | ✅ (On each entry)                              |
| Default    | `[]`                                           |

Example

```yaml
workload:
  workload-name:
    podSpec:
      hostAliases:
        - ip: 1.2.3.4
          hostnames:
            - myserver.local
            - storage.local
```

---

###### `dnsPolicy`

Pod's dnsPolicy

:::note

`dnsPolicy` is set automatically to `ClusterFirstWithHostNet` when `hostNetwork` is `true`

:::

|            |                                                  |
| ---------- | ------------------------------------------------ |
| Key        | `workload.$name.podSpec.dnsPolicy`               |
| Type       | `string`                                         |
| Required   | ❌                                                |
| Helm `tpl` | ✅                                                |
| Default    | See default [here](/common/podoptions#dnspolicy) |

Valid values

- `None`
- `Default`
- `ClusterFirst`
- `ClusterFirstWithHostNet`

Example

```yaml
workload:
  workload-name:
    podSpec:
      dnsPolicy: ClusterFirst
```

---

###### `dnsConfig`

Pod's dnsConfig

|            |                                                  |
| ---------- | ------------------------------------------------ |
| Key        | `workload.$name.podSpec.dnsConfig`               |
| Type       | `map`                                            |
| Required   | ❌                                                |
| Helm `tpl` | ❌                                                |
| Default    | See default [here](/common/podoptions#dnsconfig) |

Example

```yaml
workload:
  workload-name:
    podSpec:
      dnsConfig: {}
```

---

###### `dnsConfig.nameservers`

Pod's dnsConfig nameservers

|            |                                                |
| ---------- | ---------------------------------------------- |
| Key        | `workload.$name.podSpec.dnsConfig.nameservers` |
| Type       | `list` of `string`                             |
| Required   | ❌                                              |
| Helm `tpl` | ✅ (On each entry)                              |
| Default    | `[]`                                           |

Example

```yaml
workload:
  workload-name:
    podSpec:
      dnsConfig:
        nameservers:
          - 1.1.1.1
```

---

###### `dnsConfig.searches`

Pod's dnsConfig searches

|            |                                             |
| ---------- | ------------------------------------------- |
| Key        | `workload.$name.podSpec.dnsConfig.searches` |
| Type       | `list` of `string`                          |
| Required   | ❌                                           |
| Helm `tpl` | ✅ (On each entry)                           |
| Default    | `[]`                                        |

Example

```yaml
workload:
  workload-name:
    podSpec:
      dnsConfig:
        searches:
          - ns1.svc.cluster-domain.example
```

---

###### `dnsConfig.options`

Pod's dnsConfig options

|            |                                            |
| ---------- | ------------------------------------------ |
| Key        | `workload.$name.podSpec.dnsConfig.options` |
| Type       | `list` of `map`                            |
| Required   | ❌                                          |
| Helm `tpl` | ❌                                          |
| Default    | `[{"ndots": "1"}]`                         |

Example

```yaml
workload:
  workload-name:
    podSpec:
      dnsConfig:
        options: []
```

---

###### `dnsConfig.options.name`

Pod's dnsConfig options name

|            |                                                 |
| ---------- | ----------------------------------------------- |
| Key        | `workload.$name.podSpec.dnsConfig.options.name` |
| Type       | `string`                                        |
| Required   | ✅                                               |
| Helm `tpl` | ✅                                               |
| Default    | `""`                                            |

Example

```yaml
workload:
  workload-name:
    podSpec:
      dnsConfig:
        options:
          - name: ndots
            value: "1"
```

---

###### `dnsConfig.options.value`

Pod's dnsConfig options value

|            |                                                  |
| ---------- | ------------------------------------------------ |
| Key        | `workload.$name.podSpec.dnsConfig.options.value` |
| Type       | `string`                                         |
| Required   | ❌                                                |
| Helm `tpl` | ✅                                                |
| Default    | `""`                                             |

Example

```yaml
workload:
  workload-name:
    podSpec:
      dnsConfig:
        options:
          - name: ndots
            value: "1"
```

---

##### `tolerations`

Pod's tolerations

|            |                                                    |
| ---------- | -------------------------------------------------- |
| Key        | `workload.$name.podSpec.tolerations`               |
| Type       | `list` of `map`                                    |
| Required   | ❌                                                  |
| Helm `tpl` | ❌                                                  |
| Default    | See default [here](/common/podoptions#tolerations) |

Example

```yaml
workload:
  workload-name:
    podSpec:
      tolerations: []
```

---

###### `tolerations.operator`

Pod's tolerations operator

|            |                                               |
| ---------- | --------------------------------------------- |
| Key        | `workload.$name.podSpec.tolerations.operator` |
| Type       | `string`                                      |
| Required   | ✅                                             |
| Helm `tpl` | ✅                                             |
| Default    | `""`                                          |

Valid values

- `Equal`
- `Exists`

Example

```yaml
workload:
  workload-name:
    podSpec:
      tolerations:
        - operator: Exists
```

---

###### `tolerations.key`

Pod's tolerations key

:::note

Required only when `operator` = `Equal`

:::

|            |                                          |
| ---------- | ---------------------------------------- |
| Key        | `workload.$name.podSpec.tolerations.key` |
| Type       | `string`                                 |
| Required   | ❌/✅                                      |
| Helm `tpl` | ✅                                        |
| Default    | `""`                                     |

Example

```yaml
workload:
  workload-name:
    podSpec:
      tolerations:
        - operator: Equal
          key: key
```

---

###### `tolerations.value`

Pod's tolerations value

:::note

Required only when `operator` = `Equal`

:::

|            |                                            |
| ---------- | ------------------------------------------ |
| Key        | `workload.$name.podSpec.tolerations.value` |
| Type       | `string`                                   |
| Required   | ❌/✅                                        |
| Helm `tpl` | ✅                                          |
| Default    | `""`                                       |

Example

```yaml
workload:
  workload-name:
    podSpec:
      tolerations:
        - operator: Equal
          key: key
          value: value
```

---

###### `tolerations.effect`

Pod's tolerations effect

|            |                                             |
| ---------- | ------------------------------------------- |
| Key        | `workload.$name.podSpec.tolerations.effect` |
| Type       | `string`                                    |
| Required   | ❌                                           |
| Helm `tpl` | ✅                                           |
| Default    | `""`                                        |

Valid values

- `NoExecute`
- `NoSchedule`
- `PreferNoSchedule`

Example

```yaml
workload:
  workload-name:
    podSpec:
      tolerations:
        - operator: Exists
          effect: NoExecute
```

---

###### `tolerations.tolerationSeconds`

Pod's tolerations tolerationSeconds

|            |                                                        |
| ---------- | ------------------------------------------------------ |
| Key        | `workload.$name.podSpec.tolerations.tolerationSeconds` |
| Type       | `int`                                                  |
| Required   | ❌                                                      |
| Helm `tpl` | ❌                                                      |
| Default    | unset                                                  |

Example

```yaml
workload:
  workload-name:
    podSpec:
      tolerations:
        - operator: Exists
          effect: NoExecute
          tolerationSeconds: 3600
```

---

##### `runtimeClassName`

Pod's runtimeClassName

:::note

> Note that it will only set the `runtimeClassName` on the pod that this container belongs to.

:::

|            |                                                         |
| ---------- | ------------------------------------------------------- |
| Key        | `workload.$name.podSpec.runtimeClassName`               |
| Type       | `string`                                                |
| Required   | ❌                                                       |
| Helm `tpl` | ✅                                                       |
| Default    | See default [here](/common/podoptions#runtimeclassname) |

Example

```yaml
workload:
  workload-name:
    podSpec:
      runtimeClassName: some-runtime-class
```

---

##### `securityContext`

Pod's securityContext

|            |                                                                |
| ---------- | -------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.securityContext`                       |
| Type       | `map`                                                          |
| Required   | ❌                                                              |
| Helm `tpl` | ❌                                                              |
| Default    | See default [here](/common/securitycontext#securitycontextpod) |

Default

```yaml
securityContext:
  pod:
    fsGroup: 568
    fsGroupChangePolicy: OnRootMismatch
    supplementalGroups:
      - 568
```

Example

```yaml
workload:
  workload-name:
    podSpec:
      securityContext: {}
```

---

###### `securityContext.fsGroup`

Pod's securityContext fsGroup

|            |                                                                        |
| ---------- | ---------------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.securityContext.fsGroup`                       |
| Type       | `int`                                                                  |
| Required   | ❌                                                                      |
| Helm `tpl` | ❌                                                                      |
| Default    | See default [here](/common/securitycontext/#securitycontextpodfsgroup) |

Example

```yaml
workload:
  workload-name:
    podSpec:
      securityContext:
        fsGroup: 568
```

---

###### `securityContext.fsGroupChangePolicy`

Pod's securityContext fsGroupChangePolicy

|            |                                                                                   |
| ---------- | --------------------------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.securityContext.fsGroupChangePolicy`                      |
| Type       | `string`                                                                          |
| Required   | ❌                                                                                 |
| Helm `tpl` | ❌                                                                                 |
| Default    | See default [here](/common/securitycontext#securitycontextpodfsgroupchangepolicy) |

Valid values

- `Always`
- `OnRootMismatch`

Example

```yaml
workload:
  workload-name:
    podSpec:
      securityContext:
        fsGroupChangePolicy: OnRootMismatch
```

---

###### `securityContext.supplementalGroups`

Pod's securityContext supplementalGroups

|            |                                                                                  |
| ---------- | -------------------------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.securityContext.supplementalGroups`                      |
| Type       | `list` of `int`                                                                  |
| Required   | ❌                                                                                |
| Helm `tpl` | ❌                                                                                |
| Default    | See default [here](/common/securitycontext#securitycontextpodsupplementalgroups) |

Example

```yaml
workload:
  workload-name:
    podSpec:
      securityContext:
        supplementalGroups:
          - 568
```

---

###### `securityContext.sysctls`

:::note

The **sysctl** `net.ipv4.ip_unprivileged_port_start` option will be automatically
set to the lowest `targetPort` (or `port` if targetPort is not defined) number assigned
to the pod. When hostNetwork is enabled the above **sysctl** option will not be added.

:::

|            |                                                                       |
| ---------- | --------------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.securityContext.sysctls`                      |
| Type       | `list` of `map`                                                       |
| Required   | ❌                                                                     |
| Helm `tpl` | ❌                                                                     |
| Default    | See default [here](/common/securitycontext#securitycontextpodsysctls) |

Example

```yaml
workload:
  workload-name:
    podSpec:
      securityContext:
        sysctls: []
```

---

###### `securityContext.sysctls.name`

Pod's securityContext sysctls name

|            |                                                       |
| ---------- | ----------------------------------------------------- |
| Key        | `workload.$name.podSpec.securityContext.sysctls.name` |
| Type       | `string`                                              |
| Required   | ✅                                                     |
| Helm `tpl` | ✅                                                     |
| Default    | `""`                                                  |

Example

```yaml
workload:
  workload-name:
    podSpec:
      securityContext:
        sysctls:
          - name: net.ipv4.ip_local_port_range
            value: 1024 65535
```

---

###### `securityContext.sysctls.value`

Pod's securityContext sysctls value

|            |                                                        |
| ---------- | ------------------------------------------------------ |
| Key        | `workload.$name.podSpec.securityContext.sysctls.value` |
| Type       | `string`                                               |
| Required   | ✅                                                      |
| Helm `tpl` | ✅                                                      |
| Default    | `""`                                                   |

Example

```yaml
workload:
  workload-name:
    podSpec:
      securityContext:
        sysctls:
          - name: net.ipv4.ip_local_port_range
            value: 1024 65535
```

---

##### `containers`

Define container(s) for the workload

See [Container](/common/container/) for more information

|            |                             |
| ---------- | --------------------------- |
| Key        | `workload.$name.containers` |
| Type       | `map`                       |
| Required   | ❌                           |
| Helm `tpl` | ❌                           |
| Default    | `{}`                        |

Example

```yaml
workload:
  workload-name:
    containers: {}
```

---

##### `initContainers`

Define initContainer(s) for the workload

See [Container](/common/container/) for more information

|            |                                 |
| ---------- | ------------------------------- |
| Key        | `workload.$name.initContainers` |
| Type       | `map`                           |
| Required   | ❌                               |
| Helm `tpl` | ❌                               |
| Default    | `{}`                            |

Example

```yaml
workload:
  workload-name:
    initContainers: {}
```

---

## Full Examples

```yaml
workload:
  workload-name:
    enabled: true
    primary: true
    namespace: some-namespace
    labels:
      key: value
    annotations:
      key: value
    podSpec:
      labels:
        key: value
      annotations:
        key: value
      automountServiceAccountToken: true
      hostNetwork: false
      hostPID: false
      shareProcessNamespace: false
      enableServiceLinks: false
      schedulerName: some-scheduler
      priorityClassName: some-priority-class-name
      hostname: some-hostname
      terminationGracePeriodSeconds: 100
      nodeSelector:
        disk_type: ssd
      hostAliases:
        - ip: 10.10.10.100
          hostnames:
            - myserver.local
            - storage.local
        - ip: 10.10.10.101
          hostnames:
            - myotherserver.local
            - backups.local
      dnsPolicy: ClusterFirst
      dnsConfig:
        nameservers:
          - 1.1.1.1
          - 1.0.0.1
        searches:
          - ns1.svc.cluster-domain.example
          - my.dns.search.suffix
        options:
          - name: ndots
            value: "1"
          - name: edns0
      tolerations:
        - operator: Exists
          effect: NoExecute
          tolerationSeconds: 3600
      runtimeClassName: some-runtime-class
      securityContext:
        fsGroup: 568
        fsGroupChangePolicy: OnRootMismatch
        supplementalGroups:
          - 568
        sysctls:
          - name: net.ipv4.ip_local_port_range
            value: 1024 65535
```

Full examples for each workload type can be found here

- [`Deployment`](/common/workload/deployment)
- [`DaemonSet`](/common/workload/daemonset)
- [`StatefulSet`](/common/workload/statefulset)
- [`CronJob`](/common/workload/cronjob)
- [`Job`](/common/workload/job)
