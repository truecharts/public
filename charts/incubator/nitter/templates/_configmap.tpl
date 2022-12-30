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
    {{/* Secret Key */}}
    {{- with (lookup "v1" "Secret" .Release.Namespace $nitterSecretName) }}
    hmacKey: {{ index .data "AUTHENTIK_SECRET_KEY" }}
    {{- else }}
    hmacKey: {{ randAlphaNum 32 | b64enc }}
    {{- end }}
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
