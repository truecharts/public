{{/* Returns Host IPC */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.pod.hostIPC" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the Pod.
*/}}
{{- define "tc.v1.common.lib.pod.hostIPC" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $hostIPC := false -}}

  {{/* Initialize from the "global" option */}}
  {{- if (kindIs "bool" $rootCtx.Values.podOptions.hostIPC) -}}
    {{- $hostIPC = $rootCtx.Values.podOptions.hostIPC -}}
  {{- end -}}

  {{/* Override with pods option */}}
  {{- if (kindIs "bool" $objectData.podSpec.hostIPC) -}}
    {{- $hostIPC = $objectData.podSpec.hostIPC -}}
  {{- end -}}

  {{- $hostIPC -}}
{{- end -}}
