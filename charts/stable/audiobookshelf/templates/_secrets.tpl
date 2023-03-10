{{/* Define the secrets */}}
{{- define "audiobookshelf.secrets" -}}

data:
  {{- if $audiobookshelfprevious}}
  TOKEN_SECRET: {{ index $audiobookshelfprevious.data "TOKEN_SECRET" }}
  {{- else }}
  {{- $token_secret := randAlphaNum 32 }}
  TOKEN_SECRET: {{ $token_secret | b64enc }}
  {{- end }}

{{- end -}}
