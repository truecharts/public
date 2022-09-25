{{/* Define the secrets */}}
{{- define "dashy.config" -}}
{{- $configName := printf "%s-dashy-config" (include "tc.common.names.fullname" .) }}

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $configName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  conf.yml: |
{{- .Values.dashyConfig | toYaml | nindent 4 }}
{{- end -}}
