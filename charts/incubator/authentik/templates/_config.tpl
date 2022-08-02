{{/* Define the configmap */}}
{{- define "authentik.config" -}}

{{- $configName := printf "%s-authentik-config" (include "tc.common.names.fullname" .) }}

---
{{/* This configmap are loaded on both main authentik container and worker */}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $configName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  {{/* Mail */}}
  AUTHENTIK_EMAIL__PORT: {{ .Values.authentik.mail.port | quote }}
  AUTHENTIK_EMAIL__USE_TLS: {{ .Values.authentik.mail.tls | quote }}
  AUTHENTIK_EMAIL__USE_SSL: {{ .Values.authentik.mail.ssl | quote }}
  AUTHENTIK_EMAIL__TIMEOUT: {{ .Values.authentik.mail.timeout | quote }}
  {{/* Logging */}}
  AUTHENTIK_LOG_LEVEL: {{ .Values.authentik.logging.log_level }}
  {{/* General */}}
  AUTHENTIK_DISABLE_UPDATE_CHECK: {{ .Values.authentik.general.disable_update_check | quote }}

{{- end }}
