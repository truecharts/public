{{/* Define the configmap */}}
{{- define "restreamer.configmap" -}}

{{- $configName := printf "%s-restreamer-configmap" (include "tc.common.names.fullname" .) }}

---
{{/* This configmap are loaded on both main authentik container and worker */}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $configName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  {{/* Ports */}}
  CORE_ADDRESS: {{ .Values.service.main.ports.main.port }}
  {{/* Logs */}}
  {{- with .Values.logs.log_level }}
  CORE_LOG_LEVEL: {{ . }}
  {{- end }}
  {{- with .Values.logs.log_topics }}
  CORE_LOG_TOPICS: {{ join "," . }}
  {{- end }}
  {{- with .Values.logs.log_max_lines }}
  CORE_LOG_MAXLINES: {{ . | quote }}
  {{- end }}
{{- end }}
