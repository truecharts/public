{{/* Append the hardcoded volumes */}}
{{- define "selfservicepassword.configmap" -}}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "common.names.fullname" . }}-config
  labels:
    {{- include "common.labels" . | nindent 4 }}
data:
  config.inc.local.php: |
    # Read from a user provided file?
{{- end -}}
