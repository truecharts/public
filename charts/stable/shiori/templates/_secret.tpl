{{/* Define the secret */}}
{{- define "shiori.secret" -}}
enabled: true
data:
  SHIORI_DIR: {{ .Values.persistence.data.mountPath }}
  {{/* Database */}}
  SHIORI_DBMS: "postgresql"
  SHIORI_PG_PORT: "5432"
  SHIORI_PG_USER: {{ .Values.postgresql.postgresqlUsername }}
  SHIORI_PG_PASS: {{ .Values.postgresql.postgresqlPassword | trimAll "\"" }}
  SHIORI_PG_NAME: {{ .Values.postgresql.postgresqlDatabase }}
  SHIORI_PG_HOST: {{ .Values.postgresql.url.plain | trimAll "\"" }}
{{- end -}}
