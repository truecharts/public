{{/*
The Environment Variable ConfigMap object to be created.
*/}}
{{- define "common.configmap" -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "common.names.fullname" . }}
  labels:
    {{- include "common.labels" . | nindent 4 }}
{{- with .Values.env }}
data:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end }}
