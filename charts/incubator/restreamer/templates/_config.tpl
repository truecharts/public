{{/* Define the configmap */}}
{{- define "restreamer.configmap" -}}

{{- $configName := printf "%s-restreamer-configmap" (include "tc.v1.common.lib.chart.names.fullname" $) }}

enabled: true
data:
  {{/* Paths */}}
  CORE_DB_DIR: "/core/config"
  CORE_STORAGE_DISK_DIR: "/core/data"
  {{/* Ports */}}
  CORE_TLS_ENABLE: {{ .Values.restreamer.general.tls_enable | quote }}
  CORE_ADDRESS: {{ .Values.service.main.ports.main.port | quote }}
  CORE_TLS_ADDRESS: {{ .Values.service.https.ports.https.port | quote }}
  CORE_RTMP_ADDRESS: {{ .Values.service.rtmp.ports.rtmp.port | quote }}
  CORE_RTMP_ADDRESS_TLS: {{ .Values.service.rtmps.ports.rtmps.port | quote }}
  CORE_SRT_ADDRESS: {{ .Values.service.srt.ports.srt.port | quote }}
  {{/* General */}}
  {{- with .Values.restreamer.general.hostname }}
  CORE_HOST_NAME: {{ . }}
  {{- end }}
  CORE_HOST_AUTO: {{ .Values.restreamer.general.host_auto | quote }}
  {{- with .Values.restreamer.general.origins }}
  CORE_STORAGE_COCORE_ORIGINS: {{ join "," . }}
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
  {{- if or .Values.restreamer.logs.log_max_lines (eq (int .Values.restreamer.logs.log_max_lines) 0) }}
  CORE_LOG_MAXLINES: {{ .Values.restreamer.logs.log_max_lines | quote }}
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
  {{- if or .Values.restreamer.storage_disk.disk_max_size_mb (eq (int .Values.restreamer.storage_disk.disk_max_size_mb) 0) }}
  CORE_STORAGE_DISK_MAXSIZEMBYTES: {{ .Values.restreamer.storage_disk.disk_max_size_mb | quote }}
  {{- end }}
  CORE_STORAGE_DISK_CACHE_ENABLE: {{ .Values.restreamer.storage_disk.cache_enable | quote }}
  {{- if or .Values.restreamer.storage_disk.cache_max_size_mb (eq (int .Values.restreamer.storage_disk.cache_max_size_mb) 0) }}
  CORE_STORAGE_DISK_CACHE_MAXSIZEMBYTES: {{ .Values.restreamer.storage_disk.cache_max_size_mb | quote }}
  {{- end }}
  {{- if or .Values.restreamer.storage_disk.cache_ttl (eq (int .Values.restreamer.storage_disk.cache_ttl) 0) }}
  CORE_STORAGE_DISK_CACHE_TTLSECONDS: {{ .Values.restreamer.storage_disk.cache_ttl | quote }}
  {{- end }}
  {{- if or .Values.restreamer.storage_disk.cache_max_file_size_mb (eq (int .Values.restreamer.storage_disk.cache_max_file_size_mb) 0) }}
  CORE_STORAGE_DISK_CACHE_MAXFILESIZEMBYTES: {{ .Values.restreamer.storage_disk.cache_max_file_size_mb | quote }}
  {{- end }}
  {{- with .Values.restreamer.storage_disk.cache_types }}
  CORE_STORAGE_DISK_CACHE_TYPES: {{ join " " . }}
  {{- end }}
  {{/* Storage Mem */}}
  CORE_STORAGE_MEMORY_AUTH_ENABLE: {{ .Values.restreamer.storage_mem.storage_mem_auth_enable | quote }}
  {{- if or .Values.restreamer.storage_mem.storage_mem_max_size_mb (eq (int .Values.restreamer.storage_mem.storage_mem_max_size_mb) 0) }}
  CORE_STORAGE_MEMORY_MAXSIZEMBYTES: {{ .Values.restreamer.storage_mem.storage_mem_max_size_mb | quote }}
  {{- end }}
  CORE_STORAGE_MEMORY_PURGE: {{ .Values.restreamer.storage_mem.storage_mem_purge | quote }}
  {{/* RTMP */}}
  CORE_RTMP_ENABLE: {{ .Values.restreamer.rtmp.rtmp_enable | quote }}
  CORE_RTMP_ENABLE_TLS: {{ .Values.restreamer.rtmp.rtmps_enable | quote }}
  {{- with .Values.restreamer.rtmp.rtmp_app }}
  CORE_RTMP_APP: {{ . | quote }}
  {{- end }}
  {{/* FFMPEG */}}
  {{- with .Values.restreamer.ffmpeg.ffmpeg_binary }}
  CORE_FFMPEG_BINARY: {{ . }}
  {{- end }}
  {{- if or .Values.restreamer.ffmpeg.ffmpeg_max_processes (eq (int .Values.restreamer.ffmpeg.ffmpeg_max_processes) 0) }}
  CORE_FFMPEG_MAXPROCESSES: {{ .Values.restreamer.ffmpeg.ffmpeg_max_processes | quote }}
  {{- end }}
  {{- with .Values.restreamer.ffmpeg.ffmpeg_access_input_allow }}
  CORE_FFMPEG_ACCESS_INPUT_ALLOW: {{ . }}
  {{- end }}
  {{- with .Values.restreamer.ffmpeg.ffmpeg_access_input_block }}
  CORE_FFMPEG_ACCESS_INPUT_BLOCK: {{ . }}
  {{- end }}
  {{- with .Values.restreamer.ffmpeg.ffmpeg_access_output_allow }}
  CORE_FFMPEG_ACCESS_OUTPUT_ALLOW: {{ . }}
  {{- end }}
  {{- with .Values.restreamer.ffmpeg.ffmpeg_access_output_block }}
  CORE_FFMPEG_ACCESS_OUTPUT_BLOCK: {{ . }}
  {{- end }}
  {{- if or .Values.restreamer.ffmpeg.ffmpeg_log_max_lines (eq (int .Values.restreamer.ffmpeg.ffmpeg_log_max_lines) 0) }}
  CORE_FFMPEG_LOG_MAXLINES: {{ .Values.restreamer.ffmpeg.ffmpeg_log_max_lines | quote }}
  {{- end }}
  {{- if or .Values.restreamer.ffmpeg.ffmpeg_log_max_history (eq (int .Values.restreamer.ffmpeg.ffmpeg_log_max_history) 0) }}
  CORE_FFMPEG_LOG_MAXHISTORY: {{ .Values.restreamer.ffmpeg.ffmpeg_log_max_history | quote }}
  {{- end }}
  {{/* Playout */}}
  CORE_PLAYOUT_ENABLE: {{ .Values.restreamer.playout.playout_enable | quote }}
  {{- if or .Values.restreamer.playout.playout_min_port (eq (int .Values.restreamer.playout.playout_min_port) 0) }}
  CORE_PLAYOUT_MINPORT: {{ .Values.restreamer.playout.playout_min_port | quote }}
  {{- end }}
  {{- if or .Values.restreamer.playout.playout_max_port (eq (int .Values.restreamer.playout.playout_max_port) 0) }}
  CORE_PLAYOUT_MAXPORT: {{ .Values.restreamer.playout.playout_max_port | quote }}
  {{- end }}
  {{/* Debug */}}
  CORE_DEBUG_PROFILING: {{ .Values.restreamer.debug.debug_profiling | quote }}
  {{- if or .Values.restreamer.debug.debug_force_gc (eq (int .Values.restreamer.debug.debug_force_gc) 0) }}
  CORE_DEBUG_FORCEGC: {{ .Values.restreamer.debug.debug_force_gc | quote }}
  {{- end }}
  {{/* Metrics */}}
  CORE_METRICS_ENABLE: {{ .Values.restreamer.metrics.metrics_enable | quote }}
  CORE_METRICS_ENABLE_PROMETHEUS: {{ .Values.restreamer.metrics.metrics_prometheus_enable | quote }}
  {{- if or .Values.restreamer.metrics.metrics_range_seconds (eq (int .Values.restreamer.metrics.metrics_range_seconds) 0) }}
  CORE_METRICS_RANGE_SECONDS: {{ .Values.restreamer.metrics.metrics_range_seconds | quote }}
  {{- end }}
  {{- if or .Values.restreamer.metrics.metrics_interval_seconds (eq (int .Values.restreamer.metrics.metrics_interval_seconds) 0) }}
  CORE_METRICS_INTERVAL_SECONDS: {{ .Values.restreamer.metrics.metrics_interval_seconds | quote }}
  {{- end }}
  {{/* Sessions */}}
  CORE_SESSIONS_ENABLE: {{ .Values.restreamer.sessions.sessions_enable | quote }}
  {{- with .Values.restreamer.sessions.sessions_ip_ignore_list }}
  CORE_SESSIONS_IP_IGNORELIST: {{ join "," . }}
  {{- end }}
  {{- if or .Values.restreamer.sessions.sessions_timeout_sec (eq (int .Values.restreamer.sessions.sessions_timeout_sec) 0) }}
  CORE_SESSIONS_SESSION_TIMEOUT_SEC: {{ .Values.restreamer.sessions.sessions_timeout_sec | quote }}
  {{- end }}
  CORE_SESSIONS_PERSIST: {{ .Values.restreamer.sessions.sessions_persist | quote }}
  {{- if or .Values.restreamer.sessions.sessions_max_bitrate (eq (int .Values.restreamer.sessions.sessions_max_bitrate) 0) }}
  CORE_SESSIONS_MAXBITRATE_MBIT: {{ .Values.restreamer.sessions.sessions_max_bitrate | quote }}
  {{- end }}
  {{- if or .Values.restreamer.sessions.sessions_max_sessions (eq (int .Values.restreamer.sessions.sessions_max_sessions) 0) }}
  CORE_SESSIONS_MAXSESSIONS: {{ .Values.restreamer.sessions.sessions_max_sessions | quote }}
  {{- end }}
  {{/* Router */}}
  {{- with .Values.restreamer.router.router_blocked_prefixes }}
  CORE_ROUTER_BLOCKED_PREFIXES: {{ join "," . }}
  {{- else }}
  CORE_ROUTER_BLOCKED_PREFIXES: "/api"
  {{- end }}
  {{- with .Values.restreamer.router.router_routes }}
  CORE_ROUTER_ROUTES: {{ join " " . }}
  {{- end }}
{{- end -}}
