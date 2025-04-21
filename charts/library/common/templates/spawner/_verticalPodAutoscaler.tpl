{{/* Vertical Pod Autoscaler Spawner */}}
{{/* Call this template:
{{ include "tc.v1.common.spawner.vpa" $ -}}
*/}}

{{- define "tc.v1.common.spawner.vpa" -}}
  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $ -}}
  {{- range $name, $vpa := .Values.vpa -}}
    {{- $enabledVPA := (include "tc.v1.common.lib.util.enabled" (dict
                    "rootCtx" $ "objectData" $vpa
                    "name" $name "caller" "Vertical Pod Autoscaler"
                    "key" "vpa")) -}}

    {{- if ne $enabledVPA "true" -}}{{- continue -}}{{- end -}}

    {{- $objectData := (mustDeepCopy $vpa) -}}
    {{- range $workloadName, $workload := .Values.workload -}}

      {{- $enabled := (include "tc.v1.common.lib.util.enabled" (dict
                      "rootCtx" $ "objectData" $workload
                      "name" $name "caller" "vpa"
                      "key" "workload")) -}}

      {{- if ne $enabled "true" -}}{{- continue -}}{{- end -}}

      {{/* Create a copy of the workload */}}
      {{- $_ := set $objectData "workload" (mustDeepCopy $workload) -}}

      {{/* Generate the name of the vpa */}}
      {{- $objectName := $fullname -}}
      {{- if not $objectData.primary -}}
        {{- $objectName = printf "%s-%s" $fullname $workloadName -}}
      {{- end -}}

      {{/* Perform validations */}}
      {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $objectName) -}}
      {{- include "tc.v1.common.lib.metadata.validation" (dict "objectData" $objectData "caller" "Vertical Pod Autoscaler") -}}

      {{/* Set the name of the workload */}}
      {{- $_ := set $objectData "name" $objectName -}}

      {{/* Short name is the one that defined on the chart, used on selectors */}}
      {{- $_ := set $objectData "shortName" $workloadName -}}

      {{- if or (not $objectData.targetSelector) (hasKey $objectData.targetSelector $workloadName) -}}
        {{/* Call class to create the object */}}
        {{- $types := (list "Deployment" "StatefulSet" "DaemonSet") -}}
        {{- if (mustHas $objectData.workload.type $types) -}}
          {{- include "tc.v1.common.class.vpa" (dict "rootCtx" $ "objectData" $objectData) -}}
        {{- end -}}
      {{- end -}}

    {{- end -}}

{{- end -}}
