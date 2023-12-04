{{- define "tc.v1.common.lib.cnpg.backup.validation" -}}
  {{- $objectData := .objectData -}}

  {{- if not $objectData.backupName -}}
    {{- fail "CNPG Backup - Expected non-empty [name] in [backups.manualBackups] entry" -}}
  {{- end -}}
{{- end -}}
