{{- define "ix.v1.common.spawner.configmap" -}}
  {{- $root := . -}}

  {{- range $name, $config := .Values.configmap -}}
    {{- $configMapName := include "ix.v1.common.names.fullname" $root -}}
    {{- $data := dict -}}

    {{- if $config.enabled -}}
      {{- if not $config.content -}}
        {{- fail (printf "Configmap (%s) has empty <content>. Please disable or add contents." $name) -}}
      {{- end -}}

      {{- if eq (kindOf $config.content) "string" -}}
        {{- fail (printf "Configmap (%s) contents are string. Must be in key/value format. Value can be scalar too." $name) -}}
      {{- end -}}

      {{- if and (hasKey $config "nameOverride") $config.nameOverride -}}
        {{- $configMapName = printf "%v-%v" $configMapName $config.nameOverride -}}
      {{- else -}}
        {{- $configMapName = printf "%v-%v" $configMapName $name -}}
      {{- end -}}

      {{- $parseAsEnv := false -}}
      {{- if hasKey $config "parseAsEnv" -}}
        {{- $parseAsEnv = $config.parseAsEnv -}}
      {{- end -}}

      {{- if $parseAsEnv -}}
        {{- $dupeCheck := dict -}}
        {{- range $k, $v := $config.content -}}
          {{- $value := tpl $v $root -}} {{/* Exapand templates before sending them to the configmap */}}
          {{- $_ := set $data $k $value -}}
          {{- $_ := set $dupeCheck $k $value -}}
        {{- end -}}

        {{- include "ix.v1.common.util.storeEnvsForCheck" (dict "root" $root "source" (printf "configmap-%s" $name) "data" $dupeCheck) -}}

        {{/* Create ConfigMap */}}
        {{- include "ix.v1.common.class.configmap" (dict "root" $root "configName" $configMapName "type" "key_value" "data" $data "labels" $config.labels "annotations" $config.annotations) -}}
      {{- else -}}
        {{- range $key, $value := $config.content -}}
          {{- if not $value -}}
            {{- fail (printf "Configmap (%s) has key (%s), without content." $name $key) -}}
          {{- end -}}
        {{- end -}}

        {{- include "ix.v1.common.class.configmap" (dict "root" $root "configName" $configMapName "type" "scalar" "data" (tpl (toYaml $config.content) $root) "labels" $config.labels "annotations" $config.annotations) -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
