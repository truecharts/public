---
title: Resources
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/resources#full-examples) section for complete examples.

:::

## Appears in

- `.Values.resources`

## Defaults

```yaml
resources:
  limits:
    cpu: 4000m
    memory: 8Gi
  requests:
    cpu: 10m
    memory: 50Mi
```

---

## `resources.limits`

See [Resources Limits](/common/container/resources#resourceslimits)

Default

```yaml
resources:
  limits:
    cpu: 4000m
    memory: 8Gi
```

---

### `resources.limits.cpu`

See [Resources Limits CPU](/common/container/resources#resourceslimitscpu)

Default

```yaml
resources:
  limits:
    cpu: 4000m
```

---

### `resources.limits.memory`

See [Resources Limits Memory](/common/container/resources#resourceslimitsmemory)

Default

```yaml
resources:
  limits:
    memory: 8Gi
```

---

### `resources.requests."gpu.intel.com/i915"`

See [Resources Requests GPU](/common/container/resources#resourceslimitsgpuintelcomi915)

Default: `not set`

---

#### `resources.limits."nvidia.com/gpu"`

See [Resources Limits GPU](/common/container/resources#resourceslimitsnvidiacomgpu)

Default: `not set`

---

#### `resources.limits."amd.com/gpu"`

See [Resources Limits GPU](/common/container/resources#resourceslimitsamdcomgpu)

Default: `not set`

---

## `resources.requests`

See [Resources Requests](/common/container/resources#resourcesrequests)

Default

```yaml
resources:
  requests:
    cpu: 10m
    memory: 50Mi
```

---

### `resources.requests.cpu`

See [Resources Requests CPU](/common/container/resources#resourcesrequestscpu)

Default

```yaml
resources:
  requests:
    cpu: 10m
```

---

### `resources.requests.memory`

See [Resources Requests Memory](/common/container/resources#resourcesrequestsmemory)

Default

```yaml
resources:
  requests:
    memory: 50Mi
```

---

## Full Examples

```yaml
resources:
  limits:
    cpu: 4000m
    memory: 8Gi
  requests:
    cpu: 10m
    memory: 50Mi
```
