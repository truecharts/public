{{/* Define the configmap */}}
{{- define "nocodb.configmap" -}}

{{- $pgPass := .Values.cnpg.main.creds.password | trimAll "\"" }}
{{- $pgUser := .Values.cnpg.main.user }}
{{- $pgDB := .Values.cnpg.main.database }}
{{- $pgHost := printf "%v-cnpg-main-rw" (include "tc.v1.common.lib.chart.names.fullname" $) }}
enabled: true
data:
  NC_DB: "{{ printf "pg://%v:5432?u=%v&p=%v&d=%v" $pgHost $pgUser $pgPass $pgDB }}"
  NC_MIN: "{{ ternary "true" "" .Values.workload.main.podSpec.containers.main.env.DISABLE_SPLASH_SCREEN }}"
{{- end -}}
