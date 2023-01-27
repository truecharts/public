{{/*
Renderer for NOTES.txt
*/}}
{{- define "ix.v1.common.util.notes" -}}
{{ include "ix.v1.common.util.notes.header" . }}

{{ include "ix.v1.common.util.notes.custom" . }}

{{ include "ix.v1.common.util.notes.footer" . }}
{{- end -}}



{{/*
NOTES.txt default header content.
*/}}
{{- define "ix.v1.common.util.notes.header" -}}
Thank you for installing {{ .Chart.Name }}.

{{ include "ix.v1.common.util.notes.custom" . }}

Check the docs at: https://truecharts.org
Opensource can only exist with our support.
Please consider sponsoring TrueCharts: https://truecharts.org/sponsor
{{- end -}}



{{/*
NOTES.txt default footer content.
*/}}
{{- define "ix.v1.common.util.notes.footer" -}}
Check the docs at: https://truecharts.org
Opensource can only exist with our support.
Please consider sponsoring TrueCharts: https://truecharts.org/sponsor
{{- end -}}

{{/*
NOTES.txt content from values.yaml entry.
*/}}
{{- define "ix.v1.common.util.notes.custom" -}}
{{ .Values.notes }}
{{- end -}}
