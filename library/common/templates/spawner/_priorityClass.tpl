{{/* priorityclass Spawwner */}}
{{/* Call this template:
{{ include "tc.v1.common.spawner.priorityclass" $ -}}
*/}}

{{- define "tc.v1.common.spawner.priorityclass" -}}
  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $ -}}

  {{- range $name, $priorityclass := .Values.priorityClass -}}

    {{- $enabled := false -}}
    {{- if hasKey $priorityclass "enabled" -}}
      {{- if not (kindIs "invalid" $priorityclass.enabled) -}}
        {{- $enabled = $priorityclass.enabled -}}
      {{- else -}}
        {{- fail (printf "Priority Class - Expected the defined key [enabled] in [priorityclass.%s] to not be empty" $name) -}}
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

      {{/* Create a copy of the priorityclass */}}
      {{- $objectData := (mustDeepCopy $priorityclass) -}}

      {{- $objectName := (printf "%s-%s" $fullname $name) -}}
      {{- if hasKey $objectData "expandObjectName" -}}
        {{- if not $objectData.expandObjectName -}}
          {{- $objectName = $name -}}
        {{- end -}}
      {{- end -}}

      {{/* Perform validations */}} {{/* priorityclasss have a max name length of 253 */}}
      {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $objectName "length" 253) -}}
      {{- include "tc.v1.common.lib.metadata.validation" (dict "objectData" $objectData "caller" "priorityclass") -}}

      {{/* Set the name of the priorityclass */}}
      {{- $_ := set $objectData "name" $objectName -}}
      {{- $_ := set $objectData "shortName" $name -}}

      {{/* Validate */}}
      {{- include "tc.v1.common.lib.priorityclass.validation" (dict "rootCtx" $ "objectData" $objectData) -}}
      {{/* Call class to create the object */}}
      {{- include "tc.v1.common.class.priorityclass" (dict "rootCtx" $ "objectData" $objectData) -}}

    {{- end -}}

  {{- end -}}

{{- end -}}
