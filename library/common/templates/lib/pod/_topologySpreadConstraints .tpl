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

  {{- $validTypes := (list "Deployment" "StatefulSet") -}}
  {{- if and (mustHas $objectData.type $validTypes) $rootCtx.Values.podOptions.defaultSpread }}
- maxSkew: 1
  whenUnsatisfiable: ScheduleAnyway
  topologyKey: "kubernetes.io/hostname"
  labelSelector:
    matchLabels:
      {{- include "tc.v1.common.lib.metadata.selectorLabels" (dict "rootCtx" $rootCtx "objectType" "pod" "objectName" $objectData.shortName) | indent 6 }}
  nodeAffinityPolicy: Honor
  nodeTaintsPolicy: Honor
  {{- end -}}
  {{- with $constraints -}} {{/* TODO: Template this, so we can add some validation around easy to make mistakes. Low Prio */}}
    {{- . | toYaml | nindent 0 }}
  {{- end -}}
{{- end -}}
