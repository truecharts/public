{{/* SMB CSI */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.storage.smbCSI" (dict "rootCtx" $ "objectData" $objectData) }}

rootCtx: The root context of the chart.
objectData:
  driver: The name of the driver.
  server: The server address.
  share: The share to the SMB share.
*/}}
{{- define "tc.v1.common.lib.storage.smbCSI" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData }}
csi:
  driver: {{ $objectData.static.driver }}
  {{- /* Create a unique handle, server/share#release-app-volumeName */}}
  volumeHandle: {{ printf "%s/%s#%s" $objectData.static.server $objectData.static.share $objectData.name }}
  volumeAttributes:
    source: {{ printf "//%v/%v" (tpl $objectData.static.server $rootCtx) (tpl $objectData.static.share $rootCtx) }}
  nodeStageSecretRef:
    name: {{ $objectData.name }}
    namespace: {{ $rootCtx.Release.Namespace }}
{{- end -}}
