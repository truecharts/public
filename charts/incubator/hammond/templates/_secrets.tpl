{{/* Define the secrets */}}
{{- define "hammond.secrets" -}}
---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: hammond-secrets
{{- $hammondprevious := lookup "v1" "Secret" .Release.Namespace "hammond-secrets" }}
{{- $jwt_secret := "" }}
data:
  {{- if $hammondprevious}}
  JWT_SECRET: {{ index $hammondprevious.data "JWT_SECRET" }}
  {{- else }}
  {{- $jwt_secret := randAlphaNum 32 }}
  JWT_SECRET: {{ $jwt_secret | b64enc }}
  {{- end }}

{{- end -}}
