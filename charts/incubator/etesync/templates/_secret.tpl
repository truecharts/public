{{/* EteSync superuser credentials and Django SECRET_KEY */}}
{{- define "etesync.secret" -}}
enabled: true
data:
  {{- with (lookup "v1" "Secret" .Release.Namespace "etesync-secret") }}
  secret.txt: {{ index .data "secret.txt" }}
  {{- else }}
  secret.txt: {{ randAlphaNum 32 | b64enc }}
  {{- end }}

{{- end }}
