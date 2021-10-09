{{/* Define the secrets */}}
{{- define "nextcloud.secrets" -}}

---

apiVersion: v1
kind: Secret
metadata:
  labels:
    {{- include "common.labels" . | nindent 4 }}
  name: rediscreds
{{- $redisprevious := lookup "v1" "Secret" .Release.Namespace "rediscreds" }}
{{- $redisPass := "" }}
data:
{{- if $redisprevious }}
  {{- $redisPass = ( index $redisprevious.data "redis-password" ) | b64dec  }}
  redis-password: {{ ( index $redisprevious.data "redis-password" ) }}
{{- else }}
  {{- $redisPass = randAlphaNum 50 }}
  redis-password: {{ $redisPass | b64enc | quote }}
{{- end }}
  masterhost: {{ ( printf "%v-%v" .Release.Name "redis-master" ) | b64enc | quote }}
  slavehost: {{ ( printf "%v-%v" .Release.Name "redis-master" ) | b64enc | quote }}
type: Opaque
{{- end -}}
