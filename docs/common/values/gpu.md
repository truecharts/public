# GPU

## key: scaleGPU

Info:

- Type: `dict`
- Default: `{}`
- Helm Template: ❌

Can be defined in:

- `.Values`.scaleGPU
- `.Values.additionalContainers.[container-name]`.scaleGPU
- `.Values.initContainers.[container-name]`.scaleGPU
- `.Values.installContainers.[container-name]`.scaleGPU
- `.Values.upgradeContainers.[container-name]`.scaleGPU
- `.Values.systemContainers.[container-name]`.scaleGPU
- `.Values.jobs.[job-name].podSpec.containers.[container-name].[container-name]`.scaleGPU

---

It's used in SCALE GUI. Configuration is parsed by the Chart,
and each key/value pair, is added in the Pod's `spec.template.container.resources.limits`.

> If a GPU is passed through, it will automatically append the group `44` in `supplementalGroups`.

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

`gpu.intel.com/i915` and it's value, are generated from the SCALE GUI and middleware.
