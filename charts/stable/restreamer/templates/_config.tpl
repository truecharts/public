{{/* Define the configmap */}}
{{- define "restreamer.configmap" -}}

{{- $configName := printf "%s-restreamer-configmap" (include "tc.common.names.fullname" .) }}

---
{{/* This configmap are loaded on both main authentik container and worker */}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $configName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  {{/* Ports */}}
  CORE_ADDRESS: {{ .Values.service.main.ports.main.port }}
  CORE_TLS_ADDRESS: {{ .Values.service.https.ports.https.port  }}
  CORE_TLS_ENABLE: "true"
  {{/* Paths */}}
  CORE_DB_DIR: /core/config
  CORE_STORAGE_DISK_DIR: /core/data
  {{/* General */}}
  {{- with .Values.restreamer.general.hostname }}
  CORE_HOST_NAME: {{ . }}
  {{- end }}
  {{- with .Values.restreamer.general.host_auto }}
  CORE_HOST_AUTO: {{ . | quote }}
  {{- end }}
  {{/* Logs */}}
  {{- with .Values.restreamer.logs.log_level }}
  CORE_LOG_LEVEL: {{ . }}
  {{- end }}
  {{- with .Values.restreamer.logs.log_topics }}
  CORE_LOG_TOPICS: {{ join "," . }}
  {{- end }}
  {{- with .Values.restreamer.logs.log_max_lines }}
  CORE_LOG_MAXLINES: {{ . | quote }}
  {{- end }}
  {{/* API */}}
  {{- with .Values.restreamer.api.api_read_only }}
  CORE_API_READ_ONLY: {{ . | quote }}
  {{- end }}
  {{- with .Values.restreamer.api.api_access_http_allow }}
  CORE_API_ACCESS_HTTP_ALLOW: {{ join "," . }}
  {{- end }}
  {{- with .Values.restreamer.api.api_access_http_block }}
  CORE_API_ACCESS_HTTP_BLOCK: {{ join "," . }}
  {{- end }}
  {{- with .Values.restreamer.api.api_access_http_allow }}
  CORE_API_ACCESS_HTTPS_ALLOW: {{ join "," . }}
  {{- end }}
  {{- with .Values.restreamer.api.api_access_https_block }}
  CORE_API_ACCESS_HTTPS_BLOCK: {{ join "," . }}
  {{- end }}
  {{- with .Values.restreamer.api.api_auth_enable }}
  CORE_API_AUTH_ENABLE: {{ . | quote }}
  {{- end }}
  {{- with .Values.restreamer.api.api_auth_disable_localhost }}
  CORE_API_AUTH_DISABLE_LOCALHOST: {{ . | quote }}
  {{- end }}
  {{- with .Values.restreamer.api.api_auth0_enable }}
  CORE_API_AUTH_AUTH0_ENABLE: {{ . | quote }}
  {{- end }}
  {{- with .Values.restreamer.api.api_auth0_tenants }}
  CORE_API_AUTH_AUTH0_TENANTS: {{ join "," . }}
  {{- end }}
  {{/* Storage Disk */}}
  {{- with .Values.restreamer.storage_disk. }}
  CORE_STORAGE_DISK_MAXSIZEMBYTES: {{ . | quote }}
  {{- end }}
  {{- with .Values.restreamer.storage_disk. }}
  CORE_STORAGE_DISK_CACHE_ENABLE: {{ . | quote }}
  {{- end }}
  {{- with .Values.restreamer.storage_disk. }}
  CORE_STORAGE_DISK_CACHE_MAXSIZEMBYTES: {{ . | quote }}
  {{- end }}
  {{- with .Values.restreamer.storage_disk. }}
  CORE_STORAGE_DISK_CACHE_TTLSECONDS: {{ . | quote }}
  {{- end }}
  {{- with .Values.restreamer.storage_disk. }}
  CORE_STORAGE_DISK_CACHE_MAXFILESIZEMBYTES: {{ . | quote }}
  {{- end }}
  {{- with .Values.restreamer.storage_disk. }}
  CORE_STORAGE_DISK_CACHE_TYPES: {{ join " " . }}
  {{- end }}
{{- end }}
