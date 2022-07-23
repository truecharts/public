{{/* Define the secrets */}}
{{- define "ocis.secrets" -}}
---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: ocis-secrets
{{- $ocisprevious := lookup "v1" "Secret" .Release.Namespace "ocis-secrets" }}
{{- $ocis_jwt_secret := "" }}
{{- $storage_transfer_secret := "" }}
{{- $ocis_machine_auth_api_Key := "" }}
data:
  {{- if $ocisprevious}}
  OCIS_JWT_SECRET: {{ index $ocisprevious.data "OCIS_JWT_SECRET" }}
  STORAGE_TRANSFER_SECRET: {{ index $ocisprevious.data "STORAGE_TRANSFER_SECRET" }}
  OCIS_MACHINE_AUTH_API_KEY: {{ index $ocisprevious.data "OCIS_MACHINE_AUTH_API_KEY" }}
  {{- else }}
  {{- $ocis_jwt_secret := randAlphaNum 32 }}
  {{- $storage_transfer_secret := randAlphaNum 32 }}
  {{- $ocis_machine_auth_api_Key := randAlphaNum 32 }}
  OCIS_JWT_SECRET: {{ $ocis_jwt_secret | b64enc }}
  STORAGE_TRANSFER_SECRET: {{ $storage_transfer_secret | b64enc }}
  OCIS_MACHINE_AUTH_API_KEY: {{ $ocis_machine_auth_api_Key | b64enc }}
  {{- end }}

{{- end -}}
