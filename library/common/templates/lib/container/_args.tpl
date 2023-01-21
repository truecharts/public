{{/*
A custom dict is expected with args, extraArgs and root.
It's designed to work for mainContainer AND initContainers.
Calling this from an initContainer, wouldn't work, as it would have a different "root" context,
and "tpl" on "$" would cause erors.
That's why the custom dict is expected.
*/}}
{{/* Args included by the container */}}
{{- define "ix.v1.common.container.args" -}}
{{- $args := .args -}}
{{- $extraArgs := .extraArgs -}}
{{- $root := .root -}}
{{- with $args -}} {{/* args usually defined while developing the chart */}}
  {{- if kindIs "string" . -}}
- {{ tpl . $root }}
  {{- else }}
    {{- tpl (toYaml .) $root }}
  {{- end }}
{{- end }}
{{- with $extraArgs }} {{/* extraArgs used in cases that users wants to APPEND to args */}}
  {{- if kindIs "string" . }}
- {{ tpl . $root }}
  {{- else }}
    {{- tpl (toYaml .) $root | nindent 0 }} {{/* This nindent is here beacause... Well I've no idea why, but it works only with this here. Sorry */}}
  {{- end }}
{{- end }}
{{- end -}}
