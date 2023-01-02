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

  {{/* Database */}}
  WORDPRESS_DATABASE_PORT_NUMBER: "3306"
  WORDPRESS_DATABASE_USER: {{ .Values.mariadb.mariadbUsername | quote }}
  WORDPRESS_DATABASE_NAME: {{ .Values.mariadb.mariadbDatabase | quote }}

  {{/* Wordpress */}}
  WORDPRESS_USERNAME: {{ .Values.wordpress.user | quote }}
  WORDPRESS_EMAIL: {{ .Values.wordpress.email | quote }}
  WORDPRESS_FIRST_NAME: {{ .Values.wordpress.first_name | quote }}
  WORDPRESS_LAST_NAME: {{ .Values.wordpress.last_name | quote }}
  WORDPRESS_BLOG_NAME: {{ .Values.wordpress.blog_name | quote }}
  WORDPRESS_ENABLE_REVERSE_PROXY: {{ ternary "yes" "no" .Values.wordpress.enable_reverse_proxy_headers | quote }}

  {{- if .Values.smtp.enabled }}
  WORDPRESS_SMTP_HOST: {{ .Values.smtp.host | quote }}
  WORDPRESS_SMTP_PORT: {{ .Values.smtp.port | quote }}
  {{- end }}

  {{- $php := get .Values "php-config" }}
  {{/* PHP */}}
  {{- with $php.PHP_ENABLE_OPCACHE }}
  PHP_ENABLE_OPCACHE: {{ . | quote }}
  {{- end }}
  {{- with $php.PHP_EXPOSE_PHP }}
  PHP_EXPOSE_PHP: {{ . | quote }}
  {{- end }}
  {{- with $php.PHP_MAX_EXECUTION_TIME }}
  PHP_MAX_EXECUTION_TIME: {{ . | quote }}
  {{- end }}
  {{- with $php.PHP_MAX_INPUT_TIME }}
  PHP_MAX_INPUT_TIME: {{ . | quote }}
  {{- end }}
  {{- with $php.PHP_MAX_INPUT_VARS }}
  PHP_MAX_INPUT_VARS: {{ . | quote }}
  {{- end }}
  {{- with $php.PHP_MEMORY_LIMIT }}
  PHP_MEMORY_LIMIT: {{ . | quote }}
  {{- end }}
  {{- with $php.PHP_POST_MAX_SIZE }}
  PHP_POST_MAX_SIZE: {{ . | quote }}
  {{- end }}
  {{- with $php.PHP_UPLOAD_MAX_FILESIZE }}
  PHP_UPLOAD_MAX_FILESIZE: {{ . | quote }}
  {{- end }}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  WORDPRESS_DATABASE_HOST: {{ printf "%v-%v" .Release.Name "mariadb" | b64enc }}
  WORDPRESS_DATABASE_PASSWORD: {{ .Values.mariadb.mariadbPassword | trimAll "\"" | b64enc }}

  WORDPRESS_PASSWORD: {{ .Values.wordpress.pass | b64enc }}

  {{- if .Values.smtp.enabled }}
  WORDPRESS_SMTP_USER: {{ .Values.smtp.user | b64enc }}
  WORDPRESS_SMTP_PASSWORD: {{ .Values.smtp.pass | b64enc }}
  {{- end }}

  {{/* Salts */}}
  {{- with (lookup "v1" "Secret" .Release.Namespace $secretName) }}
  WORDPRESS_AUTH_KEY: {{ index .data "WORDPRESS_AUTH_KEY" }}
  {{- else }}
  WORDPRESS_AUTH_KEY: {{ randAlphaNum 32 | b64enc }}
  {{- end }}
  {{- with (lookup "v1" "Secret" .Release.Namespace $secretName) }}
  WORDPRESS_SECURE_AUTH_KEY: {{ index .data "WORDPRESS_SECURE_AUTH_KEY" }}
  {{- else }}
  WORDPRESS_SECURE_AUTH_KEY: {{ randAlphaNum 32 | b64enc }}
  {{- end }}
  {{- with (lookup "v1" "Secret" .Release.Namespace $secretName) }}
  WORDPRESS_LOGGED_IN_KEY: {{ index .data "WORDPRESS_LOGGED_IN_KEY" }}
  {{- else }}
  WORDPRESS_LOGGED_IN_KEY: {{ randAlphaNum 32 | b64enc }}
  {{- end }}
  {{- with (lookup "v1" "Secret" .Release.Namespace $secretName) }}
  WORDPRESS_NONCE_KEY: {{ index .data "WORDPRESS_NONCE_KEY" }}
  {{- else }}
  WORDPRESS_NONCE_KEY: {{ randAlphaNum 32 | b64enc }}
  {{- end }}
  {{- with (lookup "v1" "Secret" .Release.Namespace $secretName) }}
  WORDPRESS_AUTH_SALT: {{ index .data "WORDPRESS_AUTH_SALT" }}
  {{- else }}
  WORDPRESS_AUTH_SALT: {{ randAlphaNum 32 | b64enc }}
  {{- end }}
  {{- with (lookup "v1" "Secret" .Release.Namespace $secretName) }}
  WORDPRESS_SECURE_AUTH_SALT: {{ index .data "WORDPRESS_SECURE_AUTH_SALT" }}
  {{- else }}
  WORDPRESS_SECURE_AUTH_SALT: {{ randAlphaNum 32 | b64enc }}
  {{- end }}
  {{- with (lookup "v1" "Secret" .Release.Namespace $secretName) }}
  WORDPRESS_LOGGED_IN_SALT: {{ index .data "WORDPRESS_LOGGED_IN_SALT" }}
  {{- else }}
  WORDPRESS_LOGGED_IN_SALT: {{ randAlphaNum 32 | b64enc }}
  {{- end }}
  {{- with (lookup "v1" "Secret" .Release.Namespace $secretName) }}
  WORDPRESS_NONCE_SALT: {{ index .data "WORDPRESS_NONCE_SALT" }}
  {{- else }}
  WORDPRESS_NONCE_SALT: {{ randAlphaNum 32 | b64enc }}
  {{- end }}
{{- end }}
