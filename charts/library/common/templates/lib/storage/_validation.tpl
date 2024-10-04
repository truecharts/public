{{/* Persistence Validation */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.persistence.validation" (dict "objectData" $objectData) -}}
objectData:
  rootCtx: The root context of the chart.
  objectData: The persistence object.
*/}}

{{- define "tc.v1.common.lib.persistence.validation" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $types := (list "pvc" "vct" "emptyDir" "nfs" "iscsi" "hostPath" "secret" "configmap" "device" "projected") -}}
  {{- if not (mustHas $objectData.type $types) -}}
    {{- fail (printf "Persistence - Expected [type] to be one of [%s], but got [%s]" (join ", " $types) $objectData.type) -}}
  {{- end -}}

  {{- if and $objectData.static $objectData.static.mode -}}
    {{- $validModes := (list "disabled" "smb" "nfs" "custom") -}}
    {{- if not (mustHas $objectData.static.mode $validModes) -}}
      {{- fail (printf "Persistence - Expected [static.mode] to be one of [%s], but got [%s]" (join ", " $validModes) $objectData.static.mode) -}}
    {{- end -}}
  {{- end -}}

  {{- if $objectData.dataSource -}}
    {{- if not $objectData.dataSource.name -}}
      {{- fail "Persistence - Expected [dataSource.name] to be non-empty" -}}
    {{- end -}}

    {{- if not $objectData.dataSource.kind -}}
      {{- fail "Persistence - Expected [dataSource.kind] to be non-empty" -}}
    {{- end -}}

    {{- $validKinds := (list "VolumeSnapshot" "PersistentVolumeClaim") -}}
    {{- if not (mustHas $objectData.dataSource.kind $validKinds) -}}
      {{- fail (printf "Persistence - Expected [dataSource.kind] to be one of [%s], but got [%s]" (join ", " $validKinds) $objectData.dataSource.kind) -}}
    {{- end -}}
  {{- end -}}

  {{- if and $objectData.targetSelector (not (kindIs "map" $objectData.targetSelector)) -}}
    {{- fail (printf "Persistence - Expected [targetSelector] to be [dict], but got [%s]" (kindOf $objectData.targetSelector)) -}}
  {{- end -}}

{{- end -}}
