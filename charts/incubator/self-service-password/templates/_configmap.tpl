{{/* Append the hardcoded volumes */}}
{{- define "openhab.configmap" -}}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "common.names.fullname" . }}-init
  labels:
    {{- include "common.labels" . | nindent 4 }}
data:
  config.inc.local.php: |
    # Read from a user provided file?
{{- end -}}
