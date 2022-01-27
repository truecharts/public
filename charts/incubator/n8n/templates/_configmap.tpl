{{/* Define the configmap */}}
{{- define "n8n.configmap" -}}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: n8n-env
data:

{{- end -}}
