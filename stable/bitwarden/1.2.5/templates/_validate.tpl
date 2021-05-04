{{/*
Ensure valid DB type is select, defaults to SQLite
*/}}
{{- define "bitwardenrs.dbTypeValid" -}}
{{- if not (or (eq .Values.database.type "postgresql") (eq .Values.database.type "mysql") (eq .Values.database.type "sqlite")) }}
{{- required "Invalid database type" nil }}
{{- end -}}
{{- end -}}

{{/*
Ensure log type is valid
*/}}
{{- define "bitwardenrs.logLevelValid" -}}
{{- if not (or (eq .Values.bitwardenrs.log.level "trace") (eq .Values.bitwardenrs.log.level "debug") (eq .Values.bitwardenrs.log.level "info") (eq .Values.bitwardenrs.log.level "warn") (eq .Values.bitwardenrs.log.level "error") (eq .Values.bitwardenrs.log.level "off")) }}
{{- required "Invalid log level" nil }}
{{- end }}
{{- end }}
