{{/* schedule Spawwner */}}
{{/* Call this template:
{{ include "tc.v1.common.spawner.velero.schedule" $ -}}
*/}}

{{- define "tc.v1.common.spawner.velero.schedule" -}}
  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $ -}}

  {{- range $name, $schedule := .Values.schedules -}}

    {{- $enabled := (include "tc.v1.common.lib.util.enabled" (dict
                    "rootCtx" $ "objectData" $schedule
                    "name" $name "caller" "Velero Schedule"
                    "key" "schedules")) -}}

    {{- if eq $enabled "true" -}}
      {{/* Create a copy of the schedule */}}
      {{- $objectData := (mustDeepCopy $schedule) -}}

      {{- $objectName := $name -}}

      {{/*
        Default to false for schedule objects.
        This is because those objects are usualy used
        from the velero cli and having the object expanded
        would make it harder to use the cli.
      */}}
      {{- if not (hasKey $objectData "expandObjectName") -}}
        {{- $_ := set $objectData "expandObjectName" "false" -}}
      {{- end -}}

      {{- $expandName := (include "tc.v1.common.lib.util.expandName" (dict
                "rootCtx" $ "objectData" $objectData
                "name" $name "caller" "Velero Schedule"
                "key" "schedules")) -}}

      {{- if eq $expandName "true" -}}
        {{- $objectName = (printf "%s-%s" $fullname $name) -}}
      {{- end -}}

      {{- include "tc.v1.common.lib.util.metaListToDict" (dict "objectData" $objectData) -}}

      {{/* Perform validations */}} {{/* schedules have a max name length of 253 */}}
      {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $objectName "length" 253) -}}
      {{- include "tc.v1.common.lib.velero.schedule.validation" (dict "objectData" $objectData) -}}
      {{- include "tc.v1.common.lib.metadata.validation" (dict "objectData" $objectData "caller" "Schedule") -}}

      {{/* Set the name of the schedule */}}
      {{- $_ := set $objectData "name" $objectName -}}
      {{- $_ := set $objectData "shortName" $name -}}

      {{/* Call class to create the object */}}
      {{- include "tc.v1.common.class.velero.schedule" (dict "rootCtx" $ "objectData" $objectData) -}}

    {{- end -}}

  {{- end -}}

{{- end -}}
