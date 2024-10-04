{{/* NFS CSI */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.storage.nfsCSI" (dict "rootCtx" $ "objectData" $objectData) }}

rootCtx: The root context of the chart.
objectData:
  driver: The name of the driver.
  server: The server address.
  share: The share to the NFS share.
*/}}
{{- define "tc.v1.common.lib.storage.nfsCSI" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData }}
csi:
  driver: {{ $objectData.static.driver }}
  {{- /* Create a unique handle, server/share#release-app-volumeName */}}
  volumeHandle: {{ printf "%s%s#%s" $objectData.static.server $objectData.static.share $objectData.name }}
  volumeAttributes:
    server: {{ tpl $objectData.static.server $rootCtx }}
    share: {{ tpl $objectData.static.share $rootCtx }}
{{- end -}}
