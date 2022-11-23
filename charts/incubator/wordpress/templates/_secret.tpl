{{/* Define the secret */}}
{{- define "wordpress.secret" -}}

{{- $secretName := printf "%s-wordpress-secret" (include "tc.common.names.fullname" .) }}

---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  APACHE_HTTP_PORT_NUMBER: {{ .Values.wordpress.apache_http_port_number | quote }}
  WORDPRESS_USERNAME: {{ .Values.wordpress.wp_user | quote }}
  WORDPRESS_PASSWORD: {{ .Values.wordpress.wp_pass | quote }}
  WORDPRESS_EMAIL: {{ .Values.wordpress.wp_email | quote }}
  WORDPRESS_FIRST_NAME: {{ .Values.wordpress.wp_first_name | quote }}
  WORDPRESS_LAST_NAME: {{ .Values.wordpress.wp_last_name | quote }}
  WORDPRESS_BLOG_NAME: {{ .Values.wordpress.wp_blog_name | quote }}
  WORDPRESS_DATABASE_HOST: {{ .Values.wordpress.wp_db_host | quote }}
  WORDPRESS_DATABASE_USER: {{ .Values.wordpress.wp_db_user | quote }}
  WORDPRESS_DATABASE_PASSWORD: {{ .Values.wordpress.wp_db_pass | quote }}
  WORDPRESS_DATABASE_NAME: {{ .Values.wordpress.wp_db_name | quote }}
  WORDPRESS_SMTP_HOST: {{ .Values.wordpress.smtp_host | quote }}
  WORDPRESS_SMTP_PORT: {{ .Values.wordpress.smtp_port | quote }}
  WORDPRESS_SMTP_USER: {{ .Values.wordpress.smtp_user | quote }}
  WORDPRESS_SMTP_PASSWORD: {{ .Values.wordpress.smtp_pass | quote }}
{{- end }}
