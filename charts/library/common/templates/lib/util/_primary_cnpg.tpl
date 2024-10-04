{{/* Return the name of the primary cnpg object */}}
{{- define "tc.v1.common.lib.util.cnpg.primary" -}}
  {{- $cnpgs := .Values.cnpg -}}

  {{- $enabledcnpges := dict -}}
  {{- range $name, $cnpg := $cnpgs -}}
    {{- if $cnpg.enabled -}}
      {{- $_ := set $enabledcnpges $name . -}}
    {{- end -}}
  {{- end -}}

  {{- $result := "" -}}
  {{- range $name, $cnpg := $enabledcnpges -}}
    {{- if and (hasKey $cnpg "primary") $cnpg.primary -}}
      {{- $result = $name -}}
    {{- end -}}
  {{- end -}}

  {{- if not $result -}}
    {{- $result = keys $enabledcnpges | first -}}
  {{- end -}}
  {{- $result -}}
{{- end -}}
