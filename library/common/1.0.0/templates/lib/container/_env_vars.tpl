{{/*
A custom dict is expected with envs and root.
It's designed to work for mainContainer AND initContainers.
Calling this from an initContainer, wouldn't work, as it would have a different "root" context,
and "tpl" on "$" would cause erors.
That's why the custom dict is expected.
*/}}
{{/* Environment Variables included by the container */}}
{{- define "ix.v1.common.container.envVars" -}}
  {{- $envs := .envs -}}
  {{- $envList := .envList -}}
  {{- $containerName := .containerName -}}
  {{- $isMainContainer := .isMainContainer -}}
  {{- $injectFixedEnvs := .injectFixedEnvs -}}
  {{- $secCont := .secCont -}}
  {{- $root := .root -}}
  {{- $fixedEnv := list -}}

  {{- $inject := $root.Values.global.defaults.injectFixedEnvs -}}
  {{- if (mustHas (toString $injectFixedEnvs) (list "true" "false")) -}}
    {{- $inject = $injectFixedEnvs -}}
  {{- end -}}

  {{- if $inject -}}
    {{- $fixedEnv = (include "ix.v1.common.container.fixedEnvs" (dict "root" $root "fixedEnv" $fixedEnv "containerName" $containerName "isMainContainer" $isMainContainer "secCont" $secCont "security" .security)) -}}
  {{- end -}} {{/* Finish fixedEnv */}}
  {{- with $fixedEnv -}}
    {{- range $fixedEnv | fromJsonArray }} {{/* "fromJsonArray" parses stringified output and convet to list */}}
- name: {{ .name | quote }}
  value: {{ .value | quote }}
    {{- end -}}
  {{- end -}}
  {{- include "ix.v1.common.container.env" (dict "envs" $envs "root" $root "fixedEnv" $fixedEnv "containerName" $containerName) -}}
  {{- include "ix.v1.common.container.envList" (dict "envList" $envList "envs" $envs "root" $root "fixedEnv" $fixedEnv "containerName" $containerName) -}}
{{- end -}}
