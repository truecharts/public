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
{{- $serverIngressURL := "" -}}
{{- $host := "" -}}
{{- if .Values.ingress.main.enabled -}}
  {{- with (first .Values.ingress.main.hosts) -}}
    {{- $host = .host -}}
    {{- $serverIngressURL = (printf "https://%v" .host) -}}
{{- end }}
{{- $ingressURL  := .Values.ingress.main.hosts -}}
{{- if .Values.matrix.hostname }}
{{- printf "https://%s" .Values.matrix.hostname -}}
{{- else }}
{{- $serverIngressURL -}}
{{- end }}
{{- end }}
