{{/* Define the rolebinding */}}
{{- define "drone-runner.rolebinding" -}}
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
{{- end -}}
