{{/* volumesnapshotclass Spawwner */}}
{{/* Call this template:
{{ include "tc.v1.common.spawner.volumesnapshotclass" $ -}}
*/}}

{{- define "tc.v1.common.spawner.volumesnapshotclass" -}}
  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $ -}}

  {{- range $name, $volumesnapshotclass := .Values.volumeSnapshotClass -}}

    {{- $enabled := false -}}
    {{- if hasKey $volumesnapshotclass "enabled" -}}
      {{- if not (kindIs "invalid" $volumesnapshotclass.enabled) -}}
        {{- $enabled = $volumesnapshotclass.enabled -}}
      {{- else -}}
        {{- fail (printf "Volume Snapshot Class - Expected the defined key [enabled] in [volumeSnapshotClass.%s] to not be empty" $name) -}}
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

      {{/* Create a copy of the volumesnapshotclass */}}
      {{- $objectData := (mustDeepCopy $volumesnapshotclass) -}}

      {{- $objectName := (printf "%s-%s" $fullname $name) -}}
      {{- if hasKey $objectData "expandObjectName" -}}
        {{- if not $objectData.expandObjectName -}}
          {{- $objectName = $name -}}
        {{- end -}}
      {{- end -}}

      {{/* Perform validations */}} {{/* volumesnapshotclasss have a max name length of 253 */}}
      {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $objectName "length" 253) -}}
      {{- include "tc.v1.common.lib.volumesnapshotclass.validation" (dict "objectData" $objectData) -}}
      {{- include "tc.v1.common.lib.metadata.validation" (dict "objectData" $objectData "caller" "Volume Snapshot Class") -}}

      {{/* Set the name of the volumesnapshotclass */}}
      {{- $_ := set $objectData "name" $objectName -}}
      {{- $_ := set $objectData "shortName" $name -}}

      {{/* Call class to create the object */}}
      {{- include "tc.v1.common.class.volumesnapshotclass" (dict "rootCtx" $ "objectData" $objectData) -}}

    {{- end -}}

  {{- end -}}

{{- end -}}
