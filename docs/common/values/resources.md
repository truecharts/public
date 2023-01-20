# Resources

## Key: resources

Info:

- Type: `dict`
- Default:

  ```yaml
  resources:
    limits:
      cpu: 4000m
      memory: 8Gi
    requests:
      cpu: 10m
      memory: 50Mi
  ```

- Helm Template: ❌

Can be defined in:

- `.Values`.resources
- `.Values.additionalContainers.[container-name]`.resources
- `.Values.initContainers.[container-name]`.resources
- `.Values.installContainers.[container-name]`.resources
- `.Values.upgradeContainers.[container-name]`.resources
- `.Values.systemContainers.[container-name]`.resources
- `.Values.jobs.[job-name].podSpec.containers.[container-name].[container-name]`.resources

---

`requests` is used by the scheduler to decide if the node has enough
resources for the pod. Can be useful when multi node clusters are used.
Currently set to a very low value, so a pod can always be scheduled on
the single node.

`limits` is used to actually limit resources to a container. By default
is set to 4 cpu and 8GiB RAM.

You can define only what you want to change, and the rest will be pulled from defaults.

Examples:

```yaml
resources:
  limits:
    cpu: 8000m
    memory: 16Gi
  requests:
    cpu: 10m
    memory: 50Mi
```

Kubernetes Documentation:

- [Resources](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers)
