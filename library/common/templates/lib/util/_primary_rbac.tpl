{{/* Returns the primary rbac object */}}
{{- define "ix.v1.common.lib.util.rbac.primary" -}}
  {{- $enabledrbacs := dict -}}
  {{- range $name, $rbac := .Values.rbac -}}
    {{- if $rbac.enabled -}}
      {{- $_ := set $enabledrbacs $name $rbac -}}
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
    {{- if eq (len $enabledrbacs) 1 -}}
      {{- $result = keys $enabledrbacs | mustFirst -}}
    {{- else -}}
      {{- if $enabledrbacs -}}
        {{- fail "At least one RBAC must be set as primary" -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- $result -}}
{{- end -}}
