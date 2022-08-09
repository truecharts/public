{{/* Define the configmap */}}
{{- define "authentik.config" -}}

{{- $authentikConfigName := printf "%s-authentik-config" (include "tc.common.names.fullname" .) }}
{{- $geoipConfigName := printf "%s-geoip-config" (include "tc.common.names.fullname" .) }}
{{- $ldapConfigName := printf "%s-ldap-config" (include "tc.common.names.fullname" .) }}

---
{{/* This configmap are loaded on both main authentik container and worker */}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $authentikConfigName }}
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
  AUTHENTIK_FOOTER_LINKS: {{ .Values.authentik.general.footer_links | squote }}
  {{/* Error Reporting */}}
  AUTHENTIK_ERROR_REPORTING__ENABLED: {{ .Values.authentik.error_reporting.enabled | quote }}
  AUTHENTIK_ERROR_REPORTING__SEND_PII: {{ .Values.authentik.error_reporting.send_pii | quote }}
  AUTHENTIK_ERROR_REPORTING__ENVIRONMENT: {{ .Values.authentik.error_reporting.environment }}
  {{/* LDAP */}}
  {{- with .Values.authentik.ldap.tls_ciphers}}
  AUTHENTIK_LDAP__TLS__CIPHERS: {{ . }}
  {{- end }}
  {{/* Metrics */}}
  AUTHENTIK_LISTEN__METRICS: {{ .Values.authentik.metrics.internalPort }}
---
{{/* This configmap is loaded on ldap container */}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $ldapConfigName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  AUTHENTIK_INSECURE: {{ .Values.outposts.ldap.insecure | quote }}
  AUTHENTIK_HOST: {{ .Values.outposts.ldap.host }}
---
{{/* This configmap is loaded on geoip container */}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $geoipConfigName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  GEOIPUPDATE_EDITION_IDS: {{ .Values.geoip.edition_ids }}
  GEOIPUPDATE_FREQUENCY: {{ .Values.geoip.frequency | quote }}
  GEOIPUPDATE_HOST: {{ .Values.geoip.host_server }}
  GEOIPUPDATE_PRESERVE_FILE_TIMES: '{{ ternary "1" "0" .Values.geoip.preserve_file_times }}'
  GEOIPUPDATE_VERBOSE: '{{ ternary "1" "0" .Values.geoip.verbose }}'
{{- end }}
