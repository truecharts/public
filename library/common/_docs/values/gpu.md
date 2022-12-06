# GPU

## key: scaleGPU

- Type: `dict`
- Default: `{}`
- Helm Template: ❌

It's used in SCALE GUI. Configuration is parsed by the Chart,
and each key/value pair, is added in `deployment.spec.template.container.resources.limits`

Example:

```yaml
scaleGPU:
  gpu.intel.com/i915: "1"

resources:
  limits:
    cpu: 4000m
```

Will result in:

```yaml
resources:
  limits:
    gpu.intel.com/i915: "1"
    cpu: 4000m
```

`gpu.intel.com/i915` and it's value, are generated from the SCALE GUI.
