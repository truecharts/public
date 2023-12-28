{{/* Define the secrets */}}
{{- define "ocis.secrets" -}}
{{- $secretName := (printf "%s-ocis-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}
{{- $ocisprevious := lookup "v1" "Secret" .Release.Namespace $secretName }}
enabled: true
data:
  {{- if $ocisprevious }}
  OCIS_JWT_SECRET: {{ index $ocisprevious.data "OCIS_JWT_SECRET" | b64dec }}
  STORAGE_TRANSFER_SECRET: {{ index $ocisprevious.data "STORAGE_TRANSFER_SECRET" | b64dec }}
  OCIS_MACHINE_AUTH_API_KEY: {{ index $ocisprevious.data "OCIS_MACHINE_AUTH_API_KEY" | b64dec }}
  {{- else }}
  {{- $ocis_jwt_secret := randAlphaNum 32 }}
  {{- $storage_transfer_secret := randAlphaNum 32 }}
  {{- $ocis_machine_auth_api_Key := randAlphaNum 32 }}
  OCIS_JWT_SECRET: {{ $ocis_jwt_secret }}
  STORAGE_TRANSFER_SECRET: {{ $storage_transfer_secret }}
  OCIS_MACHINE_AUTH_API_KEY: {{ $ocis_machine_auth_api_Key }}
  {{- end }}

{{- end -}}
