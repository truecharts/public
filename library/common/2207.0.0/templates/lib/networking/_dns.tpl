{{/*
DNS Configuration
*/}}
{{- define "common.networking.dnsConfiguration" }}
{{ if .dnsPolicy }}
dnsPolicy: {{ .dnsPolicy }}
{{ end }}
{{ if .dnsConfig }}
dnsConfig:
  {{ toYaml .dnsConfig | nindent 2 }}
{{ end }}
{{- end }}
