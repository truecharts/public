{{/* Define the configmap */}}
{{- define "nitter.configmap" -}}

{{- $configName := printf "%s-nitter-config" (include "tc.common.names.fullname" .) }}

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $configName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  nitter.conf: |
    [Server]
    address = "0.0.0.0"
    port = {{ .Values.service.main.ports.main.port }}
    https = false
    httpMaxConnections = {{ .Values.nitter.httpMaxConnections }}
    staticDir = "/public"
    title = {{ .Values.nitter.title }}
    hostname = {{ .Values.nitter.hostname }}

    [Cache]
    listMinutes = {{ .Values.cache.listMinutes }}
    rssMinutes = {{ .Values.cache.rssMinutes }}
    redisHost = {{ .Values.redis.url.plain | trimAll "\"" }}
    redisPort = 6379
    redisPassword = {{ .Values.redis.redisPassword | trimAll "\"" }}
    redisConnections = 20
    redisMaxConnections = 30

    [Config]
    hmacKey: {{ .Values.config.hmacKey }}
    base64Media = {{ ternary "true" "false" .Values.config.base64Media }}
    enableRSS = {{ ternary "true" "false" .Values.config.enableRSS }}
    enableDebug = {{ ternary "true" "false" .Values.config.enableDebug }}
    proxy = {{ .Values.config.proxy }}
    proxyAuth = {{ .Values.config.proxyAuth }}
    tokenCount = {{ .Values.config.tokenCount }}

    [Preferences]
    theme = {{ .Values.preferences.theme }}
    replaceTwitter = {{ .Values.preferences.replaceTwitter }}
    replaceYouTube = {{ .Values.preferences.replaceYouTube }}
    replaceReddit = {{ .Values.preferences.replaceReddit }}
    replaceInstagram = {{ .Values.preferences.replaceInstagram }}
    proxyVideos = {{ ternary "true" "false" .Values.preferences.proxyVideos }}
    hlsPlayback = {{ ternary "true" "false" .Values.preferences.hlsPlayback }}
    infiniteScroll = {{ ternary "true" "false" .Values.preferences.infiniteScroll }}

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
