# Annotations

These named functions will usually be called into other common templates.
Chances for these to be called directly in an application chart should be non-existent.

So some example inputs, should not be considered that will be used in a values.yaml.

---

## ix.common.annotations

Input:

Values.yaml

```yaml
global:
  annotations:
    annotation1: hard_value
    annotation2: "{{ .Values.key }}"

key: value
```

Output:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:

    annotation1: "hard_value"
    annotation2: "value"
```

---

## ix.common.annotations.workload.spec

Inputs:

Values.yaml

```yaml
ixExternalInterfacesConfigurationNames:
  - iface1
  - iface2
```

Template file

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  ...
spec:
  template:
    metadata:
      annotations:
        {{- include "ix.common.annotations.workload.spec" $ | nindent 8 }}
```

Output:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
spec:
  template:
    metadata:
      annotations:

        k8s.v1.cni.cncf.io/networks: iface1, iface2
```

---

## ix.common.annotations.workload

Input:

Template file

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    {{- include "ix.common.annotations.workload" $ | nindent 4 }}
```

Output:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    rollme: "aqG2v"
```
