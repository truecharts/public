# Restart Policy

## key: restartPolicy

Info:

- Type: `string`
- Default: `Always`
- Default((Cron)Job): `Never`
- Helm Template: ❌

Can be defined in:

- `.Values`.restartPolicy

---

Sets the container's restart policy.

Keys and sub keys:

```yaml
# Optional
restartPolicy:
```

`Deployment`, `StatefulSet`, `ReplicaSet` and `DaemonSet` only allows `Always`
`Job` and `CronJob` don't have that restriction.

Examples:

```yaml
restartPolicy: OnFailure

restartPolicy: Never

restartPolicy: Always
```
