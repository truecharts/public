{{/* Wordpress environment variables */}}
{{- define "wordpress.env" -}}
{{- $configName := printf "%s-env-config" (include "tc.common.names.fullname" .) }}
{{- $secretName := printf "%s-env-secret" (include "tc.common.names.fullname" .) }}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $configName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  APACHE_HTTP_PORT_NUMBER: {{ .Values.service.main.ports.main.port | quote }}
  WORDPRESS_EMAIL: {{ .Values.wordpress.email | quote }}
  WORDPRESS_FIRST_NAME: {{ .Values.wordpress.first_name | quote }}
  WORDPRESS_LAST_NAME: {{ .Values.wordpress.last_name | quote }}
  WORDPRESS_BLOG_NAME: {{ .Values.wordpress.blog_name | quote }}
{{- if .Values.notifier.smtp.enabled }}
  WORDPRESS_SMTP_HOST: {{ .Values.notifier.smtp.host | quote }}
  WORDPRESS_SMTP_PORT: {{ .Values.notifier.smtp.port | quote }}
  {{- end }}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  {{- with (lookup "v1" "Secret" .Release.Namespace $secretName) }}
  SECRET_KEY_BASE: {{ index .data "SECRET_KEY_BASE" | b64dec }}
  {{- else }}
  {{- /* The plain value of SECRET_KEY_BASE is also base64 encoded */}}
  SECRET_KEY_BASE: {{ randAlphaNum 65 | b64enc }}
  {{- end }}
  WORDPRESS_USERNAME: {{ .Values.wordpress.user | quote }}
  WORDPRESS_PASSWORD: {{ .Values.wordpress.pass | quote }}
  WORDPRESS_DATABASE_HOST: {{ .Values.wordpress.database_host | quote }}
  WORDPRESS_DATABASE_USER: {{ .Values.mariadb.mariadbUsername | quote }}
  WORDPRESS_DATABASE_PASSWORD: {{ .Values.wordpress.database_pass | quote }}
  WORDPRESS_DATABASE_NAME: {{ .Values.mariadb.mariadbDatabase | quote }}
{{- if .Values.notifier.smtp.enabled }}
  WORDPRESS_SMTP_USER: {{ .Values.notifier.smtp.user | quote }}
  WORDPRESS_SMTP_PASSWORD: {{ .Values.notifier.smtp.pass | quote }}
  {{- end }}
{{- end }}
