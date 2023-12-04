{{- define "tc.v1.common.lib.cnpg.provider.s3.secret" -}}
{{- $creds := .creds }}
enabled: true
data:
  ACCESS_KEY_ID: {{ $creds.accessKey | default "" | quote }}
  ACCESS_SECRET_KEY: {{ $creds.secretKey | default "" | quote }}
{{- end -}}

{{- define "tc.v1.common.lib.cnpg.provider.s3.validation" -}}
  {{- $creds := .creds -}}

  {{- if not $creds.secretKey -}}
    {{- fail "CNPG Backup - Expected [backups.s3.secretKey] to be defined and non-empty when provider is set to [s3]" -}}
  {{- end -}}

  {{- if not $creds.accessKey -}}
    {{- fail "CNPG Backup - Expected [backups.s3.accessKey] to be defined and non-empty when provider is set to [s3]" -}}
  {{- end -}}
{{- end -}}
