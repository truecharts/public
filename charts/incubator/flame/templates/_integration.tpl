{{- define "flame.integration.serviceAccount" -}}
main:
  create: true
{{- end -}}
---
{{- define "flame.integration.rbac" -}}
main:
  enabled: true
  rules:
    - apiGroups:
        - "networking.k8s.io"
      resources:
        - "ingresses"
      verbs:
        - "get"
        - "list"
        - "watch"
{{- end -}}
