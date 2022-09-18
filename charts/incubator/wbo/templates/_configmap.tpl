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
  SAVE_INTERVAL: {{ .Values.wbo.save_interval | quote }}
  MAX_SAVE_DELAY: {{ .Values.wbo.max_save_delay | quote }}
  MAX_ITEM_COUNT: {{ .Values.wbo.max_item_count | quote }}
  MAX_CHILDREN: {{ .Values.wbo.max_children | quote }}
  MAX_BOARD_SIZE: {{ .Values.wbo.max_board_size | quote }}
  MAX_EMIT_COUNT: {{ .Values.wbo.max_emit_count | quote }}
  MAX_EMIT_COUNT_PERIOD: {{ .Values.wbo.max_emit_count_period | quote }}
  AUTO_FINGER_WHITEOUT: {{ ternary "enabled" "disabled" .Values.wbo.auto_finger_whiteout }}
  BLOCKED_TOOLS: {{ join "," .Values.wbo.blocked_tools }}
  BLOCKED_SELECTION_BUTTONS: {{ join "," .Values.wbo.blocked_selection_buttons }}
{{- end -}}
