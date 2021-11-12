{{/*
This template generates a random password and ensures it persists across updates/edits to the chart
*/}}
{{- define "common.dependencies.redis.injector" -}}
{{- $pghost := printf "%v-%v" .Release.Name "redis" }}

{{- if .Values.redis.enabled }}
---
apiVersion: v1
kind: Secret
metadata:
  labels:
    {{- include "common.labels" . | nindent 4 }}
  name: rediscreds
{{- $dbprevious := lookup "v1" "Secret" .Release.Namespace "rediscreds" }}
{{- $dbPass := "" }}
data:
{{- if $dbprevious }}
  {{- $dbPass = ( index $dbprevious.data "redis-password" ) | b64dec  }}
  redis-password: {{ ( index $dbprevious.data "redis-password" ) }}
{{- else }}
  {{- $dbPass = randAlphaNum 50 }}
  redis-password: {{ $dbPass | b64enc | quote }}
{{- end }}
  url: {{ ( printf "redis://%v:%v@%v-redis:5432/%v" .Values.redis.redisUsername $dbPass .Release.Name .Values.redis.redisDatabase  ) | b64enc | quote }}
  plainporthost: {{ ( printf "%v-%v" .Release.Name "redis" ) | b64enc | quote }}
  plainhost: {{ ( printf "%v-%v" .Release.Name "redis" ) | b64enc | quote }}
type: Opaque
{{- $_ := set .Values.redis "redisPassword" ( $dbPass | quote ) }}
{{- $_ := set .Values.redis "redispassword" ( $pgPass | quote ) }}
{{- $_ := set .Values.redis.url "plain" ( ( printf "%v-%v" .Release.Name "redis" ) | quote ) }}
{{- $_ := set .Values.redis.url "plainhost" ( ( printf "%v-%v" .Release.Name "redis" ) | quote ) }}
{{- $_ := set .Values.redis.url "plainport" ( ( printf "%v-%v:5432" .Release.Name "redis" ) | quote ) }}
{{- $_ := set .Values.redis.url "plainporthost" ( ( printf "%v-%v:5432" .Release.Name "redis" ) | quote ) }}

{{- end }}
{{- end -}}
