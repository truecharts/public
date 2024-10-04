{{/* Returns hostPath Volume */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.pod.volume.hostPath" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the volume.
*/}}
{{- define "tc.v1.common.lib.pod.volume.hostPath" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $hostPathType := "" -}}
  {{- if $objectData.hostPathType -}}
    {{- $hostPathType = tpl $objectData.hostPathType $rootCtx -}}
  {{- end -}}

  {{- if not $objectData.hostPath -}}
    {{- fail "Persistence - Expected non-empty [hostPath] on [hostPath] type" -}}
  {{- end -}}
  {{- $hostPath := tpl $objectData.hostPath $rootCtx -}}

  {{- if not (hasPrefix "/" $hostPath) -}}
    {{- fail "Persistence - Expected [hostPath] to start with a forward slash [/] on [hostPath] type" -}}
  {{- end -}}

  {{- $types := (list "DirectoryOrCreate" "Directory" "FileOrCreate" "File" "Socket" "CharDevice" "BlockDevice") -}}
  {{- if and $hostPathType (not (mustHas $hostPathType $types)) -}}
    {{- fail (printf "Persistence - Expected [hostPathType] to be one of [%s], but got [%s]" (join ", " $types) $hostPathType) -}}
  {{- end }}
- name: {{ $objectData.shortName }}
  hostPath:
    path: {{ $hostPath }}
    {{- with $hostPathType }}
    type: {{ $hostPathType }}
    {{- end -}}
{{- end -}}
