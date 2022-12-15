{{- define "ix.v1.common.container.envList" -}}
  {{- $envList := .envList -}}
  {{- $envs := .envs -}}
  {{- $root := .root -}}
  {{- $fixedEnv := .fixedEnv -}}

  {{- with $envList -}}
    {{- range $envList -}}
      {{- if and .name .value -}}
        {{- if mustHas (kindOf .name) (list "map" "slice") -}}
          {{- fail "Name in envList cannot be a map or slice" -}}
        {{- end -}}
        {{- if mustHas (kindOf .value) (list "map" "slice") -}}
          {{- fail "Value in envList cannot be a map or slice" -}}
        {{- end -}}
        {{- include "ix.v1.common.container.envFixed.checkDuplicate" (dict "checkEnvs" $fixedEnv "key" .name "holderKey" "envList") -}}
        {{- include "ix.v1.common.container.env.checkDuplicate" (dict "checkEnvs" $envs "key" .name) }}
- name: {{ tpl .name $root }}
  value: {{ tpl .value $root | quote }}
      {{- else -}}
        {{- fail "Please specify both name and value for environment variable" -}}
      {{- end -}}
    {{- end -}}
  {{- end -}} {{/* Finish envList */}}
{{- end -}}
