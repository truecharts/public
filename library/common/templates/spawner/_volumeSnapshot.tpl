{{/* volumesnapshot Spawwner */}}
{{/* Call this template:
{{ include "tc.v1.common.spawner.volumesnapshot" $ -}}
*/}}

{{- define "tc.v1.common.spawner.volumesnapshot" -}}
  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $ -}}

  {{- range $idx, $volumesnapshot := .Values.volumeSnapshots -}}

    {{- $enabled := false -}}
    {{- if hasKey $volumesnapshot "enabled" -}}
      {{- if not (kindIs "invalid" $volumesnapshot.enabled) -}}
        {{- $enabled = $volumesnapshot.enabled -}}
      {{- else -}}
        {{- fail (printf "Volume Snapshot - Expected the defined key [enabled] in [volumeSnapshots.%v] to not be empty" $idx) -}}
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

      {{/* Create a copy of the volumesnapshot */}}
      {{- $objectData := (mustDeepCopy $volumesnapshot) -}}

      {{- if not $objectData.name -}}
        {{- fail "Volume Snapshot - Expected non empty [name]" -}}
      {{- end -}}

      {{- $objectName := (printf "%s-%s" $fullname $volumesnapshot.name) -}}
      {{- if hasKey $objectData "expandObjectName" -}}
        {{- if not $objectData.expandObjectName -}}
          {{- $objectName = $volumesnapshot.name -}}
        {{- end -}}
      {{- end -}}

      {{/* Perform validations */}} {{/* volumesnapshots have a max name length of 253 */}}
      {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $objectName "length" 253) -}}
      {{- include "tc.v1.common.lib.volumesnapshot.validation" (dict "objectData" $objectData) -}}
      {{- include "tc.v1.common.lib.metadata.validation" (dict "objectData" $objectData "caller" "VolumeSnapshot") -}}

      {{/* Set the name of the volumesnapshot */}}
      {{- $_ := set $objectData "name" $objectName -}}
      {{- $_ := set $objectData "shortName" $volumesnapshot.name -}}

      {{/* Call class to create the object */}}
      {{- include "tc.v1.common.class.volumesnapshot" (dict "rootCtx" $ "objectData" $objectData) -}}

    {{- end -}}

  {{- end -}}

{{- end -}}
