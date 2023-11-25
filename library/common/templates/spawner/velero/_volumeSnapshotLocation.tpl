{{/* volumesnapshotlocation Spawwner */}}
{{/* Call this template:
{{ include "tc.v1.common.spawner.velero.volumesnapshotlocation" $ -}}
*/}}

{{- define "tc.v1.common.spawner.velero.volumesnapshotlocation" -}}
  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $ -}}

  {{- range $volSnapLoc := .Values.volumeSnapshotLocation -}}

    {{- $enabled := false -}}
    {{- if hasKey $volSnapLoc "enabled" -}}
      {{- if not (kindIs "invalid" $volSnapLoc.enabled) -}}
        {{- $enabled = $volSnapLoc.enabled -}}
      {{- else -}}
        {{- fail (printf "Volume Snapshot Location - Expected the defined key [enabled] in [volumeSnapshotLocation.%s] to not be empty" $volSnapLoc.name) -}}
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

      {{/* Create a copy of the volumesnapshotlocation */}}
      {{- $objectData := (mustDeepCopy $volSnapLoc) -}}

      {{- if not $volSnapLoc.name -}}
        {{- fail "Volume Snapshot Location - Expected non-empty [name]" -}}
      {{- end -}}

      {{- $objectName := (printf "%s-%s" $fullname $volSnapLoc.name) -}}
      {{- if hasKey $objectData "expandObjectName" -}}
        {{- if not $objectData.expandObjectName -}}
          {{- $objectName = $volSnapLoc.name -}}
        {{- end -}}
      {{- end -}}

      {{/* Set namespace to velero location or itself, just in case its used from within velero */}}
      {{- $operator := index $.Values.operator "velero" -}}
      {{- $namespace := $operator.namespace | default (include "tc.v1.common.lib.metadata.namespace" (dict "rootCtx" $ "objectData" $objectData "caller" "Volume Snapshot Location")) -}}
      {{- $_ := set $objectData "namespace" $namespace -}}

      {{/* Perform validations */}} {{/* volumesnapshotlocations have a max name length of 253 */}}
      {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $objectName "length" 253) -}}
      {{- include "tc.v1.common.lib.metadata.validation" (dict "objectData" $objectData "caller" "Volume Snapshot Location") -}}

      {{/* Set the name of the volumesnapshotlocation */}}
      {{- $_ := set $objectData "name" $objectName -}}
      {{- $_ := set $objectData "shortName" $volSnapLoc.name -}}

      {{/* Create secret with creds for provider, if the provider is not matched, it will skip creation */}}
      {{- include "tc.v1.common.lib.velero.provider.secret" (dict "rootCtx" $ "objectData" $objectData "prefix" "vsl") -}}

      {{- include "tc.v1.common.lib.velero.volumesnapshotlocation.validation" (dict "objectData" $objectData) -}}

      {{/* Call class to create the object */}}
      {{- include "tc.v1.common.class.velero.volumesnapshotlocation" (dict "rootCtx" $ "objectData" $objectData) -}}

    {{- end -}}

  {{- end -}}

{{- end -}}
