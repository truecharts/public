{{- define "tc.v1.common.lib.cnpg.scheduledBackup.validation" -}}
  {{- $objectData := .objectData -}}

  {{- if not $objectData.backupName -}}
    {{- fail "CNPG Scheduled Backup - Expected non-empty [name] in [backups.scheduledBackups] entry" -}}
  {{- end -}}

  {{- if not $objectData.schedData.schedule -}}
    {{- fail "CNPG Scheduled Backup - Expected non-empty [schedule] in [backups.scheduledBackups] entry" -}}
  {{- end -}}

  {{- if (hasKey $objectData.schedData "backupOwnerReference") -}}
    {{- $validOwnerRefs := (list "none" "self" "cluster") -}}
    {{- if not (mustHas $objectData.schedData.backupOwnerReference $validOwnerRefs) -}}
      {{- fail (printf "CNPG Scheduled Backup - Expected [backupOwnerReference] in [backups.scheduledBackups] entry to be one of [%s], but got [%s]" (join ", " $validOwnerRefs) $objectData.schedData.backupOwnerReference) -}}
    {{- end -}}
  {{- end -}}

  {{- if (hasKey $objectData.schedData "immediate") -}}
    {{- if not (kindIs "bool" $objectData.schedData.immediate) -}}
      {{- fail (printf "CNPG Scheduled Backup - Expected [immediate] in [backups.scheduledBackups] entry to be a boolean, but got [%s]" (kindOf $objectData.schedData.immediate)) -}}
    {{- end -}}
  {{- end -}}

  {{- if (hasKey $objectData.schedData "suspend") -}}
    {{- if not (kindIs "bool" $objectData.schedData.suspend) -}}
      {{- fail (printf "CNPG Scheduled Backup - Expected [suspend] in [backups.scheduledBackups] entry to be a boolean, but got [%s]" (kindOf $objectData.schedData.suspend)) -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
