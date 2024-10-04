{{/* volumeSnapshot Validation */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.volumesnapshot.validation" (dict "objectData" $objectData) -}}
objectData:
  rootCtx: The root context of the chart.
  objectData: The volumesnapshot object.
*/}}

{{- define "tc.v1.common.lib.volumesnapshot.validation" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- if not $objectData.source -}}
    {{- fail "Volume Snapshot - Expected non empty [source]" -}}
  {{- end -}}

  {{- $sourceTypes := (list "volumeSnapshotContentName" "persistentVolumeClaimName") -}}
  {{- $sourceCount := 0 -}}
  {{- range $t := $sourceTypes -}}
    {{- if (get $objectData.source $t) -}}
      {{- $sourceCount = add1 $sourceCount -}}
    {{- end -}}
  {{- end -}}

  {{- if ne $sourceCount 1 -}}
    {{- fail (printf "Volume Snapshot - Expected exactly one of the valid source types [%s]. Found [%d]" (join ", " $sourceTypes) $sourceCount) -}}
  {{- end -}}

{{- end -}}
