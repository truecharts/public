{{/* Validate NFS CSI */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.storage.nfsCSI.validation" (dict "rootCtx" $ "objectData" $objectData) }}

rootCtx: The root context of the chart.
objectData:
  driver: The name of the driver.
  mountOptions: The mount options.
  server: The server address.
  share: The share to the NFS share.
*/}}
{{- define "tc.v1.common.lib.storage.nfsCSI.validation" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $required := (list "server" "share") -}}
  {{- range $item := $required -}}
    {{- if not (get $objectData.static $item) -}}
      {{- fail (printf "NFS CSI - Expected [%v] to be non-empty" $item) -}}
    {{- end -}}
  {{- end -}}

  {{- if not (hasPrefix "/" $objectData.static.share) -}}
    {{- fail "NFS CSI - Expected [share] to start with [/]" -}}
  {{- end -}}

  {{/* TODO: Allow only specific opts / set specific opts by default?
  {{- $validOpts := list -}} */}}
  {{- range $opt := $objectData.mountOptions -}}
    {{- if not (kindIs "map" $opt) -}}
      {{- fail (printf "NFS CSI - Expected [mountOption] item to be a dict, but got [%s]" (kindOf $opt)) -}}
    {{- end -}}
    {{- if not $opt.key -}}
      {{- fail "NFS CSI - Expected key in [mountOptions] to be non-empty" -}}
    {{- end -}}

  {{/*
    {{- $key := tpl $opt.key $rootCtx -}}
    {{- if not (mustHas $key $validOpts) -}}
      {{- fail (printf "NFS CSI - Expected [mountOptions] to be one of [%v], but got [%v]" (join ", " $validOpts) $opt) -}}
    {{- end -}}
  */}}
  {{- end -}}
{{- end -}}
