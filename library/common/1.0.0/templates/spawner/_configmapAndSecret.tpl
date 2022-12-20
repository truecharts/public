{{- define "ix.v1.common.spawner.configmapAndSecret" -}}
  {{- $root := . -}}

  {{- range $name, $objectData := .Values.configmap -}}
    {{- include "ix.v1.common.configmapAndSecret.process" (dict "root" $root "name" $name "objectData" $objectData "objectType" "configmap") -}}
  {{- end -}}
  {{- range $name, $objectData := .Values.secret -}}
    {{- include "ix.v1.common.configmapAndSecret.process" (dict "root" $root "name" $name "objectData" $objectData "objectType" "secret") -}}
  {{- end -}}
{{- end -}}

{{- define "ix.v1.common.configmapAndSecret.process" -}}
  {{- $root := .root -}}
  {{- $name := .name -}}
  {{- $objectData := .objectData -}}
  {{- $objectType := .objectType -}}

  {{- if ne $name ($name | lower) -}}
    {{- fail (printf "%s has invalid name (%s). Name must be lowercase." (camelcase $objectType) $name) -}}
  {{- end -}}
  {{- if contains "_" $name -}}
    {{- fail (printf "%s has invalid name (%s). Name cannot contain underscores (_)." (camelcase $objectType) $name) -}}
  {{- end -}}

  {{/* Generate the name */}}
  {{- $objectName := include "ix.v1.common.names.fullname" $root -}}
  {{- if and (hasKey $objectData "nameOverride") $objectData.nameOverride -}}
    {{- $objectName = printf "%v-%v" $objectName $objectData.nameOverride -}}
  {{- else -}}
    {{- $objectName = printf "%v-%v" $objectName $name -}}
  {{- end -}}

  {{- if $objectData.enabled -}} {{/* If it's enabled... */}}

    {{/* Do some checks */}}
    {{- if not $objectData.content -}}
      {{- fail (printf "Content of %s (%s) are empty. Please disable or add content." (camelcase $objectType) $name) -}}
    {{- end -}}

    {{- if eq (kindOf $objectData.content) "string" -}}
      {{- fail (printf "Content of %s (%s) are string. Must be in key/value format. Value can be scalar too." (camelcase $objectType) $name) -}}
    {{- end -}}

    {{- $classData := dict -}} {{/* Store expanded data that will be passed to the class */}}
    {{- $contentType := "" -}} {{/* Type of the content "key_value" or "scalar" */}}

    {{- $parseAsEnv := false -}}
    {{- if hasKey $objectData "parseAsEnv" -}}
      {{- $parseAsEnv = $objectData.parseAsEnv -}}
    {{- end -}}

    {{- if $parseAsEnv -}} {{/* If it's destined for use on envFrom, also check them for dupes */}}
      {{- $dupeCheck := dict -}}

      {{- range $k, $v := $objectData.content -}}
        {{- $value := tpl $v $root -}} {{/* Exapand templates before sending them to the configmap */}}
        {{- $_ := set $classData $k $value -}}
        {{- $_ := set $dupeCheck $k $value -}}
      {{- end -}}

      {{- $contentType = "key_value" -}}
      {{- include "ix.v1.common.util.storeEnvsForDupeCheck" (dict "root" $root "source" (printf "%s-%s" (camelcase $objectType) $objectName) "data" $dupeCheck) -}}

    {{- else -}} {{/* If it's "normal" key/value or scalar secret/configmap... */}}
      {{- range $key, $value := $objectData.content -}}
        {{- if not $value -}}
          {{- fail (printf "%s (%s) has key (%s), without content." (camelcase $objectType) $name $key) -}}
        {{- end -}}
      {{- end -}}
      {{- $contentType = "scalar" -}} {{/* Handle both key/value and scalar the same way */}}
      {{- $classData = (tpl (toYaml $objectData.content) $root) -}} {{/* toYaml works on both scalar and key/value */}}
    {{- end -}}

    {{/* Create ConfigMap or Secret */}}
    {{- if eq $objectType "configmap" -}}
      {{- include "ix.v1.common.class.configmap" (dict "root" $root "configName" $objectName "contentType" $contentType "data" $classData "labels" $objectData.labels "annotations" $objectData.annotations) -}}
    {{- else if eq $objectType "secret" -}}
      {{- include "ix.v1.common.class.secret" (dict "root" $root "secretName" $objectName "secretType" $objectData.secretType "contentType" $contentType "data" $classData "labels" $objectData.labels "annotations" $objectData.annotations) -}}
    {{- end -}}

  {{- end -}}
{{- end -}}


{{/* TODO: Unit tests */}}
