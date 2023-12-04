{{- define "tc.v1.common.lib.cnpg.provider.backupValidation" -}}
  {{- $objectData := .objectData -}}
  {{- $provider := $objectData.backups.provider -}}

  {{- include "tc.v1.common.lib.cnpg.provider.validation" (dict
        "objectData" $objectData
        "key" "backups" "caller" "CNPG Backup"
        "provider" $provider) -}}

  {{- if not (get $objectData.backups $provider) -}}
    {{- fail (printf "CNPG Backup - Expected [backups.%s] to be defined when [backups.provider] is set to [%s]" $provider $provider) -}}
  {{- end -}}

{{- end -}}
