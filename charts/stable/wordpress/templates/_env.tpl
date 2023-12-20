{{/* Wordpress environment variables */}}
{{- define "wordpress.env" -}}
configmap:
  env-config:
    enabled: true
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
      WORDPRESS_ENABLE_HTTPS: "true"

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

{{- $secretName := printf "%s-env-secret" (include "tc.v1.common.lib.chart.names.fullname" .) }}
secret:
  env-secret:
    enabled: true
    data:
      WORDPRESS_DATABASE_HOST: {{ .Values.mariadb.creds.plainhost }}
      WORDPRESS_DATABASE_PASSWORD: {{ .Values.mariadb.creds.mariadbPassword | trimAll "\"" }}


      WORDPRESS_PASSWORD: {{ .Values.wordpress.pass }}

      {{- if .Values.smtp.enabled }}
      WORDPRESS_SMTP_USER: {{ .Values.smtp.user }}
      WORDPRESS_SMTP_PASSWORD: {{ .Values.smtp.pass }}
      {{- end }}

      {{/* Salts */}}
      WORDPRESS_AUTH_KEY: {{ include "wordpress.fetch" (dict "ns" .Release.Namespace "var" "WORDPRESS_AUTH_KEY" "secret" $secretName) }}
      WORDPRESS_SECURE_AUTH_KEY: {{ include "wordpress.fetch" (dict "ns" .Release.Namespace "var" "WORDPRESS_SECURE_AUTH_KEY" "secret" $secretName) }}
      WORDPRESS_LOGGED_IN_KEY: {{ include "wordpress.fetch" (dict "ns" .Release.Namespace "var" "WORDPRESS_LOGGED_IN_KEY" "secret" $secretName) }}
      WORDPRESS_NONCE_KEY: {{ include "wordpress.fetch" (dict "ns" .Release.Namespace "var" "WORDPRESS_NONCE_KEY" "secret" $secretName) }}
      WORDPRESS_AUTH_SALT: {{ include "wordpress.fetch" (dict "ns" .Release.Namespace "var" "WORDPRESS_AUTH_SALT" "secret" $secretName) }}
      WORDPRESS_SECURE_AUTH_SALT: {{ include "wordpress.fetch" (dict "ns" .Release.Namespace "var" "WORDPRESS_SECURE_AUTH_SALT" "secret" $secretName) }}
      WORDPRESS_LOGGED_IN_SALT: {{ include "wordpress.fetch" (dict "ns" .Release.Namespace "var" "WORDPRESS_LOGGED_IN_SALT" "secret" $secretName) }}
      WORDPRESS_NONCE_SALT: {{ include "wordpress.fetch" (dict "ns" .Release.Namespace "var" "WORDPRESS_NONCE_SALT" "secret" $secretName) }}
{{- end }}

{{- define "wordpress.fetch" -}}
  {{- $var := .var -}}
  {{- $secret := .secret -}}
  {{- $ns := .ns -}}
  {{- $ret := randAlphaNum 32 -}}

  {{- with (lookup "v1" "Secret" $ns $secret) -}}
    {{- $ret = index .data $var | b64dec -}}
  {{- end -}}

  {{- $ret -}}

{{- end -}}
