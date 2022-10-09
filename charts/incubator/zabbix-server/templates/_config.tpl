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

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $webConfigName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  PHP_TZ: {{ .Values.TZ }}
  ZBX_SERVER_PORT: 10051
  ZBX_SERVER_HOST: localhost
  ZBX_SERVER_NAME: {{ .Values.zabbix.frontend.server_name }}
{{- end -}}
