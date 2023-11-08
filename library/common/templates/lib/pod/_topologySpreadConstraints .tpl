{{/* Returns topologySpreadConstraints  */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.pod.topologySpreadConstraints" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the Pod.
*/}}
{{- define "tc.v1.common.lib.pod.topologySpreadConstraints" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $constraints := list -}}

  {{/* Initialize from the "global" option */}}
  {{- with $rootCtx.Values.podOptions.topologySpreadConstraints -}}
    {{- $constraints = . -}}
  {{- end -}}

  {{/* Override with pods option */}}
  {{- with $objectData.podSpec.topologySpreadConstraints -}}
    {{- $constraints = . -}}
  {{- end -}}

  {{- if and ( or ( eq $objectData.type "Deployment" ) ( eq $objectData.type "StatefulSet" )) $rootCtx.Values.podOptions.defaultSpread -}}
- maxSkew: 1
  whenUnsatisfiable: ScheduleAnyway
  topologyKey: "truecharts.org/rack"
  labelSelector:
    matchLabels:
      {{- include "tc.v1.common.lib.metadata.selectorLabels" (dict "rootCtx" $rootCtx "objectType" "pod" "objectName" $objectData.name) | indent 6 }}
  nodeAffinityPolicy: Honor
  nodeTaintsPolicy: Honor
- maxSkew: 1
  whenUnsatisfiable: ScheduleAnyway
  topologyKey: "kubernetes.io/hostname"
  labelSelector:
    matchLabels:
      {{- include "tc.v1.common.lib.metadata.selectorLabels" (dict "rootCtx" $rootCtx "objectType" "pod" "objectName" $objectData.name) | indent 6 }}
  nodeAffinityPolicy: Honor
  nodeTaintsPolicy: Honor
  {{- end -}}
  {{ with $constraints }}
{{ . | toYaml | indent 0 }}
  {{ end }}
{{- end -}}
