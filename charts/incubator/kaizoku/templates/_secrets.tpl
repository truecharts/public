{{/* Define the secrets */}}
{{- define "kaizoku.secret" -}}
{{- $secretName := (printf "%s-kaizoku-secret" (include "tc.v1.common.lib.chart.names.fullname" $)) -}}

{{- $user := .Values.cnpg.main.user -}}
{{- $password := .Values.cnpg.main.creds.password | trimAll "\"" -}}
{{- $database := .Values.cnpg.main.database -}}
{{- $host := .Values.cnpg.main.creds.host -}}

{{- $url := printf "postgresql://%v:%v@db:5432/%v" $user $password $database }}
kaizoku-secret:
  enabled: true
  data:
    DATABASE_URL: $url
{{- end -}}
