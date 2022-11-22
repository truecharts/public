{{/* Returns the primary rbac object */}}
{{- define "ix.v1.common.lib.util.rbac.primary" -}}
  {{- $enabledrbacs := dict -}}
  {{- range $name, $rbac := .Values.rbac -}}
    {{- if $rbac.enabled -}}
      {{- $_ := set $enabledrbacs $name . -}}
    {{- end -}}
  {{- end -}}

  {{- $result := "" -}}
  {{- range $name, $rbac := $enabledrbacs -}}
    {{- if (hasKey $rbac "primary") -}}
      {{- if $rbac.primary -}}
        {{- if $result -}}
          {{- fail "More than one RBACS are set as primary. This is not supported." -}}
        {{- end -}}
        {{- $result = $name -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- if not $result -}}
    {{- $result = keys $enabledrbacs | first -}}
  {{- end -}}

  {{- $result -}}
{{- end -}}
