{{/* Define the secret */}}
{{- define "tailscale.sa-rbac" -}}

{{- $secretName := printf "%s-tailscale-secret" (include "tc.common.names.fullname" .) }}

---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: {{ .Release.Namespace }}
  name: {{ .Release.Name }}
rules:
  - apiGroups: [""]
    resources: ["secrets"]
    verbs: ["create"]
  - apiGroups:
      - ""
    resources:
      - "secrets"
    resourceNames:
      - {{ $secretName }}
    verbs:
      - "get"
      - "update"
---
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: {{ .Release.Name }}
  namespace: {{ .Release.Namespace }}
subjects:
- kind: ServiceAccount
  name: {{ .Release.Name }}
  namespace: {{ .Release.Namespace }}
roleRef:
  kind: Role
  name: {{ .Release.Name }}
  apiGroup: rbac.authorization.k8s.io
{{- end }}
