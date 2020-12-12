{{/*
Get Nextloud Postgres Database Name
*/}}
{{- define "postgres.DatabaseName" -}}
{{- print "nextcloud" -}}
{{- end -}}

{{/*
Postgres Selector labels
*/}}
{{- define "nextcloud.postgres.selectorLabels" -}}
app.kubernetes.io/name: {{ include "nextcloud.name" . }}-postgres
app.kubernetes.io/instance: {{ .Release.Name }}-postgres
{{- end }}


