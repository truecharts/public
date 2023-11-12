{{/* Configmap Spawwner */}}
{{/* Call this template:
{{ include "tc.v1.common.spawner.storageclass" $ -}}
*/}}

{{- define "tc.v1.common.spawner.storageclass" -}}
  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $ -}}

  {{- range $name, $storageclass := .Values.storageClass -}}

    {{- $enabled := false -}}
    {{- if hasKey $storageclass "enabled" -}}
      {{- if not (kindIs "invalid" $storageclass.enabled) -}}
        {{- $enabled = $storageclass.enabled -}}
      {{- else -}}
        {{- fail (printf "StorageClass - Expected the defined key [enabled] in [storageclass.%s] to not be empty" $name) -}}
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

      {{/* Create a copy of the storageclass */}}
      {{- $objectData := (mustDeepCopy $storageclass) -}}

      {{- $objectName := (printf "%s-%s" $fullname $name) -}}
      {{- if hasKey $objectData "expandObjectName" -}}
        {{- if not $objectData.expandObjectName -}}
          {{- $objectName = $name -}}
        {{- end -}}
      {{- end -}}

      {{/* Perform validations */}} {{/* Configmaps have a max name length of 253 */}}
      {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $objectName "length" 253) -}}
      {{- include "tc.v1.common.lib.metadata.validation" (dict "objectData" $objectData "caller" "StorageClass") -}}

      {{/* Set the name of the storageclass */}}
      {{- $_ := set $objectData "name" $objectName -}}
      {{- $_ := set $objectData "shortName" $name -}}

      {{/* Validate */}}
      {{- include "tc.v1.common.lib.storageclass.validation" (dict "rootCtx" $ "objectData" $objectData) -}}
      {{/* Call class to create the object */}}
      {{- include "tc.v1.common.class.storageclass" (dict "rootCtx" $ "objectData" $objectData) -}}

    {{- end -}}

  {{- end -}}

{{- end -}}
