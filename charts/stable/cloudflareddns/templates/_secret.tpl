{{/* Define the secret */}}
{{- define "cloudflareddns.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) }}
{{- $cfddns := .Values.cloudflareddns -}}
{{- $domains := list }}
{{- $records := list }}
{{- $zones := list }}
{{- range $item := $cfddns.host_zone_record }}
  {{- $domains = mustAppend $domains $item.domain }}
  {{- $records = mustAppend $records $item.record }}
  {{- $zones = mustAppend $zones $item.zone }}
{{- end }}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  {{- with $cfddns.user }}
  CF_USER: {{ . | quote }}
  {{- end }}
  {{- with $cfddns.api_key }}
  CF_APIKEY: {{ . | quote }}
  {{- end }}
  {{- with $cfddns.api_token }}
  CF_APITOKEN: {{ . | quote }}
  {{- end }}
  {{- with $cfddns.api_token_zone }}
  CF_APITOKEN_ZONE: {{ . | quote }}
  {{- end }}
  INTERVAL: {{ $cfddns.interval | quote }}
  LOG_LEVEL: {{ $cfddns.log_level | quote }}
  DETECTION_MODE: {{ $cfddns.detect_override | default $cfddns.detect_mode | quote }}
  CF_ZONES: {{ join ";" $zones | quote }}
  CF_HOSTS: {{ join ";" $domains | quote }}
  CF_RECORDTYPES: {{ join ";" $records | quote }}
{{- end -}}
