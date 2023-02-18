{{/* Returns automountServiceAccountToken */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.pod.automountServiceAccountToken" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the Pod.
*/}}
{{- define "tc.v1.common.lib.pod.automountServiceAccountToken" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $automount := false -}}

  {{/* Initialize from the "global" option */}}
  {{- if (kindIs "bool" $rootCtx.Values.podOptions.automountServiceAccountToken) -}}
    {{- $automount = $rootCtx.Values.podOptions.automountServiceAccountToken -}}
  {{- end -}}

  {{/* Override with pod's option */}}
  {{- if (kindIs "bool" $objectData.podSpec.automountServiceAccountToken) -}}
    {{- $automount = $objectData.podSpec.automountServiceAccountToken -}}
  {{- end -}}

  {{- $automount -}}
{{- end -}}
