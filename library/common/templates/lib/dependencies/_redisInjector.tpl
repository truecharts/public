{{/*
This template generates a random password and ensures it persists across updates/edits to the chart
*/}}
{{- define "tc.v1.common.dependencies.redis.secret" -}}

{{- if .Values.redis.enabled -}}
  {{/* Initialize variables */}}
  {{- $fetchname := printf "%s-rediscreds" .Release.Name -}}
  {{- $dbprevious := lookup "v1" "Secret" .Release.Namespace $fetchname -}}
  {{- $dbPass := randAlphaNum 50 -}}
  {{- $dbIndex := .Values.redis.redisDatabase | default "0" -}}

  {{/* If there are previous secrets, fetch values and decrypt them */}}
  {{- if $dbprevious -}}
    {{- $dbPass = (index $dbprevious.data "redis-password") | b64dec -}}
  {{- end -}}

  {{/* Prepare data */}}
  {{- $dbHost := printf "%v-%v" .Release.Name "redis" -}}
  {{- $portHost := printf "%v:6379" $dbHost -}}
  {{- $url := printf "redis://%v:%v@%v/%v" .Values.redis.redisUsername $dbPass $portHost $dbIndex -}}
  {{- $hostPass := printf "%v:%v@%v" .Values.redis.redisUsername $dbPass $dbHost -}}

  {{/* Append some values to redis.creds, so apps using the dep, can use them */}}
  {{- $_ := set .Values.redis.creds "redisPassword" ($dbPass | quote) -}}
  {{- $_ := set .Values.redis.creds "plain" ($dbHost | quote) -}}
  {{- $_ := set .Values.redis.creds "plainhost" ($dbHost | quote) -}}
  {{- $_ := set .Values.redis.creds "plainport" ($portHost | quote) -}}
  {{- $_ := set .Values.redis.creds "plainporthost" ($portHost | quote) -}}
  {{- $_ := set .Values.redis.creds "plainhostpass" ($hostPass | quote) -}}
  {{- $_ := set .Values.redis.creds "url" ($url | quote) -}}

{{/* Create the secret (Comment also plays a role on correct formatting) */}}
enabled: true
expandObjectName: false
data:
  redis-password: {{ $dbPass }}
  plain: {{ $dbHost }}
  url: {{ $url }}
  plainhostpass: {{ $hostPass }}
  plainporthost: {{ $portHost }}
  plainhost: {{ $dbHost }}
  {{- end -}}
{{- end -}}

{{- define "tc.v1.common.dependencies.redis.injector" -}}
  {{- $secret := include "tc.v1.common.dependencies.redis.secret" . | fromYaml -}}
  {{- if $secret -}}
    {{- $_ := set .Values.secret (printf "%s-%s" .Release.Name "rediscreds") $secret -}}
  {{- end -}}
{{- end -}}
