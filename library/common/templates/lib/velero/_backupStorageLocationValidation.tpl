{{/* Velero BackupStorageLocation Validation */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.velero.backupstoragelocation.validation" (dict "objectData" $objectData) -}}
objectData:
  rootCtx: The root context of the chart.
  objectData: The backupstoragelocation object.
*/}}

{{- define "tc.v1.common.lib.velero.backupstoragelocation.validation" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- if not $objectData.provider -}}
    {{- fail "Backup Storage Location - Expected non-empty [provider]" -}}
  {{- end -}}

  {{- if not $objectData.credential -}}
    {{- fail "Backup Storage Location - Expected non-empty [credential]" -}}
  {{- end -}}

  {{- if not $objectData.credential.name -}}
    {{- fail "Backup Storage Location - Expected non-empty [credential.name]" -}}
  {{- end -}}

  {{- if not $objectData.credential.key -}}
    {{- fail "Backup Storage Location - Expected non-empty [credential.key]" -}}
  {{- end -}}

  {{- if $objectData.accessMode -}}
    {{- $validModes := (list "ReadOnly" "ReadWrite") -}}
    {{- if not (mustHas $objectData.accessMode $validModes) -}}
      {{- fail (printf "Backup Storage Location - Expected [accessMode] to be one of [%s], but got [%s]" (join ", " $validModes) $objectData.accessMode) -}}
    {{- end -}}
  {{- end -}}

  {{- if not $objectData.objectStorage -}}
    {{- fail "Backup Storage Location - Expected non-empty [objectStorage]" -}}
  {{- end -}}

  {{- if not $objectData.objectStorage.bucket -}}
    {{- fail "Backup Storage Location - Expected non-empty [objectStorage.bucket]" -}}
  {{- end -}}
{{- end -}}
