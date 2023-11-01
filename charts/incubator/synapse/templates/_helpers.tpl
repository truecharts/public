{{/* Synapse hostname, derived from either the Values.matrix.hostname override or the Ingress definition */}}
{{- define "matrix.hostname" -}}
{{- $ingressURL  := .Values.ingress.main.hosts -}}
{{- if .Values.matrix.hostname }}
{{- .Values.matrix.hostname -}}
{{- else }}
{{- $ingressURL -}}
{{- end }}
{{- end }}

{{/* Synapse hostname prepended with https:// to form a complete URL */}}
{{- define "matrix.baseUrl" -}}
{{- $ingressURL  := .Values.ingress.main.hosts -}}
{{- if .Values.matrix.hostname }}
{{- printf "https://%s" .Values.matrix.hostname -}}
{{- else }}
{{- printf "https://%s" $ingressURL -}}
{{- end }}
{{- end }}
