# STDIN

## key: stdin

Info:

- Type: `boolean`
- Default: `false`
- Helm Template: ❌

Can be defined in:

- `.Values`.stdin
- `.Values.additionalContainers.[container-name]`.stdin
- `.Values.initContainers.[container-name]`.stdin
- `.Values.installContainers.[container-name]`.stdin
- `.Values.upgradeContainers.[container-name]`.stdin
- `.Values.systemContainers.[container-name]`.stdin
- `.Values.jobs.[job-name].podSpec.containers.[container-name].[container-name]`.stdin

---

Allocates a buffer for stdin in the container runtime.

Examples:

```yaml
# Optional
stdin: true
```
