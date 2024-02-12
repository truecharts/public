{{/* Define the secret */}}
{{- define "kopia.secrets" -}}
{{- $secretName := (printf "%s-kopia-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) -}}

{{- $kopia := .Values.kopia -}}

enabled: true
data:
  USER: {{ $kopia.user | default "kopia" | quote }}
  KOPIA_PASSWORD: {{ $kopia.password | default "repo_secret" | quote }}
  KOPIA_SERVER_USER: {{ $kopia.server_username | default "server_user" | quote }}
  KOPIA_SERVER_CONTROL_USER: {{ $kopia.server_username | default "server_user" | quote }}
  KOPIA_SERVER_PASSWORD: {{ $kopia.server_password | default "password" | quote }}
  KOPIA_SERVER_CONTROL_PASSWORD: {{ $kopia.server_password | default "password" | quote }}
{{- end }}
