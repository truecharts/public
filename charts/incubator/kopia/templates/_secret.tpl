{{/* Define the secret */}}
{{- define "kopia.secret" -}}

enabled: true
data:
  KOPIA_PASSWORD: {{ .Values.kopia.password | default "" }}
  KOPIA_SERVER_USERNAME: {{ .Values.kopia.server_password | default "user" }}
  KOPIA_SERVER_PASSWORD: {{ .Values.kopia.server_password | default "password" }}
{{- end }}
