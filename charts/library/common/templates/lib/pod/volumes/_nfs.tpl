{{/* Returns NFS Volume */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.pod.volume.nfs" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the volume.
*/}}
{{- define "tc.v1.common.lib.pod.volume.nfs" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- if not $objectData.path -}}
    {{- fail "Persistence - Expected non-empty [path] on [nfs] type" -}}
  {{- end -}}

  {{- $path := tpl $objectData.path $rootCtx -}}
  {{- if not (hasPrefix "/" $path) -}}
    {{- fail "Persistence - Expected [path] to start with a forward slash [/] on [nfs] type" -}}
  {{- end -}}

  {{- if not $objectData.server -}}
    {{- fail "Persistence - Expected non-empty [server] on [nfs] type" -}}
  {{- end }}
- name: {{ $objectData.shortName }}
  nfs:
    path: {{ $path }}
    server: {{ tpl $objectData.server $rootCtx }}
{{- end -}}
