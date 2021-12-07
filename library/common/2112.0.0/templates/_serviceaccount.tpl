{{/*
Common service account
*/}}
{{- define "common.serviceaccount" -}}
apiVersion: v1
kind: ServiceAccount
metadata:
  name: {{ include "common.names.serviceAccountName" . | quote }}
  namespace: {{ .Release.Namespace | quote }}
  labels: {{- include "common.labels.selectorLabels" . | nindent 4 -}}
{{- end -}}
