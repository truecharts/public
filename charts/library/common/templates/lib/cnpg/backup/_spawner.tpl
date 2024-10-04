{{- define "tc.v1.common.lib.cnpg.spawner.backups" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- range $backup := $objectData.backups.manualBackups -}}
    {{- $_ := set $objectData "backupName" $backup.name -}}
    {{- $_ := set $objectData "backupLabels" $backup.labels -}}
    {{- $_ := set $objectData "backupAnnotations" $backup.annotations -}}

    {{- include "tc.v1.common.lib.cnpg.backup.validation" (dict "rootCtx" $rootCtx "objectData" $objectData) -}}
    {{- include "tc.v1.common.class.cnpg.backup" (dict "rootCtx" $rootCtx "objectData" $objectData) -}}
  {{- end -}}

{{- end -}}
