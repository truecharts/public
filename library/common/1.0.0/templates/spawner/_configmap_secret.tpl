{{- define "ix.v1.common.spawner.configmap" -}}
  {{- $root := . -}}

  {{- range $name, $objectData := .Values.configmap -}}
    {{- include "ix.v1.common.configmapAndSecret.process" (dict "root" $root "name" $name "objectData" $objectData "type" "configmap") -}}
  {{- end -}}
  {{- range $name, $objectData := .Values.secret -}}
    {{- include "ix.v1.common.configmapAndSecret.process" (dict "root" $root "name" $name "objectData" $objectData "type" "secret") -}}
  {{- end -}}
{{- end -}}

{{- define "ix.v1.common.configmapAndSecret.process" -}}
  {{- $root := .root -}}
  {{- $name := .name -}}
  {{- $objectData := .objectData -}}
  {{- $type := .type -}}

  {{- $ObjectName := include "ix.v1.common.names.fullname" $root -}}
  {{- $classData := dict -}}

  {{- if $objectData.enabled -}}
    {{- if not $objectData.content -}}
      {{- fail (printf "Contents %s (%s) are empty. Please disable or add contents." (camelcase $type) $name) -}}
    {{- end -}}

    {{- if eq (kindOf $objectData.content) "string" -}}
      {{- fail (printf "Contets of %s (%s) are string. Must be in key/value format. Value can be scalar too." (camelcase $type) $name) -}}
    {{- end -}}

    {{- if and (hasKey $objectData "nameOverride") $objectData.nameOverride -}}
      {{- $ObjectName = printf "%v-%v" $ObjectName $objectData.nameOverride -}}
    {{- else -}}
      {{- $ObjectName = printf "%v-%v" $ObjectName $name -}}
    {{- end -}}

    {{- $parseAsEnv := false -}}
    {{- if hasKey $objectData "parseAsEnv" -}}
      {{- $parseAsEnv = $objectData.parseAsEnv -}}
    {{- end -}}

    {{- if $parseAsEnv -}}
      {{- $dupeCheck := dict -}}
      {{- range $k, $v := $objectData.content -}}
        {{- $value := tpl $v $root -}} {{/* Exapand templates before sending them to the configmap */}}
        {{- $_ := set $classData $k $value -}}
        {{- $_ := set $dupeCheck $k $value -}}
      {{- end -}}

      {{- include "ix.v1.common.util.storeEnvsForCheck" (dict "root" $root "source" (printf "%s-%s" $type $name) "data" $dupeCheck) -}}

      {{/* Create ConfigMap or Secret */}}
      {{- if eq $type "configmap" -}}
        {{- include "ix.v1.common.class.configmap" (dict "root" $root "configName" $ObjectName "type" "key_value" "data" $classData "labels" $objectData.labels "annotations" $objectData.annotations) -}}
      {{- else if eq $type "secret" -}}
        {{- include "ix.v1.common.class.secret" (dict "root" $root "secretName" $ObjectName "type" "key_value" "data" $classData "labels" $objectData.labels "annotations" $objectData.annotations) -}}
      {{- end -}}
    {{- else -}}
      {{- range $key, $value := $objectData.content -}}
        {{- if not $value -}}
          {{- fail (printf "%s (%s) has key (%s), without content." (camelcase $type) $name $key) -}}
        {{- end -}}
      {{- end -}}

      {{/* Create ConfigMap or Secret */}}
      {{- if eq $type "configmap" -}}
        {{- include "ix.v1.common.class.configmap" (dict "root" $root "configName" $ObjectName "type" "scalar" "data" (tpl (toYaml $objectData.content) $root) "labels" $objectData.labels "annotations" $objectData.annotations) -}}
      {{- else if eq $type "secret" -}}
        {{- include "ix.v1.common.class.secret" (dict "root" $root "secretName" $ObjectName "type" "scalar" "data" (tpl (toYaml $objectData.content) $root) "labels" $objectData.labels "annotations" $objectData.annotations) -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
{{/* TODO: Unit tests */}}
