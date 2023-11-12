{{/* Returns device (hostPath) Volume */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.pod.volume.device" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the volume.
*/}}
{{- define "tc.v1.common.lib.pod.volume.device" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $hostPathType := "" -}}
  {{- if $objectData.hostPathType -}}
    {{- $hostPathType = tpl $objectData.hostPathType $rootCtx -}}
  {{- end -}}

  {{- if not $objectData.hostPath -}}
    {{- fail "Persistence - Expected non-empty [hostPath] on [device] type" -}}
  {{- end -}}
  {{- $hostPath := tpl $objectData.hostPath $rootCtx -}}

  {{- if not (hasPrefix "/" $hostPath) -}}
    {{- fail "Persistence - Expected [hostPath] to start with a forward slash [/] on [device] type" -}}
  {{- end -}}

  {{- $charDevices := (list "tty") -}}
  {{- if not $hostPathType -}}
    {{- range $char := $charDevices -}}
      {{- if hasPrefix (printf "/dev/%v" $char) $hostPath -}}
        {{- $hostPathType = "CharDevice" -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- $blockDevices := (list "sd" "hd" "nvme") -}}
  {{- if not $hostPathType -}}
    {{- range $block := $blockDevices -}}
      {{- if hasPrefix (printf "/dev/%v" $block) $hostPath -}}
        {{- $hostPathType = "BlockDevice" -}}
      {{- end -}}
    {{- end -}}
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
