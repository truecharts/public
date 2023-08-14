{{/* Define the secret */}}
{{- define "shiori.secret" -}}

enabled: true
stringData:
  SHIORI_DIR: {{ .Values.persistence.data.mountPath }}

  {{/* Database */}}
  SHIORI_DBMS: "postgresql"
  SHIORI_PG_PORT: "5432"
  SHIORI_PG_USER: {{ .Values.cnpg.main.username }}
  SHIORI_PG_PASS: {{ .Values.cnpg.main.creds.password | trimAll "\"" }}
  SHIORI_PG_NAME: {{ .Values.cnpg.main.database }}
  SHIORI_PG_HOST: {{ .Values.cnpg.main.creds.host }}
{{- end -}}
