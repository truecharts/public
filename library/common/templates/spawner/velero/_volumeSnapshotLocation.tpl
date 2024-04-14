{{/* volumesnapshotlocation Spawwner */}}
{{/* Call this template:
{{ include "tc.v1.common.spawner.velero.volumesnapshotlocation" $ -}}
*/}}

{{- define "tc.v1.common.spawner.velero.volumesnapshotlocation" -}}
  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $ -}}

  {{- range $name, $volSnapLoc := .Values.volumeSnapshotLocation -}}

    {{- $enabled := (include "tc.v1.common.lib.util.enabled" (dict
                    "rootCtx" $ "objectData" $volSnapLoc
                    "name" $name "caller" "Velero Volume Snapshot Location"
                    "key" "volumeSnapshotLocation")) -}}

    {{- if eq $enabled "true" -}}

      {{/* Create a copy of the volumesnapshotlocation */}}
      {{- $objectData := (mustDeepCopy $volSnapLoc) -}}

      {{- $objectName := $name -}}

      {{- $expandName := (include "tc.v1.common.lib.util.expandName" (dict
                "rootCtx" $ "objectData" $objectData
                "name" $name "caller" "Velero Volume Snapshot Location"
                "key" "volumeSnapshotLocation")) -}}

      {{- if eq $expandName "true" -}}
        {{- $objectName = (printf "%s-%s" $fullname $name) -}}
      {{- end -}}

      {{- include "tc.v1.common.lib.util.metaListToDict" (dict "objectData" $objectData) -}}

      {{/* Perform validations */}} {{/* volumesnapshotlocations have a max name length of 253 */}}
      {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $objectName "length" 253) -}}
      {{- include "tc.v1.common.lib.metadata.validation" (dict "objectData" $objectData "caller" "Volume Snapshot Location") -}}

      {{/* Set the name of the volumesnapshotlocation */}}
      {{- $_ := set $objectData "name" $objectName -}}
      {{- $_ := set $objectData "shortName" $name -}}

      {{/* Create secret with creds for provider, if the provider is not matched, it will skip creation */}}
      {{- include "tc.v1.common.lib.velero.provider.secret" (dict "rootCtx" $ "objectData" $objectData "prefix" "vsl") -}}

      {{- include "tc.v1.common.lib.velero.volumesnapshotlocation.validation" (dict "objectData" $objectData) -}}

      {{/* Call class to create the object */}}
      {{- include "tc.v1.common.class.velero.volumesnapshotlocation" (dict "rootCtx" $ "objectData" $objectData) -}}

    {{- end -}}

  {{- end -}}

{{- end -}}
