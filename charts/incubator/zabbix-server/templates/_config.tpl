{{/* Define the configmap */}}
{{- define "zabbix.config" -}}

{{- $serverConfigName := printf "%s-server-config" (include "tc.common.names.fullname" .) }}
{{- $commonConfigName := printf "%s-common-config" (include "tc.common.names.fullname" .) }}
{{- $webConfigName := printf "%s-web-config" (include "tc.common.names.fullname" .) }}

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $commonConfigName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  DB_SERVER_HOST: {{ printf "%v-%v" .Release.Name "postgresql" }}
  DB_SERVER_PORT: "5432"
  POSTGRES_USER: {{ .Values.postgresql.postgresqlUsername }}
  POSTGRES_DB: {{ .Values.postgresql.postgresqlDatabase }}

---
{{- $server := .Values.zabbix.server -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $serverConfigName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  ZBX_LISTENPORT: {{ .Values.service.server.ports.server.port }}

---

{{- $frontend := .Values.zabbix.frontend -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $webConfigName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  PHP_TZ: {{ .Values.TZ }}
  ZBX_SERVER_HOST: localhost
  ZBX_SERVER_PORT: {{ .Values.service.server.ports.server.port }}
  ZBX_SERVER_NAME: {{ $frontend.server_name }}
  ENABLE_WEB_ACCESS_LOG: {{ $frontend.enable_access_logs | quote }}
  ZBX_MAXEXECUTIONTIME: {{ $frontend.max_execution_time | quote }}
  ZBX_MEMORYLIMIT: {{ $frontend.memory_limit }}
  ZBX_POSTMAXSIZE: {{ $frontend.post_max_size }}
  ZBX_UPLOADMAXFILESIZE: {{ $frontend.upload_max_file_size }}
  ZBX_MAXINPUTTIME: {{ $frontend.max_input_time | quote }}
  ZBX_SESSION_NAME: {{ $frontend.session_name }}
  ZBX_DENY_GUI_ACCESS: {{ $frontend.deny_gui_access | quote }}
  {{- if $frontend.access_ip_range }}
  ZBX_GUI_ACCESS_IP_RANGE: '[{{ range initial $frontend.access_ip_range }}{{ . | quote }},{{ end }}{{ with last $frontend.access_ip_range }}{{ . | quote }}{{ end }}]'
  {{- end }}
  ZBX_GUI_WARNING_MSG: {{ $frontend.warning_message }}
  ZBX_SSO_SETTINGS: {{ $frontend.sso_settings }}
  PHP_FPM_PM: {{ $frontend.php_fpm_pm }}
  PHP_FPM_PM_MAX_CHILDREN: {{ $frontend.php_fpm_pm_max_children | quote }}
  PHP_FPM_PM_START_SERVERS: {{ $frontend.php_fpm_pm_start_servers | quote }}
  PHP_FPM_PM_MIN_SPARE_SERVERS: {{ $frontend.php_fpm_pm_min_spare_servers | quote }}
  PHP_FPM_PM_MAX_SPARE_SERVERS: {{ $frontend.php_fpm_pm_max_spare_servers | quote }}
  PHP_FPM_PM_MAX_REQUESTS: {{ $frontend.php_fpm_pm_max_requests | quote }}
{{- end -}}
