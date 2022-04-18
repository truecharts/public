{{- define "nocodb.configmap" -}}

{{- $pgPass := .Values.postgresql.postgresqlPassword | trimAll "\"" }}
{{- $pgUser := .Values.postgresql.postgresqlUsername }}
{{- $pgDB := .Values.postgresql.postgresqlDatabase }}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: nocodb-configmap
data:
  NC_DB: "{{ printf "pg://%v-postgresql:5432?u=%v&p=%v&d=%v" .Release.Name $pgUser $pgPass $pgDB }}"
  NC_MIN: "{{ ternary "true" "" .Values.env.DISABLE_SPLASH_SCREEN }}"
{{- end -}}
