{{/* Define the configmap */}}
{{- define "invidious.config" -}}

{{- $configName := printf "%s-invidious-config" (include "tc.common.names.fullname" .) }}
{{- $v := .Values.invidious }}

{{- $_ := set $v "check_tables" true }}
{{- $_ := set $v "db" dict }}
{{- $_ := set $v.db "user" .Values.postgresql.postgresqlUsername }}
{{- $_ := set $v.db "dbname" .Values.postgresql.postgresqlDatabase }}
{{- $_ := set $v.db "password" (.Values.postgresql.postgresqlPassword | trimAll "\"") }}
{{- $_ := set $v.db "host" (.Values.postgresql.url.plain | trimAll "\"") }}
{{- $_ := set $v.db "port" 5432 }}
{{- $_ := set $v "host_binding" "0.0.0.0" }}
{{- $_ := set $v "port" .Values.service.main.ports.main.port }}

---
apiVersion: v1
kind: Secret
metadata:
  name: {{ $configName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  INVIDIOUS_CONFIG: |
    {{- toYaml $v | nindent 4 }}
{{- end -}}
