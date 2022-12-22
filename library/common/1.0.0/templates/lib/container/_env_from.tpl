{{/*
A custom dict is expected with envList and root.
It's designed to work for mainContainer AND initContainers.
Calling this from an initContainer, wouldn't work, as it would have a different "root" context,
and "tpl" on "$" would cause erors.
That's why the custom dict is expected.
*/}}

{{/* Environment Variables From included by the container */}}
{{- define "ix.v1.common.container.envFrom" -}}
  {{- $envFrom := .envFrom -}}
  {{- $container := .container -}}
  {{- $root := .root -}}

  {{- range $envFrom -}}
    {{- if and .secretRef .configMapRef -}}
      {{- fail "You can't define both secretRef and configMapRef on the same item." -}}
    {{- end -}}
    {{- if .secretRef }}
      {{- $secretName := (tpl (required "Name is required for secretRef in envFrom." .secretRef.name) $root) }}
- secretRef:
    name: {{ $secretName | quote }}
    {{- include "ix.v1.common.util.storeEnvFromVarsForCheck" (dict "root" $root "container" $container "name" $secretName "type" "secret") -}}
    {{- else if .configMapRef }}
      {{- $configName := (tpl (required "Name is required for configMapRef in envFrom." .configMapRef.name) $root) }}
- configMapRef:
    name: {{ $configName | quote }}
    {{- include "ix.v1.common.util.storeEnvFromVarsForCheck" (dict "root" $root "container" $container "name" $configName "type" "configmap") -}}
    {{- else -}}
      {{- fail "Not valid Ref or <name> key is missing in envFrom." -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
