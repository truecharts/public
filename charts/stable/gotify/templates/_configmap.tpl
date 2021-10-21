{{- define "gotify.configmap" }}
{{ $url := ( .Values.postgresql.url.plain | trimAll "\"" ) }}
{{ $password := ( .Values.postgresql.postgresqlPassword | trimAll "\"" ) }}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: gotifyenv
data:
  GOTIFY_DATABASE_CONNECTION: "host={{ $url }} port=5432 user={{ .Values.postgresql.postgresqlUsername }} dbname={{ .Values.postgresql.postgresqlDatabase }} password={{ $password }} sslmode=disable"
  GOTIFY_DATABASE_DIALECT: "postgres"

{{- end }}
