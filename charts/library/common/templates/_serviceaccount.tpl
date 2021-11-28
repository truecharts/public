{{/*
The ServiceAccount object to be created.
*/}}
{{- define "common.serviceAccount" }}
{{- if .Values.serviceAccount.create }}
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: {{ default (include "common.names.fullname" .) .Values.serviceAccount.name }}
  labels:
    {{- include "common.labels" . | nindent 4 }}
  {{- with .Values.serviceAccount.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end }}
{{- end }}
