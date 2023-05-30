{{/* Define the secrets */}}
{{- define "snipeit.secrets" -}}
---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: snipeit-secrets
{{- $snipeitprevious := lookup "v1" "Secret" .Release.Namespace "snipeit-secrets" }}
{{- $app_key := "" }}
data:
  {{- if $snipeitprevious}}
  APP_KEY: {{ index $snipeitprevious.data "APP_KEY" }}
  {{- else }}
  {{- $app_key := randAlphaNum 32 }}
  APP_KEY: {{ $app_key | b64enc }}
  {{- end }}

{{- end -}}
