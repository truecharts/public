{{/* poddisruptionbudget Spawwner */}}
{{/* Call this template:
{{ include "tc.v1.common.spawner.podDisruptionBudget" $ -}}
*/}}

{{- define "tc.v1.common.spawner.podDisruptionBudget" -}}
  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $ -}}

  {{- range $name, $pdb := .Values.podDisruptionBudget -}}
    {{- $enabled := false -}}
    {{- if hasKey $pdb "enabled" -}}
      {{- if not (kindIs "invalid" $pdb.enabled) -}}
        {{- $enabled = $pdb.enabled -}}
      {{- else -}}
        {{- fail (printf "Pod Disruption Budget - Expected the defined key [enabled] in <podDisruptionBudget.%s> to not be empty" $name) -}}
      {{- end -}}
    {{- end -}}

    {{- if kindIs "string" $enabled -}}
      {{- $enabled = tpl $enabled $ -}}

      {{/* After tpl it becomes a string, not a bool */}}
      {{-  if eq $enabled "true" -}}
        {{- $enabled = true -}}
      {{- else if eq $enabled "false" -}}
        {{- $enabled = false -}}
      {{- end -}}
    {{- end -}}

    {{- if $enabled -}}

      {{/* Create a copy of the poddisruptionbudget */}}
      {{- $objectData := (mustDeepCopy $pdb) -}}

      {{- $objectName := (printf "%s-%s" $fullname $name) -}}
      {{- if hasKey $objectData "expandObjectName" -}}
        {{- if not $objectData.expandObjectName -}}
          {{- $objectName = $name -}}
        {{- end -}}
      {{- end -}}

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
