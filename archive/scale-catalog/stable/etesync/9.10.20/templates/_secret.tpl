{{/* EteSync superuser credentials and Django SECRET_KEY */}}
{{- define "etesync.secret" -}}
enabled: true
data:
  {{- with (lookup "v1" "Secret" .Release.Namespace "etesync-secret") }}
  secret.txt: {{ index .data "secret.txt" | b64dec }}
  {{- else }}
  secret.txt: {{ randAlphaNum 32 }}
  {{- end }}
{{- end -}}
