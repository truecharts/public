{{/* Define the secret */}}
{{- define "hastypaste.secrets" -}}
{{- $secretName := (printf "%s-hastypaste-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}
enabled: true
data:
  {{- $redis := .Values.redis -}}
  {{- $redisPass := $redis.creds.redisPassword | trimAll "\"" -}}
  {{- $redisUser := $redis.username }}
  {{- $redisURL := $redis.creds.plainhost | trimAll "\"" }}
  CACHE__REDIS_URI: {{ printf "redis://%v:%v@%v:6379/0" $redisUser $redisPass $redisURL | quote }}
  CACHE__ENABLE: "true"
  PORT: {{ .Values.service.main.ports.main.port | quote }}
  TIME_ZONE: {{ .Values.TZ }}
  PASTE_ROOT: {{ .Values.persistence.config.mountPath | quote }}
  {{/* User defined */}}
  {{- $hasty := .Values.hastyPaste }}
  NEW_AT_INDEX: {{ $hasty.new_at_index | quote }}
  ENABLE_PUBLIC_LIST: {{ $hasty.enable_public_list | quote }}
  MAX_BODY_SIZE: {{ (int $hasty.max_body_size) | quote }}
  LOG_LEVEL: {{ $hasty.log_level }}
  WORKERS: {{ $hasty.workers | quote }}
  {{- $interface := $hasty.interface }}
  UI_DEFAULT__USE_LONG_ID: {{ $interface.default_use_long_id | quote }}
  UI_DEFAULT__EXPIRE_TIME__ENABLE: {{ $interface.default_expire_time_enable | quote }}
  UI_DEFAULT__EXPIRE_TIME__MINUTES: {{ $interface.default_expire_time_minutes | quote }}
  UI_DEFAULT__EXPIRE_TIME__HOURS: {{ $interface.default_expire_time_hours | quote }}
  UI_DEFAULT__EXPIRE_TIME__DAYS: {{ $interface.default_expire_time_days | quote }}
  {{- $branding := $hasty.branding }}
  {{- with $branding.title }}
  BRANDING__TITLE: {{ . | quote }}
  {{- end -}}
  {{- with $branding.description }}
  BRANDING__DESCRIPTION: {{ . | quote }}
  {{- end -}}
  {{- with $branding.icon }}
  BRANDING__ICON: {{ . | quote }}
  {{- end -}}
  {{- with $branding.favicon }}
  BRANDING__FAVICON: {{ . | quote }}
  {{- end -}}
  {{- with $branding.css_file }}
  BRANDING__CSS_FILE: {{ . | quote }}
  {{- end }}
  BRANDING__HIDE_VERSION: {{ $branding.hide_version | quote }}
{{- end }}
