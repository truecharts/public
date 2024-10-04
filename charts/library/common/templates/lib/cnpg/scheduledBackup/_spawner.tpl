{{- define "tc.v1.common.lib.cnpg.spawner.scheduledBackups" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- range $schedBackup := $objectData.backups.scheduledBackups -}}
    {{- $_ := set $objectData "backupName" $schedBackup.name -}}
    {{- $_ := set $objectData "backupLabels" $schedBackup.labels -}}
    {{- $_ := set $objectData "backupAnnotations" $schedBackup.annotations -}}

    {{/* Make a copy of the objectData */}}
    {{- $newObjectData := mustDeepCopy $objectData -}}
    {{/* Add the scheduled backup data */}}
    {{- $_ := set $newObjectData "schedData" $schedBackup -}}

    {{- include "tc.v1.common.lib.cnpg.scheduledBackup.validation" (dict "objectData" $newObjectData) }}
    {{- include "tc.v1.common.class.cnpg.scheduledbackup" (dict "rootCtx" $rootCtx "objectData" $newObjectData) -}}
  {{- end -}}
{{- end -}}
