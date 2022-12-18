{{/* HastBin environment variables */}}
{{- define "hastebin.env" -}}
  {{- $configName := printf "%s-env-config" (include "tc.common.names.fullname" .) }}
  {{- $secretName := printf "%s-env-secret" (include "tc.common.names.fullname" .) }}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $configName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  PORT: {{ .Values.service.main.ports.main.port | quote }}
  KEY_LENGTH: {{ .Values.hastebin.key_length | quote }}
  MAX_LENGTH: {{ .Values.hastebin.max_length | quote }}
  STATIC_MAX_AGE: {{ .Values.hastebin.static_max_age | quote }}
  RECOMPRESS_STATIC_ASSETS: {{ .Values.hastebin.recompress_static_assets | quote }}
  KEYGENERATOR_TYPE: {{ .Values.hastebin.key_gen_type | quote }}

  {{- with .Values.hastebin.documents }}
  DOCUMENTS: {{ join "," . | quote }}
  {{- end }}

  {{/* Logging */}}
  LOGGING_LEVEL: {{ .Values.logging.level | quote }}
  LOGGING_TYPE: {{ .Values.logging.type | quote }}
  LOGGING_COLORIZE: {{ .Values.logging.colorize | quote }}

  {{/* Rate Limits */}}
  RATELIMITS_NORMAL_TOTAL_REQUESTS: {{ .Values.rate_limits.normal_total_requests | quote }}
  RATELIMITS_NORMAL_EVERY_MILLISECONDS: {{ .Values.rate_limits.normal_every_milliseconds | quote }}

  {{/* if variable is NOT -1, apply the value */}}
  {{- if not (eq .Values.rate_limits.whitelist_total_requests -1) }}
  RATELIMITS_WHITELIST_TOTAL_REQUESTS: {{ .Values.rate_limits.whitelist_total_requests | quote }}
  {{- end }}

  {{/* if variable is NOT -1, apply the value */}}
  {{- if not (eq .Values.rate_limits.whitelist_every_seconds -1) }}
  RATELIMITS_WHITELIST_EVERY_SECONDS: {{ .Values.rate_limits.whitelist_every_seconds | quote }}
  {{- end }}

  {{- with .Values.rate_limits.whitelists }}
  RATELIMITS_WHITELIST: {{ join "," . | quote }}
  {{- end }}

  {{/* if variable is NOT -1, apply the value */}}
  {{- if not (eq .Values.rate_limits.blacklist_total_requests -1) }}
  RATELIMITS_BLACKLIST_TOTAL_REQUESTS: {{ .Values.rate_limits.blacklist_total_requests | quote }}
  {{- end }}

  {{/* if variable is NOT -1, apply the value */}}
  {{- if not (eq .Values.rate_limits.blacklist_every_seconds -1) }}
  RATELIMITS_BLACKLIST_EVERY_SECONDS: {{ .Values.rate_limits.blacklist_every_seconds | quote }}
  {{- end }}

  {{- with .Values.rate_limits.blacklists }}
  RATELIMITS_BLACKLIST: {{ join "," . | quote }}
  {{- end }}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringDta:
  {{/* Storage/Dependencies */}}
  STORAGE_TYPE: "postgres"
  STORAGE_PORT: "5432"
  STORAGE_EXPIRE_SECONDS: {{ .Values.hastebin.storage_expires_seconds | quote }}
  STORAGE_HOST: {{ printf "%v-%v" .Release.Name "postgresql" }}
  STORAGE_DB: {{ .Values.postgresql.postgresqlDatabase }}
  STORAGE_USERNAME: {{ .Values.postgresql.postgresqlUsername }}
  STORAGE_PASSWORD: {{ .Values.postgresql.postgresqlPassword | trimAll "\"" | b64enc }}

{{- end }}
