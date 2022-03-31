{{- define "webmap.configmap" -}}

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "common.names.fullname" . }}-token
  labels:
    {{- include "common.labels" . | nindent 4 }}
data:
  hashed-token: {{ sha256sum .Values.env.WEBUI_TOKEN }}
{{- end -}}
