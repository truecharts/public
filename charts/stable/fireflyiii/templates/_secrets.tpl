{{/* Define the secrets */}}
{{- define "fireflyiii.secrets" -}}
---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: fireflyiii-secrets
{{- $fireflyiiiprevious := lookup "v1" "Secret" .Release.Namespace "fireflyiii-secrets" }}
{{- $static_cron_token := "" }}
data:
{{- if $fireflyiiiprevious}}
  STATIC_CRON_TOKEN: {{ index $fireflyiiiprevious.data "STATIC_CRON_TOKEN" }}
  {{- else }}
  {{- $static_cron_token := randAlphaNum 32 }}
  STATIC_CRON_TOKEN: {{ $encryptionkey | b64enc | quote }}
  {{- end }}

{{- end -}}
