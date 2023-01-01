{{/* Define the configmap */}}
{{- define "nitter.secret" -}}

{{- $secretName := printf "%s-nitter-secret" (include "tc.common.names.fullname" .) }}
{{- $storageSecretName := printf "%s-nitter-storage-secret" (include "tc.common.names.fullname" .) }}

{{- $hmacKey := "" -}}
{{- with (lookup "v1" "Secret" .Release.Namespace $storageSecretName) -}}
  {{- $hmacKey = (index .data "hmacKey") | b64dec -}}
{{- else -}}
  {{- $hmacKey = randAlphaNum 32 -}}
{{- end }}

---
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $storageSecretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data: {{/* Store to reuse */}}
  hmacKey: {{ $hmacKey | b64enc }}
---
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  nitter.conf: |
    [Server]
    https = false
    address = "0.0.0.0"
    staticDir = "./public"
    port = {{ .Values.service.main.ports.main.port }}
    httpMaxConnections = {{ .Values.nitter.general.httpMaxConnections }}
    title = {{ .Values.nitter.general.title | quote }}
    hostname = {{ .Values.nitter.general.hostname | quote }}

    [Cache]
    redisPort = 6379
    redisConnections = 20
    redisMaxConnections = 30
    redisHost = {{ .Values.redis.url.plain | trimAll "\"" | quote }}
    redisPassword = {{ .Values.redis.redisPassword | trimAll "\"" | quote }}
    listMinutes = {{ .Values.nitter.cache.listMinutes }}
    rssMinutes = {{ .Values.nitter.cache.rssMinutes }}

    [Config]
    hmacKey: {{ $hmacKey | quote }}
    base64Media = {{ .Values.nitter.config.base64Media }}
    enableRSS = {{ .Values.nitter.config.enableRSS }}
    enableDebug = {{ .Values.nitter.config.enableDebug }}
    proxy = {{ .Values.nitter.config.proxy | quote }}
    proxyAuth = {{ .Values.nitter.config.proxyAuth | quote }}
    tokenCount = {{ .Values.nitter.config.tokenCount }}

    [Preferences]
    theme = {{ .Values.nitter.preferences.theme | quote }}
    replaceTwitter = {{ .Values.nitter.preferences.replaceTwitter | quote }}
    replaceYouTube = {{ .Values.nitter.preferences.replaceYouTube | quote }}
    replaceReddit = {{ .Values.nitter.preferences.replaceReddit | quote }}
    replaceInstagram = {{ .Values.nitter.preferences.replaceInstagram | quote }}
    proxyVideos = {{ .Values.nitter.preferences.proxyVideos }}
    hlsPlayback = {{ .Values.nitter.preferences.hlsPlayback }}
    infiniteScroll = {{ .Values.nitter.preferences.infiniteScroll }}
{{- end }}
