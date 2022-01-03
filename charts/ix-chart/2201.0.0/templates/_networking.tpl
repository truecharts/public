{{/*
DNS Configuration
*/}}
{{- define "dnsConfiguration" }}
dnsPolicy: {{ .Values.dnsPolicy }}
{{- if .Values.dnsConfig }}
dnsConfig:
  {{- toYaml .Values.dnsConfig | nindent 2 }}
{{- end }}
{{- end }}


{{/*
Get configuration for host network
*/}}
{{- define "hostNetworkingConfiguration" -}}
{{- $host := default false .Values.hostNetwork -}}
{{- if or .Values.externalInterfaces (eq $host false) -}}
{{- print "false" -}}
{{- else -}}
{{- print "true" -}}
{{- end -}}
{{- end -}}
