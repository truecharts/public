# Annotations

## key: addAnnotations

- Type: `dict`
- Default:

  ```yaml
  addAnnotations:
    traefik: true
    metallb: true
  ```

- Helm Template: ❌

Enables or disables addition of annotations in `Service` objects.

`metallb: true` adds `metallb.universe.tf/allow-shared-ip: $FULLNAME` annotation.
Only when service type is `LoadBalancer`.

`traefik: true` adds `traefik.ingress.kubernetes.io/service.serversscheme: https` annotation.
Only when service protocol is `HTTPS`

Examples:

```yaml
addAnnotations:
  traefik: true
  metallb: true
```

Kubernetes Documentation:

- [Annotations](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations)
