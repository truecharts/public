{{/* poddisruptionbudget Spawwner */}}
{{/* Call this template:
{{ include "tc.v1.common.spawner.podDisruptionBudget" $ -}}
*/}}

{{- define "tc.v1.common.spawner.podDisruptionBudget" -}}
  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $ -}}

  {{- range $name, $pdb := .Values.podDisruptionBudget -}}
    {{- $enabled := (include "tc.v1.common.lib.util.enabled" (dict
                    "rootCtx" $ "objectData" $pdb
                    "name" $name "caller" "Pod Disruption Budget"
                    "key" "podDisruptionBudget")) -}}

    {{- if eq $enabled "true" -}}

      {{/* Create a copy of the poddisruptionbudget */}}
      {{- $objectData := (mustDeepCopy $pdb) -}}

      {{- $objectName := $name -}}

      {{- $expandName := (include "tc.v1.common.lib.util.expandName" (dict
                "rootCtx" $ "objectData" $objectData
                "name" $name "caller" "Pod Disruption Budget"
                "key" "podDisruptionBudget")) -}}

      {{- if eq $expandName "true" -}}
        {{- $objectName = (printf "%s-%s" $fullname $name) -}}
      {{- end -}}

      {{- include "tc.v1.common.lib.util.metaListToDict" (dict "objectData" $objectData) -}}

      {{/* Perform validations */}}
      {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $objectName) -}}
      {{- include "tc.v1.common.lib.metadata.validation" (dict "objectData" $objectData "caller" "Pod Disruption Budget") -}}

      {{/* Set the name of the poddisruptionbudget */}}
      {{- $_ := set $objectData "name" $objectName -}}
      {{- $_ := set $objectData "shortName" $name -}}

      {{- include "tc.v1.common.lib.podDisruptionBudget.validation" (dict "objectData" $objectData "rootCtx" $) -}}

      {{/* Call class to create the object */}}
      {{- include "tc.v1.common.class.podDisruptionBudget" (dict "rootCtx" $ "objectData" $objectData) -}}

    {{- end -}}

  {{- end -}}

{{- end -}}
