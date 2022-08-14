{{/* Define the secrets */}}
{{- define "inventree.secrets" -}}
---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: inventree-secrets
{{- $inventreeprevious := lookup "v1" "Secret" .Release.Namespace "inventree-secrets" }}
{{- $secret_key := "" }}
data:
  {{- if $inventreeprevious}}
  INVENTREE_SECRET_KEY: {{ index $inventreeprevious.data "INVENTREE_SECRET_KEY" }}
  {{- else }}
  {{- $secret_key := randAlphaNum 32 }}
  INVENTREE_SECRET_KEY: {{ $secret_key | b64enc }}
  {{- end }}

{{- end -}}
