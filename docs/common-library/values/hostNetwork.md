# Host Network

## key: hostNetwork

- Type: `boolean`
- Default: `false`
- Helm Template: ❌

Binds container to the host's network

> All services will be forced to `ClusterIP` when `hostNetwork` is enabled,
> to avoid port conflicts with services requesting the same ports.

Examples:

```yaml
hostNetwork: true
```
