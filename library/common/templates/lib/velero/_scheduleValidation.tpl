{{/* Velero Schedule Validation */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.velero.schedule.validation" (dict "objectData" $objectData) -}}
objectData:
  rootCtx: The root context of the chart.
  objectData: The schedule object.
*/}}

{{- define "tc.v1.common.lib.velero.schedule.validation" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- if not $objectData.schedule -}}
    {{- fail "Velero Schedule - Expected non-empty [schedule]" -}}
  {{- end -}}

  {{- if (hasKey $objectData "useOwnerReferencesInBackup") -}}
    {{- if not (kindIs "bool" $objectData.useOwnerReferencesInBackup) -}}
      {{ fail "Velero Schedule - Expected [useOwnerReferencesInBackup] to be a boolean" -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
