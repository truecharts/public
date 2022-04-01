{{/* Define the secrets */}}
{{- define "picoshare.secrets" -}}
---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: picoshare-secrets
{{- $picoshareprevious := lookup "v1" "Secret" .Release.Namespace "picoshare-secrets" }}
{{- $shared_key := "" }}
data:
  {{- if $picoshareprevious}}
  PS_SHARED_SECRET: {{ index $picoshareprevious.data "PS_SHARED_SECRET" }}
  {{- else }}
  {{- $shared_key := randAlphaNum 32 }}
  PS_SHARED_SECRET: {{ $shared_key | b64enc }}
  {{- end }}

{{- end -}}
