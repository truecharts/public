# Restart Policy

## key: restartPolicy

- Type: `string`
- Default: `Always`
- Helm Template: ❌

Sets the container's restart policy.

Keys and sub keys:

```yaml
# Optional
restartPolicy:
```

Examples:

```yaml
restartPolicy: OnFailure

restartPolicy: Never

restartPolicy: Never
```
