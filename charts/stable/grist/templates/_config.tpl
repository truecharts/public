{{/* Define the configmap */}}
{{- define "grist.config" -}}

{{- $configName := printf "%s-grist-config" (include "tc.common.names.fullname" .) }}

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $configName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  {{/* Dependencies */}}
  TYPEORM_TYPE: postgres
  TYPEORM_PORT: "5432"
  TYPEORM_HOST: {{ printf "%v-%v" .Release.Name "postgresql" }}
  TYPEORM_DATABASE: {{ .Values.postgresql.postgresqlDatabase }}
  TYPEORM_USERNAME: {{ .Values.postgresql.postgresqlUsername }}
  {{/* Ports */}}
  PORT: {{ .Values.service.main.ports.main.port | quote }}
  HOME_PORT: {{ .Values.service.api.ports.api.port | quote }}
  {{/* Google */}}
  {{- with .Values.grist.google.drive_scope }}
  GOOGLE_DRIVE_SCOPE: {{ . }}
  {{- end }}
  {{/* Forward Auth */}}
  {{- with .Values.grist.forward_auth.header }}
  GRIST_FORWARD_AUTH_HEADER: {{ . }}
  {{- end }}
  {{- with .Values.grist.forward_auth.login_path }}
  GRIST_FORWARD_AUTH_LOGIN_PATH: {{ . }}
  {{- end }}
  {{- with .Values.grist.forward_auth.logout_path }}
  GRIST_FORWARD_AUTH_LOGOUT_PATH: {{ . }}
  {{- end }}
  {{/* APP */}}
  {{- with .Values.grist.home_url }}
  APP_HOME_URL:
  {{- end }}
  {{- with .Values.grist.allowed_webhook_domains }}
  ALLOWED_WEBHOOK_DOMAINS: {{ join "," . }}
  {{- end }}
  {{- with .Values.grist.allowed_hosts }}
  GRIST_ALLOWED_HOSTS: {{ join "," . }}
  {{- end }}
  {{- with .Values.grist.backup_delay_secs }}
  GRIST_BACKUP_DELAY_SECS: {{ . | quote }}
  {{- end }}
  {{- with .Values.grist.default_email }}
  GRIST_DEFAULT_EMAIL: {{ . }}
  {{- end }}
  {{- with .Values.grist.default_product }}
  GRIST_DEFAULT_PRODUCT: {{ . }}
  {{- end }}
  {{- with .Values.grist.default_locale }}
  GRIST_DEFAULT_LOCALE:
  {{- end }}
  {{- with .Values.grist.domain }}
  GRIST_DOMAIN: {{ . }}
  {{- end }}
  {{- with .Values.grist.hide_ui_elements }}
  GRIST_HIDE_UI_ELEMENTS: {{ join "," . }}
  {{- end }}
  {{- with .Values.grist.title_suffix }}
  GRIST_PAGE_TITLE_SUFFIX: {{ . | quote }}
  {{- end }}
  {{- with .Values.grist.proxy_auth_header }}
  GRIST_PROXY_AUTH_HEADER: {{ . }}
  {{- end }}
  {{- with .Values.grist.cookie_max_age }}
  COOKIE_MAX_AGE: {{ . | quote }}
  {{- end }}
  {{- with .Values.grist.single_org }}
  GRIST_SINGLE_ORG: {{ . }}
  {{- end }}
  GRIST_IGNORE_SESSION: {{ .Values.grist.ignore_session | quote }}
  GRIST_FORCE_LOGIN: {{ .Values.grist.force_login | quote }}
  GRIST_SUPPORT_ANON: {{ .Values.grist.support_anon | quote }}
  GRIST_THROTTLE_CPU: {{ .Values.grist.throttle_cpu | quote }}
  APP_STATIC_INCLUDE_CUSTOM_CSS: {{ .Values.grist.include_custom_css | quote }}
  GRIST_MAX_UPLOAD_ATTACHMENT_MB: {{ .Values.grist.max_upload_attachment_mb | quote }}
  GRIST_MAX_UPLOAD_IMPORT_MB: {{ .Values.grist.max_upload_import_mb | quote }}
{{- end -}}
