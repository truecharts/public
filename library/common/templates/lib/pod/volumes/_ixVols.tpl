{{- define "ix.v1.common.controller.volumes.ixVols" -}}
  {{- $index := .index -}}
  {{- $vol := .volume -}}
  {{- $root := .root -}}
  {{- if not $vol.datasetName -}}
    {{- fail (printf "Item (%s) is set as ixVolume type, but has no <datasetName> defined" $index) -}}
  {{- end -}}
  {{- $hostPath := "" -}}
  {{- if not $root.Values.ixVolumes -}}
    {{- fail "Key <ixVolumes> is empty. But persistence volumes of type ixVolumes is defined." -}}
  {{- end -}}
  {{- if $vol.hostPath -}}
    {{- fail (printf "Item (%s), is set as ixVolume but has hostPath defined. This is automatically calculated." $index) -}}
  {{- end -}}
  {{- range $idx, $normalizedHostPath := $root.Values.ixVolumes -}}
    {{- if eq $vol.datasetName (base $normalizedHostPath) -}} {{/* Make sure the resolved datasetName is included in ixVolumes */}}
      {{- $hostPath = $normalizedHostPath -}}
    {{- else -}}
      {{- fail (printf "Dataset Name (%s) on item (%s) does not exist in ixVolumes list" $vol.datasetName $index) -}}
    {{- end -}}
  {{- end }}
- name: {{ $index }}
  hostPath:
    path: {{ $hostPath }}
  {{- with $vol.hostPathType -}}
    {{- $type := (tpl . $root) -}}
    {{- include "ix.v1.common.controller.hostPathType.validation" (dict "index" $index "type" $type) }}
    type: {{ $type }}
  {{- end -}}
{{- end -}}
