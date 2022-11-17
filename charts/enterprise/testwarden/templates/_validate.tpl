{{/*
Ensure valid DB type is select, defaults to SQLite
*/}}
{{- define "vaultwarden.dbTypeValid" -}}
{{- if not (or (eq .Values.database.type "postgresql") (eq .Values.database.type "mysql") (eq .Values.database.type "sqlite")) }}
{{- required "Invalid database type" nil }}
{{- end -}}
{{- end -}}

{{/*
Ensure log type is valid
*/}}
{{- define "vaultwarden.logLevelValid" -}}
{{- if not (or (eq .Values.vaultwarden.log.level "trace") (eq .Values.vaultwarden.log.level "debug") (eq .Values.vaultwarden.log.level "info") (eq .Values.vaultwarden.log.level "warn") (eq .Values.vaultwarden.log.level "error") (eq .Values.vaultwarden.log.level "off")) }}
{{- required "Invalid log level" nil }}
{{- end }}
{{- end }}
