{{/* Define the configmap */}}
{{- define "metabase.configmap" -}}

enabled: true
data:
  {{/* Database */}}
  MB_DB_TYPE: "postgres"
  MB_DB_PORT: "5432"
  MB_DB_HOST: {{ .Values.cnpg.main.creds.host | trimAll "\"" }}
  MB_DB_DBNAME: "{{ .Values.cnpg.main.database }}"
  MB_DB_USER: "{{ .Values.cnpg.main.user }}"
  {{/* Timezone */}}
  JAVA_TIMEZONE: "{{ .Values.TZ }}"

{{- end -}}
