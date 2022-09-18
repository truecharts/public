{{/* Define the secrets */}}
{{- define "flemarr.config" -}}

{{- $configName := printf "%s-flemarr-config" (include "tc.common.names.fullname" .) }}

---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $configName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  config.yml: |
{{- .Values.flemarrConfig | toYaml | nindent 4 }}
{{- end -}}
