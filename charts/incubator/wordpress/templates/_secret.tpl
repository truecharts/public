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
  WORDPRESS_USERNAME: {{ .Values.wordpress.user | quote }}
  WORDPRESS_PASSWORD: {{ .Values.wordpress.pass | quote }}
  WORDPRESS_EMAIL: {{ .Values.wordpress.email | quote }}
  WORDPRESS_FIRST_NAME: {{ .Values.wordpress.first_name | quote }}
  WORDPRESS_LAST_NAME: {{ .Values.wordpress.last_name | quote }}
  WORDPRESS_BLOG_NAME: {{ .Values.wordpress.blog_name | quote }}
  WORDPRESS_DATABASE_HOST:
    secretKeyRef:
      name: mariadbcreds
      key: plainhost
  WORDPRESS_DATABASE_USER: {{ .Values.mariadb.mariadbUsername | quote }}
  WORDPRESS_DATABASE_PASSWORD:
    secretKeyRef:
      name: mariadbcreds
      key: mariadb-password
  WORDPRESS_DATABASE_NAME: {{ .Values.mariadb.mariadbDatabase | quote }}
  {{- if .Values.notifier.smtp.enabled }}
  WORDPRESS_SMTP_HOST: {{ .Values.notifier.smtp.host | quote }}
  WORDPRESS_SMTP_PORT: {{ .Values.notifier.smtp.port | quote }}
  WORDPRESS_SMTP_USER: {{ .Values.notifier.smtp.user | quote }}
  WORDPRESS_SMTP_PASSWORD: {{ .Values.notifier.smtp.pass | quote }}
  {{- end }}
{{- end }}
