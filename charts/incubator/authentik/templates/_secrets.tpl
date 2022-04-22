{{/* Define the secrets */}}
{{- define "authentik.secrets" -}}
---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: authentik-secrets
{{- $authentikprevious := lookup "v1" "Secret" .Release.Namespace "authentik-secrets" }}
{{- $secret_key := "" }}
data:
  {{- if $authentikprevious}}
  AUTHENTIK_SECRET_KEY: {{ index $authentikprevious.data "AUTHENTIK_SECRET_KEY" }}
  {{- else }}
  {{- $secret_key := randAlphaNum 32 }}
  AUTHENTIK_SECRET_KEY: {{ $secret_key | b64enc }}
  {{- end }}

{{- end -}}
