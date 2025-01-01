{{/* Define the secrets */}}
{{- define "prometheus-pve-exporter.secrets" -}}
{{- $pveUser := .Values.pve.credentials.user -}}
{{- $pveTokenName := .Values.pve.credentials.tokenName -}}
{{- $pveTokenValue := .Values.pve.credentials.tokenValue -}}
enabled: true
data:
  PVE_USER: {{ $pveUser }}
  PVE_TOKEN_NAME: {{ $pveTokenName }}
  PVE_TOKEN_VALUE: {{ $pveTokenValue }}
{{- end }}