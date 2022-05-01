{{/* Define the configmap */}}
{{- define "netdata.configmap" -}}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "common.names.fullname" . }}-config
  labels:
    {{- include "common.labels" . | nindent 4 }}
data: |
  [global]
    memory mode = dbengine
    dbengine multihost disk space = 4096

{{- end -}}
