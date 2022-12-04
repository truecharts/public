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
  PHP_ENABLE_OPCACHE: {{ .Values.wordpress.PHP_ENABLE_OPCACHE | quote }}
  PHP_EXPOSE_PHP: {{ .Values.wordpress.PHP_EXPOSE_PHP | quote }}
  PHP_MAX_EXECUTION_TIME: {{ .Values.wordpress.PHP_MAX_EXECUTION_TIME | quote }}
  PHP_MAX_INPUT_TIME: {{ .Values.wordpress.PHP_MAX_INPUT_TIME | quote }}
  PHP_MAX_INPUT_VARS: {{ .Values.wordpress.PHP_MAX_INPUT_VARS | quote }}
  PHP_MEMORY_LIMIT: {{ .Values.wordpress.PHP_MEMORY_LIMIT | quote }}
  PHP_POST_MAX_SIZE: {{ .Values.wordpress.PHP_POST_MAX_SIZE | quote }}
  PHP_UPLOAD_MAX_FILESIZE: {{ .Values.wordpress.PHP_UPLOAD_MAX_FILESIZE | quote }}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  WORDPRESS_DATABASE_HOST: {{ printf "%v-%v" .Release.Name "mariadb" }}
  WORDPRESS_DATABASE_PASSWORD: {{ .Values.mariadb.mariadbPassword | trimAll "\"" }}

  WORDPRESS_PASSWORD: {{ .Values.wordpress.pass | quote }}
  WORDPRESS_DATABASE_USER: {{ .Values.mariadb.mariadbUsername | quote }}
  WORDPRESS_DATABASE_NAME: {{ .Values.mariadb.mariadbDatabase | quote }}
  WORDPRESS_DATABASE_PORT_NUMBER: "3306"
  {{- if .Values.notifier.smtp.enabled }}
  WORDPRESS_SMTP_USER: {{ .Values.notifier.smtp.user | quote }}
  WORDPRESS_SMTP_PASSWORD: {{ .Values.notifier.smtp.pass | quote }}
  {{- end }}
## salts
  {{- with (lookup "v1" "Secret" .Release.Namespace $wordpressSecretName) }}
  WORDPRESS_AUTH_KEY: {{ index .data "WORDPRESS_AUTH_KEY" }}
  {{ $token = index .data "WORDPRESS_AUTH_KEY" }}
  {{- else }}
  WORDPRESS_AUTH_KEY: {{ randAlphaNum 32 | b64enc }}
  {{- end }}
  {{- with (lookup "v1" "Secret" .Release.Namespace $wordpressSecretName) }}
  WORDPRESS_SECURE_AUTH_KEY: {{ index .data "WORDPRESS_SECURE_AUTH_KEY" }}
  {{ $token = index .data "WORDPRESS_SECURE_AUTH_KEY" }}
  {{- else }}
  WORDPRESS_SECURE_AUTH_KEY: {{ randAlphaNum 32 | b64enc }}
  {{- end }}
  {{- with (lookup "v1" "Secret" .Release.Namespace $wordpressSecretName) }}
  WORDPRESS_LOGGED_IN_KEY: {{ index .data "WORDPRESS_LOGGED_IN_KEY" }}
  {{ $token = index .data "WORDPRESS_LOGGED_IN_KEY" }}
  {{- else }}
  WORDPRESS_LOGGED_IN_KEY: {{ randAlphaNum 32 | b64enc }}
  {{- end }}
    {{- with (lookup "v1" "Secret" .Release.Namespace $wordpressSecretName) }}
  WORDPRESS_NONCE_KEY: {{ index .data "WORDPRESS_NONCE_KEY" }}
  {{ $token = index .data "WORDPRESS_NONCE_KEY" }}
  {{- else }}
  WORDPRESS_NONCE_KEY: {{ randAlphaNum 32 | b64enc }}
  {{- end }}
      {{- with (lookup "v1" "Secret" .Release.Namespace $wordpressSecretName) }}
  WORDPRESS_AUTH_SALT: {{ index .data "WORDPRESS_AUTH_SALT" }}
  {{ $token = index .data "WORDPRESS_AUTH_SALT" }}
  {{- else }}
  WORDPRESS_AUTH_SALT: {{ randAlphaNum 32 | b64enc }}
  {{- end }}
        {{- with (lookup "v1" "Secret" .Release.Namespace $wordpressSecretName) }}
  WORDPRESS_SECURE_AUTH_SALT: {{ index .data "WORDPRESS_SECURE_AUTH_SALT" }}
  {{ $token = index .data "WORDPRESS_SECURE_AUTH_SALT" }}
  {{- else }}
  WORDPRESS_SECURE_AUTH_SALT: {{ randAlphaNum 32 | b64enc }}
  {{- end }}
        {{- with (lookup "v1" "Secret" .Release.Namespace $wordpressSecretName) }}
  WORDPRESS_LOGGED_IN_SALT: {{ index .data "WORDPRESS_LOGGED_IN_SALT" }}
  {{ $token = index .data "WORDPRESS_LOGGED_IN_SALT" }}
  {{- else }}
  WORDPRESS_LOGGED_IN_SALT: {{ randAlphaNum 32 | b64enc }}
  {{- end }}
        {{- with (lookup "v1" "Secret" .Release.Namespace $wordpressSecretName) }}
  WORDPRESS_NONCE_SALT: {{ index .data "WORDPRESS_NONCE_SALT" }}
  {{ $token = index .data "WORDPRESS_NONCE_SALT" }}
  {{- else }}
  WORDPRESS_NONCE_SALT: {{ randAlphaNum 32 | b64enc }}
  {{- end }}
{{- end }}
