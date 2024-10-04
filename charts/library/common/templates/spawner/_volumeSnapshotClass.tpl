{{/* volumesnapshotclass Spawwner */}}
{{/* Call this template:
{{ include "tc.v1.common.spawner.volumesnapshotclass" $ -}}
*/}}

{{- define "tc.v1.common.spawner.volumesnapshotclass" -}}
  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $ -}}

  {{- range $name, $volumesnapshotclass := .Values.volumeSnapshotClass -}}

    {{- $enabled := (include "tc.v1.common.lib.util.enabled" (dict
                    "rootCtx" $ "objectData" $volumesnapshotclass
                    "name" $name "caller" "Volume Snapshot Class"
                    "key" "volumeSnapshotClass")) -}}

    {{- if eq $enabled "true" -}}

      {{/* Create a copy of the volumesnapshotclass */}}
      {{- $objectData := (mustDeepCopy $volumesnapshotclass) -}}

      {{- $objectName := $name -}}

      {{- $expandName := (include "tc.v1.common.lib.util.expandName" (dict
                "rootCtx" $ "objectData" $objectData
                "name" $name "caller" "Volume Snapshot Class"
                "key" "volumeSnapshotClass")) -}}

      {{- if eq $expandName "true" -}}
        {{- $objectName = (printf "%s-%s" $fullname $name) -}}
      {{- end -}}

      {{- include "tc.v1.common.lib.util.metaListToDict" (dict "objectData" $objectData) -}}

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
