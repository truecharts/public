{{/* Define the configmap */}}
{{- define "nocodb.configmap" -}}

{{- $pgPass := .Values.cnpg.main.creds.password | trimAll "\"" }}
{{- $pgUser := .Values.cnpg.main.user }}
{{- $pgDB := .Values.cnpg.main.database }}
enabled: true
data:
  NC_DB: "{{ printf "pg://%v-postgresql:5432?u=%v&p=%v&d=%v" .Release.Name $pgUser $pgPass $pgDB }}"
  NC_MIN: "{{ ternary "true" "" .Values.env.DISABLE_SPLASH_SCREEN }}"
{{- end -}}
