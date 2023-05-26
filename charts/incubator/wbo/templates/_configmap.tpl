{{/* Define the configmap */}}
{{- define "wbo.config" -}}

{{- $configName := printf "%s-config" (include "tc.common.names.fullname" .) }}

---

{{/* This configmap are loaded on both main authentik container and worker */}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $configName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  PORT: {{ .Values.service.main.ports.main.port | quote }}
  {{- if or .Values.wbo.save_interval (eq (int .Values.wbo.save_interval) 0) }}
  SAVE_INTERVAL: {{ .Values.wbo.save_interval | quote }}
  {{- end }}
  {{- if or .Values.wbo.max_save_delay (eq (int .Values.wbo.max_save_delay) 0) }}
  MAX_SAVE_DELAY: {{ .Values.wbo.max_save_delay | quote }}
  {{- end }}
  {{- if or .Values.wbo.max_item_count (eq (int .Values.wbo.max_item_count) 0) }}
  MAX_ITEM_COUNT: {{ .Values.wbo.max_item_count | quote }}
  {{- end }}
  {{- if or .Values.wbo.max_children (eq (int .Values.wbo.max_children) 0) }}
  MAX_CHILDREN: {{ .Values.wbo.max_children | quote }}
  {{- end }}
  {{- if or .Values.wbo.max_board_size (eq (int .Values.wbo.max_board_size) 0) }}
  MAX_BOARD_SIZE: {{ .Values.wbo.max_board_size | quote }}
  {{- end }}
  {{- if or .Values.wbo.max_emit_count (eq (int .Values.wbo.max_emit_count) 0) }}
  MAX_EMIT_COUNT: {{ .Values.wbo.max_emit_count | quote }}
  {{- end }}
  {{- if or .Values.wbo.max_emit_count_period (eq (int .Values.wbo.max_emit_count_period) 0) }}
  MAX_EMIT_COUNT_PERIOD: {{ .Values.wbo.max_emit_count_period | quote }}
  {{- end }}
  {{- with .Values.wbo.auto_finger_whiteout }}
  AUTO_FINGER_WHITEOUT: {{ ternary "enabled" "disabled" . }}
  {{- end }}
  {{- with .Values.wbo.blocked_tools }}
  BLOCKED_TOOLS: {{ join "," . }}
  {{- end }}
  {{- with .Values.wbo.blocked_selection_buttons }}
  BLOCKED_SELECTION_BUTTONS: {{ join "," . }}
  {{- end }}
{{- end -}}
