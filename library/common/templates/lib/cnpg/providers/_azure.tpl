{{- define "tc.v1.common.lib.cnpg.provider.azure.secret" -}}
{{- $creds := .creds }}
enabled: true
data:
  CONNECTION_STRING: {{ $creds.connectionString | default "" | quote }}
  STORAGE_ACCOUNT: {{ $creds.storageAccount | default "" | quote }}
  STORAGE_KEY: {{ $creds.storageKey | default "" | quote }}
  STORAGE_SAS_TOKEN: {{ $creds.storageSasToken | default "" | quote }}
{{- end -}}

{{- define "tc.v1.common.lib.cnpg.provider.azure.validation" -}}
  {{- $creds := .creds -}}

  {{- if and (not $creds.storageAccount) (not $creds.connectionString) -}}
    {{- fail "CNPG Backup - Expected [backups.azure.storageAccount] OR [backups.azure.connectionString] to be defined and non-empty when provider is set to [azure]" -}}
  {{- end -}}

  {{- if not $creds.connectionString -}}
    {{- if and (not $creds.storageKey) (not $creds.storageSasToken) -}}
      {{- fail "CNPG Backup - Expected [backups.azure.storageKey] OR [backups.azure.storageSasToken] to be defined and non-empty when provider is set to [azure]" -}}
    {{- end -}}

    {{- if and $creds.storageKey $creds.storageSasToken -}}
      {{- fail "CNPG Backup - Expected only one of [backups.azure.storageKey, backups.azure.storageSasToken] to be defined and non-empty when provider is set to [azure]" -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
