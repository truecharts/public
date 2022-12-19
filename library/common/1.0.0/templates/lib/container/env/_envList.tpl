{{- define "ix.v1.common.container.envList" -}}
  {{- $envList := .envList -}}
  {{- $envs := .envs -}}
  {{- $root := .root -}}
  {{- $fixedEnv := .fixedEnv -}}

  {{- $dupeCheck := dict -}}
  {{- with $envList -}}
    {{- range $envList -}}
      {{- if and .name .value -}}
        {{- if mustHas (kindOf .name) (list "map" "slice") -}}
          {{- fail "Name in envList cannot be a map or slice" -}}
        {{- end -}}
        {{- if mustHas (kindOf .value) (list "map" "slice") -}}
          {{- fail "Value in envList cannot be a map or slice" -}}
        {{- end -}}
        {{- $name := tpl .name $root -}}
        {{- $value := tpl .value $root }}
- name: {{ $name }}
  value: {{ $value | quote }}
        {{- $_ := set $dupeCheck $name $value -}}
      {{- else -}}
        {{- fail "Please specify both name and value for environment variable" -}}
      {{- end -}}
    {{- end -}}
    {{- include "ix.v1.common.util.storeEnvsForCheck" (dict "root" $root "source" "envList" "data" $dupeCheck) -}}
  {{- end -}} {{/* Finish envList */}}
{{- end -}}
