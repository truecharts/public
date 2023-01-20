# TTY

## key: tty

Info:

- Type: `boolean`
- Default: `false`
- Helm Template: ❌

Can be defined in:

- `.Values`.tty
- `.Values.additionalContainers.[container-name]`.tty
- `.Values.initContainers.[container-name]`.tty
- `.Values.installContainers.[container-name]`.tty
- `.Values.upgradeContainers.[container-name]`.tty
- `.Values.systemContainers.[container-name]`.tty
- `.Values.jobs.[job-name].podSpec.containers.[container-name].[container-name]`.tty

---

Allocates a TTY, requires also `stdin` set to true

Examples:

```yaml
# Optional
tty: true
```
