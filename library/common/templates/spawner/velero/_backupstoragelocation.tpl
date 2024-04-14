{{/* backupstoragelocation Spawwner */}}
{{/* Call this template:
{{ include "tc.v1.common.spawner.velero.backupstoragelocation" $ -}}
*/}}

{{- define "tc.v1.common.spawner.velero.backupstoragelocation" -}}
  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $ -}}

  {{- range $name, $backupStorageLoc := .Values.backupStorageLocation -}}

    {{- $enabled := (include "tc.v1.common.lib.util.enabled" (dict
                    "rootCtx" $ "objectData" $backupStorageLoc
                    "name" $name "caller" "Velero Backup Storage Location"
                    "key" "backupStorageLocation")) -}}

    {{- if eq $enabled "true" -}}

      {{/* Create a copy of the backupstoragelocation */}}
      {{- $objectData := (mustDeepCopy $backupStorageLoc) -}}
      {{- $objectName := $name -}}

      {{- $expandName := (include "tc.v1.common.lib.util.expandName" (dict
                "rootCtx" $ "objectData" $objectData
                "name" $name "caller" "Velero Backup Storage Location"
                "key" "backupStorageLocation")) -}}

      {{- if eq $expandName "true" -}}
        {{- $objectName = (printf "%s-%s" $fullname $name) -}}
      {{- end -}}

      {{- include "tc.v1.common.lib.util.metaListToDict" (dict "objectData" $objectData) -}}

      {{/* Perform validations */}} {{/* backupstoragelocations have a max name length of 253 */}}
      {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $objectName "length" 253) -}}
      {{- include "tc.v1.common.lib.metadata.validation" (dict "objectData" $objectData "caller" "Backup Storage Location") -}}

      {{/* Set the name of the backupstoragelocation */}}
      {{- $_ := set $objectData "name" $objectName -}}
      {{- $_ := set $objectData "shortName" $name -}}

      {{/* Create secret with creds for provider, if the provider is not matched, it will skip creation */}}
      {{- include "tc.v1.common.lib.velero.provider.secret" (dict "rootCtx" $ "objectData" $objectData "prefix" "bsl") -}}

      {{- include "tc.v1.common.lib.velero.backupstoragelocation.validation" (dict "objectData" $objectData) -}}

      {{/* Call class to create the object */}}
      {{- include "tc.v1.common.class.velero.backupstoragelocation" (dict "rootCtx" $ "objectData" $objectData) -}}

    {{- end -}}

  {{- end -}}

{{- end -}}
