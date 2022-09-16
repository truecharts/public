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
  CORE_TLS_ADDRESS: {{ .Values.service.http.ports.http.port }}
  CORE_RTMP_ADDRESS: {{ .Values.service.rtmp.ports.rtmp.port }}
  CORE_RTMP_ADDRESS_TLS: {{ .Values.service.rtmps.ports.rtmps.port }}
  CORE_SRT_ADDRESS: {{ .Values.service.srt.ports.srt.port }}
  CORE_TLS_ENABLE: "true"
  {{/* Paths */}}
  CORE_DB_DIR: /core/config
  CORE_STORAGE_DISK_DIR: /core/data
  {{/* General */}}
  {{- with .Values.restreamer.general.hostname }}
  CORE_HOST_NAME: {{ . }}
  {{- end }}
  CORE_HOST_AUTO: {{ .Values.restreamer.general.host_auto | quote }}
  {{- if .Values.restreamer.general.origins }}
  CORE_STORAGE_COCORE_ORIGINS: {{ join "," .Values.restreamer.general.origins }}
  {{- else }}
  CORE_STORAGE_COCORE_ORIGINS: '*'
  {{- end }}
  {{- with .Values.restreamer.general.mimetypes_file }}
  CORE_STORAGE_MIMETYPES_FILE: {{ . }}
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
  CORE_API_READ_ONLY: {{ .Values.restreamer.api.api_read_only | quote }}
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
  CORE_API_AUTH_ENABLE: {{ .Values.restreamer.api.api_auth_enable | quote }}
  CORE_API_AUTH_DISABLE_LOCALHOST: {{ .Values.restreamer.api.api_auth_disable_localhost | quote }}
  CORE_API_AUTH_AUTH0_ENABLE: {{ .Values.restreamer.api.api_auth0_enable | quote }}
  {{- with .Values.restreamer.api.api_auth0_tenants }}
  CORE_API_AUTH_AUTH0_TENANTS: {{ join "," . }}
  {{- end }}
  {{/* Storage Disk */}}
  {{- with .Values.restreamer.storage_disk.disk_max_size_mb }}
  CORE_STORAGE_DISK_MAXSIZEMBYTES: {{ . | quote }}
  {{- end }}
  CORE_STORAGE_DISK_CACHE_ENABLE: {{ .Values.restreamer.storage_disk.cache_enable | quote }}
  {{- with .Values.restreamer.storage_disk.disk_max_size_mb }}
  CORE_STORAGE_DISK_CACHE_MAXSIZEMBYTES: {{ . | quote }}
  {{- end }}
  {{- with .Values.restreamer.storage_disk.cache_ttl }}
  CORE_STORAGE_DISK_CACHE_TTLSECONDS: {{ . | quote }}
  {{- end }}
  {{- with .Values.restreamer.storage_disk.cache_max_file_size_mb }}
  CORE_STORAGE_DISK_CACHE_MAXFILESIZEMBYTES: {{ . | quote }}
  {{- end }}
  {{- with .Values.restreamer.storage_disk.cache_types }}
  CORE_STORAGE_DISK_CACHE_TYPES: {{ join " " . }}
  {{- end }}
  {{/* Storage Mem */}}
  CORE_STORAGE_MEMORY_AUTH_ENABLE: {{ .Values.restreamer.storage_mem.storage_mem_auth_enable | quote }}
  {{- with .Values.restreamer.storage_mem.storage_mem_max_size_mb }}
  CORE_STORAGE_MEMORY_MAXSIZEMBYTES: {{ . | quote }}
  {{- end }}
  CORE_STORAGE_MEMORY_PURGE: {{ .Values.restreamer.storage_mem.storage_mem_purge | quote }}
  {{/* RTMP */}}
  CORE_RTMP_ENABLE: {{ . | quote }}
  CORE_RTMP_ENABLE_TLS: {{ . | quote }}
  {{- if .Values.restreamer.rtmp.rtmp_app }}
  CORE_RTMP_APP: {{ . }}
  {{- end }}
{{- end }}
