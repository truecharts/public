# RBAC

## Key: rbac

Info:

- Type: `dict`
- Default:

  ```yaml
  rbac:
    main:
      enabled: false
      primary: true
      clusterWide: false
  ```

- Helm Template:
  - rbac.NAME.labels - keys ❌
  - rbac.NAME.labels - values ✅
  - rbac.NAME.annotations - keys ❌
  - rbac.NAME.annotations - values ✅
  - rbac.NAME.rules[].apiGroups - entries ✅
  - rbac.NAME.rules[].resources - entries ✅
  - rbac.NAME.rules[].verbs - entries ✅
  - rbac.NAME.subjects[].kind ✅
  - rbac.NAME.subjects[].name ✅
  - rbac.NAME.subjects[].apiGroup ✅

Can be defined in:

- `.Values`.rbac

---

For every `rbac.[NAME]` that is enabled it will create a `Role` and a `RoleBinding`
or a `ClusterRole` and a `ClusterRoleBinding` if `clusterWide` flag is set.

You can define the rules under the `rules` key, the same way
you would do in a normal kubernetes object.
Rules will be pass to the `Role` or `ClusterRole` object.

You can define the subjects under the `subjects` key, the same way
you would do in a normal kubernetes object.
Subjects will be pass to the `RoleBinding` or `ClusterRoleBinding` object.

`subjects` key is optional

The following subject is always assigned

```yaml
- kind: ServiceAccount
  name: {{ $saName }}
  namespace: {{ .Release.Namespace }}
```

`$saName` is calculated based on the `primary` serviceAccount

Examples:

```yaml
rbac:
  main:
    enabled: true
    clusterWide: true
    labels:
      key: value
    annotations:
      key: value
    rules:
      - apiGroups:
          - ""
        resources:
          - services
          - pods
        verbs:
          - get
          - list
    subjects:
      - kind: something
        name: something
        apiGroup: something
```

Kubernetes Documentation:

- [RBAC](https://kubernetes.io/docs/reference/access-authn-authz/rbac)
