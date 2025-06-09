{{/* Labels that are added to podSpec */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.metadata.volumeLabels" $ }}
*/}}
{{- define "tc.v1.common.lib.metadata.volumeLabels" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}
  {{- $selectedVolumes := (include "tc.v1.common.lib.pod.volumes.selected" (dict "rootCtx" $rootCtx "objectData" $objectData)) | fromJson }}

  {{- $names := list -}}
  {{- range $volume := $selectedVolumes.pvc -}}
    {{- $names = mustAppend $names $volume.shortName -}}
  {{- end }}

truecharts.org/pvc: {{ $names | join "_" | quote }}
{{- end -}}
