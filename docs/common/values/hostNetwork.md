# Host Network

## key: hostNetwork

Info:

- Type: `boolean`
- Default: `false`
- Helm Template: ❌

Can be defined in:

- `.Values`.hostNetwork

---

Binds container to the host's network stack

> All services will be forced to `ClusterIP` when `hostNetwork` is enabled,
> to avoid port conflicts with services requesting the same ports as the container.

Examples:

```yaml
hostNetwork: true
```
