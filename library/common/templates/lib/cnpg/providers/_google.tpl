{{- define "tc.v1.common.lib.cnpg.provider.google.secret" -}}
{{- $creds := .creds }}
enabled: true
data:
  APPLICATION_CREDENTIALS: {{ $creds.applicationCredentials | default "" | quote }}
{{- end -}}

{{- define "tc.v1.common.lib.cnpg.provider.google.validation" -}}
  {{- $creds := .creds -}}

  {{- if not $creds.applicationCredentials -}}
    {{- fail "CNPG Backup - Expected [backups.google.applicationCredentials] to be defined and non-empty when provider is set to [google]" -}}
  {{- end -}}
{{- end -}}
