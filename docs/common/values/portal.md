# Portal

## key: portal

Info:

- Type: `dict`
- Default:

  ```yaml
  portal:
    enabled: true
  ```

- Helm Template: ✅ (Except on the `enabled` key)

Can be defined in:

- `.Values`.portal

---

Enables configMap generation for portal. You can also apply overrides for each setting.
(`port`, `host`, `path`, `protocol`), instead of the automatic generation.
Apart from `path` the rest should not be need to be overridden.

For each service/port combo there is an entry in the configMap.

Assume a service like this

```yaml
service:
  srvName:
    enabled: true
    ports:
      portName:
        port: 10000
        protocol: HTTP
```

ConfigMap will look like this:

```yaml
data:
  host-srvName-portName: $node_ip
  port-srvName-portName: 10000
  path-srvName-portName: /
  protocol-srvName-portName: http
```

If you wanted to change the path, you would do:

```yaml
portal:
  srvName:
    portName:
      path: /different_path
```

In questions.yaml, you would use it like that:

```yaml
portals:
  open:
    protocols:
      - "$kubernetes-resource_configmap_portal_protocol-srvName-portName"
    host:
      - "$kubernetes-resource_configmap_portal_host-srvName-portName"
    ports:
      - "$kubernetes-resource_configmap_portal_port-srvName-portName"
    path:
      - "$kubernetes-resource_configmap_portal_path-srvName-portName"
```

Available options on `portal`:

```yaml
portal:
  srvName:
    portName:
      host: 10.10.10.100 # or truenas.localdomain
      port: 10000
      path: /somepath
      protocol: https
    otherPortName:
      host: 10.10.10.100 # or truenas.localdomain
      port: 10002
      path: /somepath
      protocol: https
  otherSrvName:
    otherPortName:
      host: 10.10.10.100 # or truenas.localdomain
      port: 10001
      path: /somepath
      protocol: http
```
