{{/* Define the secrets */}}
{{- define "nocodb.secrets" -}}
{{- $nocodbprevious := lookup "v1" "Secret" .Release.Namespace "nocodb-secrets" }}
{{- $auth_jwt_token := "" }}
enabled: true
data:
  {{- if $nocodbprevious}}
  NC_AUTH_JWT_SECRET: {{ index $nocodbprevious.data "NC_AUTH_JWT_SECRET" | b64dec }}
  {{- else }}
    {{- $auth_jwt_token := randAlphaNum 32 }}
  NC_AUTH_JWT_SECRET: {{ $auth_jwt_token }}
  {{- end }}

{{- end -}}
