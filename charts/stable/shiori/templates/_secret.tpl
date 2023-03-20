{{/* Define the secret */}}
{{- define "shiori.secret" -}}
{{- $secretName := printf "%s-shiori-secret" (include "tc.v1.common.lib.chart.names.fullname" .) }}
{{- $shioriprevious := lookup "v1" "Secret" .Release.Namespace "shiori-secret" }}
enabled: true
data:
  SHIORI_DIR: {{ .Values.persistence.data.mountPath }}
  SHIORI_DBMS: "postgresql"
  SHIORI_PG_PORT: "5432"
  SHIORI_PG_USER: {{ .Values.cnpg.main.user }}
  SHIORI_PG_PASS: {{ .Values.cnpg.main.creds.password | trimAll "\"" }}
  SHIORI_PG_NAME: {{ .Values.cnpg.main.database }}
  SHIORI_PG_HOST: {{ .Values.cnpg.main.creds.plain | trimAll '\"' }}
{{- end -}}
