{{/* poddisruptionbudget Class */}}
{{/* Call this template:
{{ include "tc.v1.common.class.podDisruptionBudget" (dict "rootCtx" $ "objectData" $objectData) }}

rootCtx: The root context of the chart.
objectData:
  name: The name of the podDisruptionBudget.
  labels: The labels of the podDisruptionBudget.
  annotations: The annotations of the podDisruptionBudget.
  data: The data of the podDisruptionBudget.
  namespace: The namespace of the podDisruptionBudget. (Optional)
*/}}

{{- define "tc.v1.common.class.podDisruptionBudget" -}}

  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData }}
---
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: {{ $objectData.name }}
  namespace: {{ include "tc.v1.common.lib.metadata.namespace" (dict "rootCtx" $rootCtx "objectData" $objectData "caller" "Pod Disruption Budget") }}
  {{- $labels := (mustMerge ($objectData.labels | default dict) (include "tc.v1.common.lib.metadata.allLabels" $rootCtx | fromYaml)) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- $annotations := (mustMerge ($objectData.annotations | default dict) (include "tc.v1.common.lib.metadata.allAnnotations" $rootCtx | fromYaml)) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}
spec:
  selector:
    matchLabels:
    {{- if $objectData.customLabels -}}
      {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "labels" $objectData.customLabels) | trim) }}
        {{- . | nindent 6 }}
      {{- end -}}
    {{- else -}}
      {{- $selectedPod := fromJson (include "tc.v1.common.lib.helpers.getSelectedPodValues" (dict "rootCtx" $rootCtx "objectData" $objectData "caller" "Pod Disruption Budget")) }}
      {{- include "tc.v1.common.lib.metadata.selectorLabels" (dict "rootCtx" $rootCtx "objectType" "pod" "objectName" $selectedPod.shortName) | nindent 6 }}
    {{- end -}}
  {{- if hasKey $objectData "minAvailable" }}
  minAvailable: {{ tpl (toString $objectData.minAvailable) $rootCtx }}
  {{- end -}}
  {{- if hasKey $objectData "maxUnavailable" }}
  maxUnavailable: {{ tpl (toString $objectData.maxUnavailable) $rootCtx }}
  {{- end -}}
  {{- with $objectData.unhealthyPodEvictionPolicy }}
  unhealthyPodEvictionPolicy: {{ tpl . $rootCtx }}
  {{- end -}}
{{- end -}}
