{{/* Define the secrets */}}
{{- define "audiobookshelf.secrets" -}}
---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: audiobookshelf-secrets
{{- $audiobookshelfprevious := lookup "v1" "Secret" .Release.Namespace "audiobookshelf-secrets" }}
{{- $token_secret := "" }}
data:
  {{- if $audiobookshelfprevious}}
  TOKEN_SECRET: {{ index $audiobookshelfprevious.data "TOKEN_SECRET" }}
  {{- else }}
  {{- $token_secret := randAlphaNum 32 }}
  TOKEN_SECRET: {{ $token_secret | b64enc }}
  {{- end }}

{{- end -}}
