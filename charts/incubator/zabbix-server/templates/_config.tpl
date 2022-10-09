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
  ZBX_LISTENPORT: {{ .Values.service.server.ports.server.port | quote }}
  {{- if $server.listen_backlog }}
  ZBX_LISTENBACKLOG: {{ $server.listen_backlog | quote }}
  {{- end }}
  ZBX_STARTREPORTWRITERS: {{ $server.start_report_writers | quote }}
  ZBX_STARTPOLLERS: {{ $server.start_pollers | quote }}
  ZBX_IPMIPOLLERS: {{ $server.ipmi_pollers | quote }}
  ZBX_STARTPREPROCESSORS: {{ $server.start_preprocessors | quote }}
  ZBX_STARTPOLLERSUNREACHABLE: {{ $server.start_pollers_unreachable | quote }}
  ZBX_STARTTRAPPERS: {{ $server.start_trappers | quote }}
  ZBX_STARTPINGERS: {{ $server.start_pingers | quote }}
  ZBX_STARTDISCOVERERS: {{ $server.start_discoverers | quote }}
{{/*
ZBX_STARTHISTORYPOLLERS=5 # Available since 5.4.0
ZBX_STARTHTTPPOLLERS=1
ZBX_STARTODBCPOLLERS=1 # Available since 6.0.0
ZBX_STARTTIMERS=1
ZBX_STARTESCALATORS=1
ZBX_STARTALERTERS=3 # Available since 3.4.0
ZBX_JAVAGATEWAY=zabbix-java-gateway
ZBX_JAVAGATEWAYPORT=10052
ZBX_STARTJAVAPOLLERS=5
ZBX_STARTLLDPROCESSORS=2 # Available since 4.2.0
ZBX_STATSALLOWEDIP= # Available since 4.0.5
ZBX_STARTVMWARECOLLECTORS=0
ZBX_VMWAREFREQUENCY=60
ZBX_VMWAREPERFFREQUENCY=60
ZBX_VMWARECACHESIZE=8M
ZBX_VMWARETIMEOUT=10
ZBX_ENABLE_SNMP_TRAPS=false
ZBX_SOURCEIP=
ZBX_HOUSEKEEPINGFREQUENCY=1
ZBX_MAXHOUSEKEEPERDELETE=5000
ZBX_PROBLEMHOUSEKEEPINGFREQUENCY=60 # Available since 6.0.0
ZBX_SENDERFREQUENCY=30
ZBX_CACHESIZE=8M
ZBX_CACHEUPDATEFREQUENCY=60
ZBX_STARTDBSYNCERS=4
ZBX_EXPORTFILESIZE=1G # Available since 4.0.0
ZBX_EXPORTTYPE= # Available since 5.0.10 and 5.2.6
ZBX_AUTOHANODENAME=fqdn # Allowed values: fqdn, hostname. Available since 6.0.0
ZBX_HANODENAME= # Available since 6.0.0
ZBX_AUTONODEADDRESS=fqdn # Allowed values: fqdn, hostname. Available since 6.0.0
ZBX_NODEADDRESSPORT=10051 # Allowed to use with ZBX_AUTONODEADDRESS variable only. Available since 6.0.0
ZBX_NODEADDRESS=localhost # Available since 6.0.0
ZBX_HISTORYCACHESIZE=16M
ZBX_HISTORYINDEXCACHESIZE=4M
ZBX_HISTORYSTORAGEDATEINDEX=0 # Available since 4.0.0
ZBX_TRENDCACHESIZE=4M
ZBX_TRENDFUNCTIONCACHESIZE=4M
ZBX_VALUECACHESIZE=8M
ZBX_TRAPPERTIMEOUT=300
ZBX_UNREACHABLEPERIOD=45
ZBX_UNAVAILABLEDELAY=60
ZBX_UNREACHABLEDELAY=15
ZBX_LOGSLOWQUERIES=3000
ZBX_STARTPROXYPOLLERS=1
ZBX_PROXYCONFIGFREQUENCY=3600
ZBX_PROXYDATAFREQUENCY=1
ZBX_TLSCAFILE=
ZBX_TLSCRLFILE=
ZBX_TLSCERTFILE=
ZBX_TLSKEYFILE=
ZBX_TLSCIPHERALL= # Available since 4.4.7
ZBX_TLSCIPHERALL13= # Available since 4.4.7
ZBX_TLSCIPHERCERT= # Available since 4.4.7
ZBX_TLSCIPHERCERT13= # Available since 4.4.7
ZBX_TLSCIPHERPSK= # Available since 4.4.7
ZBX_TLSCIPHERPSK13= # Available since 4.4.7
*/}}
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
