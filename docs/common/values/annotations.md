# Annotations

Annotations can be defined in nearly all resources.

## Key: addAnnotations

Info:

- Type: `dict`
- Default:

  ```yaml
  addAnnotations:
    traefik: true
    metallb: true
  ```

- Helm Template: ❌

Can be defined in:

- `.Values`.addAnnotations

---

Enables or disables addition of annotations in `Service` objects.

`metallb: true` adds `metallb.universe.tf/allow-shared-ip: $FULLNAME` annotation.
Only when service type is `LoadBalancer`.

`traefik: true` adds `traefik.ingress.kubernetes.io/service.serversscheme: https`
annotation. Only when service protocol is `HTTPS`

Examples:

```yaml
addAnnotations:
  traefik: true
  metallb: true
```

---
---

## Key: podAnnotations

Info:

- Type: `dict`
- Default: `{}`
- Helm Template:
  - Key: ❌
  - Value: ✅

Can be defined in:

- `.Values`.podAnnotations

---

Adds the defined annotations to the Pod

Examples:

```yaml
podAnnotations:
  key: value
  key: "{{ .Values.some.path }}"
```

---
---

## Key: controller.annotations

Info:

- Type: `dict`
- Default: `{}`
- Helm Template:
  - Key: ❌
  - Value: ✅

Can be defined in:

- `.Values.controller.`annotations

---

Adds the defined annotations to the controller
(eg Deployment, StatefulSet, DaemonSet, Job, CronJob)

Examples:

```yaml
controller:
  annotations:
    key: value
    key: "{{ .Values.some.path }}"
```

---
---

## Key: global.annotations

Info:

- Type: `dict`
- Default: `{}`
- Helm Template:
  - Key: ❌
  - Value: ✅

Can be defined in:

- `.Values.global.`annotations

---

Adds the defined annotations to all the resources

Examples:

```yaml
global:
  annotations:
    key: value
    key: "{{ .Values.some.path }}"
```

Kubernetes Documentation:

- [Annotations](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations)
