{{/* Define the configmap */}}
{{- define "nitter.configmaps" -}}
{{- $fullname := (include "tc.v1.common.lib.chart.names.fullname" $) -}}

{{- $config := .Values.nitter.config -}}
{{- $general := .Values.nitter.general -}}
{{- $cache := .Values.nitter.cache -}}
{{- $preferences := .Values.nitter.preferences -}}

{{- $redisHost := .Values.redis.creds.plainhost | trimAll "\"" -}}
{{- $redisPass := .Values.redis.creds.redisPassword | trimAll "\"" -}}

{{- $hmacKey := randAlphaNum 32 -}}

 {{- with lookup "v1" "Secret" .Release.Namespace $fullname -}}
   {{- $hmacKey = index .data "hmacKey" | b64dec -}}
 {{- end }}

nitter-config:
  enabled: true
  data:
    nitter.conf: |
      [Server]
      https = false
      address = "0.0.0.0"
      staticDir = "./public"
      port = {{ .Values.service.main.ports.main.port }}
      httpMaxConnections = {{ $general.httpMaxConnections }}
      title = {{ $general.title | quote }}
      hostname = {{ $general.hostname | quote }}

      [Cache]
      redisPort = 6379
      redisConnections = 20
      redisMaxConnections = 30
      redisHost = {{ $redisHost }}
      redisPassword = {{ $redisPass }}
      listMinutes = {{ $cache.listMinutes }}
      rssMinutes = {{ $cache.rssMinutes }}

      [Config]
      hmacKey: {{ $hmacKey | quote }}
      base64Media = {{ $config.base64Media }}
      enableRSS = {{ $config.enableRSS }}
      enableDebug = {{ $config.enableDebug }}
      proxy = {{ $config.proxy | quote }}
      proxyAuth = {{ $config.proxyAuth | quote }}
      tokenCount = {{ $config.tokenCount }}

      [Preferences]
      theme = {{ $preferences.theme | quote }}
      replaceTwitter = {{ $preferences.replaceTwitter | quote }}
      replaceYouTube = {{ $preferences.replaceYouTube | quote }}
      replaceReddit = {{ $preferences.replaceReddit | quote }}
      replaceInstagram = {{ $preferences.replaceInstagram | quote }}
      proxyVideos = {{ $preferences.proxyVideos }}
      hlsPlayback = {{ $preferences.hlsPlayback }}
      infiniteScroll = {{ $preferences.infiniteScroll }}
{{- end -}}
