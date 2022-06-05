{{/*
Return the primary rbac object
*/}}
{{- define "tc.common.lib.util.rbac.primary" -}}
  {{- $enabledrbacs := dict -}}
  {{- range $name, $rbac := .Values.rbac -}}
    {{- if $rbac.enabled -}}
      {{- $_ := set $enabledrbacs $name . -}}
    {{- end -}}
  {{- end -}}

  {{- $result := "" -}}
  {{- range $name, $rbac := $enabledrbacs -}}
    {{- if and (hasKey $rbac "primary") $rbac.primary -}}
      {{- $result = $name -}}
    {{- end -}}
  {{- end -}}

  {{- if not $result -}}
    {{- $result = keys $enabledrbacs | first -}}
  {{- end -}}
  {{- $result -}}
{{- end -}}
