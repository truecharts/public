{{/* Velero VolumeSnapshotLocation Validation */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.velero.volumesnapshotlocation.validation" (dict "objectData" $objectData) -}}
objectData:
  rootCtx: The root context of the chart.
  objectData: The persistence object.
*/}}

{{- define "tc.v1.common.lib.velero.volumesnapshotlocation.validation" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- if not $objectData.provider -}}
    {{- fail "Volume Snapshot Location - Expected non-empty [provider]" -}}
  {{- end -}}

  {{- if not $objectData.config -}}
    {{- fail "Volume Snapshot Location - Expected non-empty [config]" -}}
  {{- end -}}

  {{- if not $objectData.config.provider -}}
    {{- fail "Volume Snapshot Location - Expected non-empty [config.provider]" -}}
  {{- end -}}

  {{- if not $objectData.credential -}}
    {{- fail "Volume Snapshot Location - Expected non-empty [credential]" -}}
  {{- end -}}

  {{- if not $objectData.credential.name -}}
    {{- fail "Volume Snapshot Location - Expected non-empty [credential.name]" -}}
  {{- end -}}

  {{- if not $objectData.credential.key -}}
    {{- fail "Volume Snapshot Location - Expected non-empty [credential.key]" -}}
  {{- end -}}

{{- end -}}
