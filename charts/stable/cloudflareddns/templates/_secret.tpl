{{/* Define the secret */}}
{{- define "cloudflareddns.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) }}

{{- $domains := list }}
{{- $records := list }}
{{- $zones := list }}
{{- range $item := .Values.cloudflareddns.host_zone_record }}
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
  {{- with .Values.cloudflareddns.user }}
  CF_USER: {{ . | quote }}
  {{- end }}
  {{- with .Values.cloudflareddns.api_key }}
  CF_APIKEY: {{ . | quote }}
  {{- end }}
  {{- with .Values.cloudflareddns.api_token }}
  CF_APITOKEN: {{ . | quote }}
  {{- end }}
  {{- with .Values.cloudflareddns.api_token_zone }}
  CF_APITOKEN_ZONE: {{ . | quote }}
  {{- end }}
  INTERVAL: {{ .Values.cloudflareddns.interval | quote }}
  LOG_LEVEL: {{ .Values.cloudflareddns.log_level | quote }}
  DETECTION_MODE: {{ .Values.cloudflareddns.detect_override | default .Values.cloudflareddns.detect_mode | quote }}
  CF_ZONES: {{ join ";" $zones | quote }}
  CF_HOSTS: {{ join ";" $domains | quote }}
  CF_RECORDTYPES: {{ join ";" $records | quote }}
{{- end -}}
