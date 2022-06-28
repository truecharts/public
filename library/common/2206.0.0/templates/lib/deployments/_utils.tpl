{{/*
Retrieve deployment metadata
*/}}
{{- define "common.deployment.metadata" -}}
metadata:
  name: {{ template "common.names.fullname" . }}
  labels: {{ include "common.labels.selectorLabels" . | nindent 4 }}
{{- end -}}


{{/*
Retrieve replicas/strategy/selector
*/}}
{{- define "common.deployment.common_spec" -}}
replicas: {{ (default 1 .Values.replicas) }}
strategy:
  type: {{ (default "Recreate" .Values.updateStrategy ) }}
selector:
  matchLabels: {{ include "common.labels.selectorLabels" . | nindent 4 }}
{{- end -}}


{{/*
Retrieve deployment pod's metadata
*/}}
{{- define "common.deployment.pod.metadata" -}}
metadata:
  name: {{ template "common.names.fullname" . }}
  labels: {{ include "common.labels.selectorLabels" . | nindent 4 }}
  annotations: {{ include "common.annotations" . | nindent 4 }}
{{- end -}}


{{/*
Retrieve common deployment configuration
*/}}
{{- define "common.deployment.common_config" -}}
apiVersion: {{ template "common.capabilities.deployment.apiVersion" . }}
kind: Deployment
{{ include "common.deployment.metadata" . | nindent 0 }}
{{- end -}}
