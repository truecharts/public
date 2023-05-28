{{/* Define the secret */}}
{{- define "tailscale.secret" -}}

enabled: true
data:
  {{- with .Values.tailscale.authkey }}
  {{/* Name of the authkey is crucial, don't change it */}}
  authkey: {{ . }}
  {{- end }}
{{- end }}
