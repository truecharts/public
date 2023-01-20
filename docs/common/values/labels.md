# Labels

Labels can be defined in nearly all resources.

## Key: podLabels

Info:

- Type: `dict`
- Default: `{}`
- Helm Template:
  - Key: ❌
  - Value: ✅

Can be defined in:

- `.Values`.podLabels

---

Adds the defined labels to the Pod

Examples:

```yaml
podLabels:
  key: value
  key: "{{ .Values.some.path }}"
```

---
---

## Key: controller.labels

Info:

- Type: `dict`
- Default: `{}`
- Helm Template:
  - Key: ❌
  - Value: ✅

Can be defined in:

- `.Values.controller.`labels

---

Adds the defined labels to the controller
(eg Deployment, StatefulSet, DaemonSet, Job, CronJob)

Examples:

```yaml
controller:
  labels:
    key: value
    key: "{{ .Values.some.path }}"
```

---
---

## Key: global.labels

Info:

- Type: `dict`
- Default: `{}`
- Helm Template:
  - Key: ❌
  - Value: ✅

Can be defined in:

- `.Values.global.`labels

---

Adds the defined labels to all the resources

Examples:

```yaml
global:
  labels:
    key: value
    key: "{{ .Values.some.path }}"
```

Kubernetes Documentation:

- [Labels](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/)
