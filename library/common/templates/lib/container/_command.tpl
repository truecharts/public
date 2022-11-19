{{/*
A custom dict is expected with commands and root.
It's designed to work for mainContainer AND initContainers.
Calling this from an initContainer, wouldn't work, as it would have a different "root" context,
and "tpl" on "$" would cause erors.
That's why the custom dict is expected.
*/}}
{{/* Command included by the container */}}
{{- define "ix.v1.common.container.command" -}}
{{- $commands := .commands -}}
{{- $root := .root -}}
{{- if $commands }}
{{- if kindIs "string" $commands -}}
- {{ tpl $commands $root }}
{{- else }}
  {{- tpl (toYaml $commands) $root }}
{{- end }}
{{- end }}
{{- end -}}
