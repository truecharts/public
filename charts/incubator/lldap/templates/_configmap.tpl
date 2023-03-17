{{/* Define the secrets */}}
{{- define "lldap.config" -}}

{{- $configName := printf "%s-lldap-config" (include "tc.common.names.fullname" .) }}

---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $configName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  config.yml: |
{{- .Values.lldapConfig | toYaml | nindent 4 }}
{{- end -}}
