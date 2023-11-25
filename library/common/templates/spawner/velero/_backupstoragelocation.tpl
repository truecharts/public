{{/* backupstoragelocation Spawwner */}}
{{/* Call this template:
{{ include "tc.v1.common.spawner.velero.backupstoragelocation" $ -}}
*/}}

{{- define "tc.v1.common.spawner.velero.backupstoragelocation" -}}
  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $ -}}

  {{- range $backupStorageLoc := .Values.backupStorageLocation -}}

    {{- $enabled := false -}}
    {{- if hasKey $backupStorageLoc "enabled" -}}
      {{- if not (kindIs "invalid" $backupStorageLoc.enabled) -}}
        {{- $enabled = $backupStorageLoc.enabled -}}
      {{- else -}}
        {{- fail (printf "Backup Storage Location - Expected the defined key [enabled] in [backupStorageLocation.%s] to not be empty" $backupStorageLoc.name) -}}
      {{- end -}}
    {{- end -}}

    {{- if kindIs "string" $enabled -}}
      {{- $enabled = tpl $enabled $ -}}

      {{/* After tpl it becomes a string, not a bool */}}
      {{-  if eq $enabled "true" -}}
        {{- $enabled = true -}}
      {{- else if eq $enabled "false" -}}
        {{- $enabled = false -}}
      {{- end -}}
    {{- end -}}

    {{- if $enabled -}}

      {{/* Create a copy of the backupstoragelocation */}}
      {{- $objectData := (mustDeepCopy $backupStorageLoc) -}}

      {{- if not $backupStorageLoc.name -}}
        {{- fail "Backup Storage Location - Expected non-empty [name]" -}}
      {{- end -}}

      {{- $objectName := (printf "%s-%s" $fullname $backupStorageLoc.name) -}}
      {{- if hasKey $objectData "expandObjectName" -}}
        {{- if not $objectData.expandObjectName -}}
          {{- $objectName = $backupStorageLoc.name -}}
        {{- end -}}
      {{- end -}}

      {{/* Set namespace to velero location or itself, just in case its used from within velero */}}
      {{- $operator := index $.Values.operator "velero" -}}
      {{- $namespace := $operator.namespace | default (include "tc.v1.common.lib.metadata.namespace" (dict "rootCtx" $ "objectData" $objectData "caller" "Backup Storage Location")) -}}
      {{- $_ := set $objectData "namespace" $namespace -}}

      {{/* Perform validations */}} {{/* backupstoragelocations have a max name length of 253 */}}
      {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $objectName "length" 253) -}}
      {{- include "tc.v1.common.lib.metadata.validation" (dict "objectData" $objectData "caller" "Backup Storage Location") -}}

      {{/* Set the name of the backupstoragelocation */}}
      {{- $_ := set $objectData "name" $objectName -}}
      {{- $_ := set $objectData "shortName" $backupStorageLoc.name -}}

      {{/* Create secret with creds for provider, if the provider is not matched, it will skip creation */}}
      {{- include "tc.v1.common.lib.velero.provider.secret" (dict "rootCtx" $ "objectData" $objectData "prefix" "bsl") -}}

      {{- include "tc.v1.common.lib.velero.backupstoragelocation.validation" (dict "objectData" $objectData) -}}

      {{/* Call class to create the object */}}
      {{- include "tc.v1.common.class.velero.backupstoragelocation" (dict "rootCtx" $ "objectData" $objectData) -}}

    {{- end -}}

  {{- end -}}

{{- end -}}
