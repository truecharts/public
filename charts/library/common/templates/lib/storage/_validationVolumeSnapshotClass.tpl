{{- define "tc.v1.common.lib.volumesnapshotclass.validation" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $validPolicies := (list "Retain" "Delete") -}}
  {{- if $objectData.deletionPolicy -}}
    {{- if not (mustHas $objectData.deletionPolicy $validPolicies) -}}
      {{- fail (printf "Volume Snapshot Class - Expected [deletionPolicy] to be one of [%s], but got [%s]" (join ", " $validPolicies) $objectData.deletionPolicy) -}}
    {{- end -}}
  {{- end -}}

  {{- if not $objectData.driver -}}
    {{- fail "Volume Snapshot Class - Expected non empty [driver]" -}}
  {{- end -}}
{{- end -}}
