{{/* Synapse hostname, derived from either the Values.matrix.hostname override or the Ingress definition */}}
{{- define "matrix.hostname" -}}
{{- if .Values.matrix.hostname }}
{{- .Values.matrix.hostname -}}
{{- else }}
{{- .Values.ingress.main.hosts.synapse -}}
{{- end }}
{{- end }}

{{/* Synapse hostname prepended with https:// to form a complete URL */}}
{{- define "matrix.baseUrl" -}}
{{- if .Values.matrix.hostname }}
{{- printf "https://%s" .Values.matrix.hostname -}}
{{- else }}
{{- printf "https://%s" .Values.ingress.main.hosts.synapse -}}
{{- end }}
{{- end }}
