{{/* Returns ixVolume Volume */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.pod.volume.ixVolume" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the volume.
*/}}
{{- define "tc.v1.common.lib.pod.volume.ixVolume" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $hostPathType := "" -}}
  {{- if $objectData.hostPathType -}}
    {{- $hostPathType = tpl $objectData.hostPathType $rootCtx -}}
  {{- end -}}

  {{- if not $objectData.datasetName -}}
    {{- fail "Persistence - Expected non-empty <datasetName> on <ixVolume> type" -}}
  {{- end -}}
  {{- $datasetName := tpl $objectData.datasetName $rootCtx -}}

  {{- if not $rootCtx.Values.ixVolumes -}}
    {{- fail "Persistence - Expected non-empty <ixVolumes> in values on <ixVolume> type" -}}
  {{- end -}}

  {{- $hostPath := "" -}}
  {{- $found := false -}}
  {{- range $idx, $normalizedHostPath := $rootCtx.Values.ixVolumes -}}
    {{- if eq $datasetName (base $normalizedHostPath.hostPath) -}}
      {{- $found = true -}}
      {{- $hostPath = $normalizedHostPath.hostPath -}}
    {{- end -}}
  {{- end -}}

  {{- if not $found -}} {{/* If we go over the ixVolumes and we dont find a match, fail */}}
    {{- $datasets := list -}}
    {{- range $rootCtx.Values.ixVolumes -}}
      {{- $datasets = mustAppend $datasets (base .hostPath) -}}
    {{- end -}}
    {{- fail (printf "Persistence - Expected <datasetName> [%s] to exist on <ixVolumes> list, but list contained [%s] on <ixVolume> type" $datasetName (join ", " $datasets)) -}}
  {{- end -}}

  {{- if not (hasPrefix "/" $hostPath) -}}
    {{- fail "Persistence - Expected normalized path from <ixVolumes> to start with a forward slash [/] on <ixVolume> type" -}}
  {{- end -}}

  {{- $types := (list "DirectoryOrCreate" "Directory" "FileOrCreate" "File" "Socket" "CharDevice" "BlockDevice") -}}
  {{- if and $hostPathType (not (mustHas $hostPathType $types)) -}}
    {{- fail (printf "Persistence - Expected <hostPathType> to be one of [%s], but got [%s]" (join ", " $types) $hostPathType) -}}
  {{- end }}
- name: {{ $objectData.shortName }}
  hostPath:
    path: {{ $hostPath }}
    {{- with $hostPathType }}
    type: {{ $hostPathType }}
    {{- end -}}
{{- end -}}
