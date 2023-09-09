{{/* Define the secret */}}
{{- define "kopia.secrets" -}}
{{- $secretName := (printf "%s-kopia-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) -}}

{{- $kopia := .Values.kopia -}}

enabled: true
data:
  USER: {{ $kopia.user | default "user" | quote }}
  KOPIA_PASSWORD: {{ $kopia.password | default "secret" | quote }}
{{- end }}
