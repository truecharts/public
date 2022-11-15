{{/* Environment Variables List included by the container */}}
{{- define "ix.v1.common.container.envFrom" -}}
{{- $envFrom := .envFrom -}}
{{- $root := .root -}}
{{- if or $root.secretEnv $envFrom -}}
  envFrom:
  {{- if $root.secretEnv }} {{/* TODO: Write unittest once _secret.tpl is completed */}}
  - secretRef:
      name: {{ include "ix.v1.common.names.fullname" . }}
  {{- end -}}
  {{- range $envFrom -}}
    {{- if .secretRef }}
  - secretRef:
      name: {{ tpl (required "Name is required for secretRef in envFrom." .secretRef.name) $root | quote }}
    {{- else if .configMapRef }}
  - configMapRef:
      name: {{ tpl (required "Name is required for configMapRef in envFrom." .configMapRef.name) $root | quote }}
    {{- else -}}
      {{- fail "Not valid Ref or <name> key is missing in envFrom." -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
{{- end -}}

{{/*
A custom dict is expected with envList and root.
It's designed to work for mainContainer AND initContainers.
Calling this from an initContainer, wouldn't work, as it would have a different "root" context,
and "tpl" on "$" would cause erors.
That's why the custom dict is expected.
*/}}
