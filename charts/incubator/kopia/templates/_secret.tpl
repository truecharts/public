{{/* Define the secret */}}
{{- define "kopia.secret" -}}

enabled: true
data:
  USER: {{ .Values.kopia.user | default "user" }}
  KOPIA_PASSWORD: {{ .Values.kopia.password | default "secret" }}
  KOPIA_SERVER_USERNAME: {{ .Values.kopia.server_username | default "server_user" }}
  KOPIA_SERVER_PASSWORD: {{ .Values.kopia.server_password | default "server_password" }}
{{- end }}
