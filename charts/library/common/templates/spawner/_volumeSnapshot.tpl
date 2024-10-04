{{/* volumesnapshot Spawwner */}}
{{/* Call this template:
{{ include "tc.v1.common.spawner.volumesnapshot" $ -}}
*/}}

{{- define "tc.v1.common.spawner.volumesnapshot" -}}
  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $ -}}

  {{- range $name, $volumesnapshot := .Values.volumeSnapshots -}}

    {{- $enabled := (include "tc.v1.common.lib.util.enabled" (dict
                    "rootCtx" $ "objectData" $volumesnapshot
                    "name" $name "caller" "Volume Snapshot"
                    "key" "volumeSnapshots")) -}}

    {{- if eq $enabled "true" -}}

      {{/* Create a copy of the volumesnapshot */}}
      {{- $objectData := (mustDeepCopy $volumesnapshot) -}}

      {{- $objectName := $name -}}

      {{- $expandName := (include "tc.v1.common.lib.util.expandName" (dict
                "rootCtx" $ "objectData" $objectData
                "name" $name "caller" "Volume Snapshot"
                "key" "volumeSnapshots")) -}}

      {{- if eq $expandName "true" -}}
        {{- $objectName = (printf "%s-%s" $fullname $name) -}}
      {{- end -}}

      {{- include "tc.v1.common.lib.util.metaListToDict" (dict "objectData" $objectData) -}}

      {{/* Perform validations */}} {{/* volumesnapshots have a max name length of 253 */}}
      {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $objectName "length" 253) -}}
      {{- include "tc.v1.common.lib.volumesnapshot.validation" (dict "objectData" $objectData) -}}
      {{- include "tc.v1.common.lib.metadata.validation" (dict "objectData" $objectData "caller" "VolumeSnapshot") -}}

      {{/* Set the name of the volumesnapshot */}}
      {{- $_ := set $objectData "name" $objectName -}}
      {{- $_ := set $objectData "shortName" $name -}}

      {{/* Call class to create the object */}}
      {{- include "tc.v1.common.class.volumesnapshot" (dict "rootCtx" $ "objectData" $objectData) -}}

    {{- end -}}

  {{- end -}}

{{- end -}}
