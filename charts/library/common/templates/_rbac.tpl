{{/*
This template serves as a blueprint for all PersistentVolumeClaim objects that are created
within the common library.
*/}}
{{- define "common.rbac" -}}
{{- if .Values.rbac.enabled }}
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: {{ include "common.names.fullname" . -}}
  labels:
    {{- with .Values.rbac.labels }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
  annotations:
    {{- with .Values.rbac.annotations }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
{{- with .Values.rbac.rules }}
rules:
  {{- . | toYaml | nindent 4 }}
{{- end -}}
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: {{ include "common.names.fullname" . -}}
  labels:
    {{- with .Values.rbac.labels }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
  annotations:
    {{- with .Values.rbac.annotations }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: {{ include "common.names.fullname" . -}}
subjects:
  {{- if .Values.serviceAccount }}
  - kind: ServiceAccount
    name: {{ include "common.names.serviceAccountName" . }}
    namespace: {{ .Release.Namespace }}
  {{- end }}
  {{- with .Values.rbac.subjects }}
  {{- toYaml . | nindent 2 }}
  {{- end }}
{{- end }}
{{- end -}}
