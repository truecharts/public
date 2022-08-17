kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: {{ $name }}
  namespace: {{ $namespace }}
subjects:
- kind: ServiceAccount
  name: {{ $name }}
  namespace: {{ $namespace }}
roleRef:
  kind: Role
  name: {{ $name }}
  apiGroup: rbac.authorization.k8s.io
