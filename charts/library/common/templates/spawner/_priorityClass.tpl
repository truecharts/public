{{/* Priority Class Spawner */}}
{{/* Call this template:
{{ include "tc.v1.common.spawner.priorityclass" $ -}}
*/}}

{{- define "tc.v1.common.spawner.priorityclass" -}}
  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $ -}}

  {{- range $name, $priorityclass := .Values.priorityClass -}}

    {{- $enabled := (include "tc.v1.common.lib.util.enabled" (dict
                    "rootCtx" $ "objectData" $priorityclass
                    "name" $name "caller" "Priority Class"
                    "key" "priorityClass")) -}}

    {{- if eq $enabled "true" -}}

      {{/* Create a copy of the priorityclass */}}
      {{- $objectData := (mustDeepCopy $priorityclass) -}}

      {{- $objectName := $name -}}

      {{- $expandName := (include "tc.v1.common.lib.util.expandName" (dict
                "rootCtx" $ "objectData" $objectData
                "name" $name "caller" "Priority Class"
                "key" "priorityClass")) -}}

      {{- if eq $expandName "true" -}}
        {{- $objectName = (printf "%s-%s" $fullname $name) -}}
      {{- end -}}

      {{- include "tc.v1.common.lib.util.metaListToDict" (dict "objectData" $objectData) -}}

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
