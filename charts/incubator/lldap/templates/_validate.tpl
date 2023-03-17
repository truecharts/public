{{/*
Ensure valid DB type is select, defaults to SQLite
*/}}
{{- define "lldap.dbTypeValid" -}}
{{- if not (or (eq .Values.database.type "postgresql") (eq .Values.database.type "mysql") (eq .Values.database.type "sqlite")) }}
{{- required "Invalid database type" nil }}
{{- end -}}
{{- end -}}
