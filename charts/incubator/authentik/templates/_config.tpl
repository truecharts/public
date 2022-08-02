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
  AUTHENTIK_DISABLE_STARTUP_ANALYTICS: {{ .Values.authentik.general.disable_startup_analytics | quote }}
  AUTHENTIK_DISABLE_UPDATE_CHECK: {{ .Values.authentik.general.disable_update_check | quote }}
  AUTHENTIK_AVATARS: {{ .Values.authentik.general.avatars }}
  AUTHENTIK_DEFAULT_USER_CHANGE_NAME: {{ .Values.authentik.general.allow_user_name_change | quote }}
  AUTHENTIK_DEFAULT_USER_CHANGE_EMAIL: {{ .Values.authentik.general.allow_user_mail_change | quote }}
  AUTHENTIK_DEFAULT_USER_CHANGE_USERNAME: {{ .Values.authentik.general.allow_user_username_change | quote }}
  AUTHENTIK_GDPR_COMPLIANCE: {{ .Values.authentik.general.gdpr_compliance | quote }}
  AUTHENTIK_IMPERSONATION: {{ .Values.authentik.general.impersonation | quote }}
  AUTHENTIK_DEFAULT_TOKEN_LENGTH: {{ .Values.authentik.general.token_length | quote }}
  {{/* Reporting */}}
  AUTHENTIK_ERROR_REPORTING__ENABLED: {{ .Values.authentik.reporting.enabled | quote }}
  AUTHENTIK_ERROR_REPORTING__SEND_PII: {{ .Values.authentik.reporting.send_pii | quote }}
  AUTHENTIK_ERROR_REPORTING__ENVIRONMENT: {{ .Values.authentik.reporting.environment }}
  {{/* LDAP */}}
  AUTHENTIK_LDAP__TLS__CIPHERS: {{ .Values.authentik.ldap.tls_ciphers }}
{{- end }}
