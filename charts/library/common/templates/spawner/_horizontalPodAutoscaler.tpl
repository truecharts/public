{{/* horizontal Pod Autoscaler Spawner */}}
{{/* Call this template:
{{ include "tc.v1.common.spawner.hpa" $ -}}
*/}}

{{- define "tc.v1.common.spawner.hpa" -}}
  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $ -}}
  {{- range $name, $hpa := .Values.hpa -}}
    {{- $enabledhpa := (include "tc.v1.common.lib.util.enabled" (dict
                    "rootCtx" $ "objectData" $hpa
                    "name" $name "caller" "horizontal Pod Autoscaler"
                    "key" "hpa")) -}}

    {{- if ne $enabledhpa "true" -}}{{- continue -}}{{- end -}}

    {{- $objectData := (mustDeepCopy $hpa) -}}
    {{- $_ := set $objectData "hpaName" $name -}}
    {{- include "tc.v1.common.lib.hpa.validation" (dict "objectData" $objectData "rootCtx" $) -}}
    {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $name) -}}

    {{- range $workloadName, $workload := $.Values.workload -}}

      {{- $enabled := (include "tc.v1.common.lib.util.enabled" (dict
                      "rootCtx" $ "objectData" $workload
                      "name" $name "caller" "hpa"
                      "key" "workload")) -}}

      {{- if ne $enabled "true" -}}{{- continue -}}{{- end -}}

      {{/* Create a copy of the workload */}}
      {{- $_ := set $objectData "workload" (mustDeepCopy $workload) -}}

      {{/* Generate the name of the hpa */}}
      {{- $objectName := $fullname -}}
      {{- if not $objectData.workload.primary -}}
        {{- $objectName = printf "%s-%s" $fullname $workloadName -}}
      {{- end -}}

      {{/* Perform validations */}}
      {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $objectName) -}}
      {{- include "tc.v1.common.lib.metadata.validation" (dict "objectData" $objectData "caller" "horizontal Pod Autoscaler") -}}

      {{/* Set the name of the workload */}}
      {{- $_ := set $objectData "name" $objectName -}}

      {{/* Short name is the one that defined on the chart, used on selectors */}}
      {{- $_ := set $objectData "shortName" $workloadName -}}

      {{- if or (not $objectData.targetSelector) (hasKey $objectData.targetSelector $workloadName) -}}
        {{/* Call class to create the object */}}
        {{- $types := (list "Deployment" "StatefulSet" "DaemonSet") -}}
        {{- if (mustHas $objectData.workload.type $types) -}}
          {{- include "tc.v1.common.class.hpa" (dict "rootCtx" $ "objectData" $objectData) -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
