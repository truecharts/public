{{/* Return the name of the primary route object */}}
{{- define "tc.v1.common.lib.util.route.primary" -}}
  {{- $routees := $.Values.route -}}

  {{- $enabledroutees := dict -}}
  {{- range $name, $route := $routees -}}
    {{- if $route.enabled -}}
      {{- $_ := set $enabledroutees $name . -}}
    {{- end -}}
  {{- end -}}

  {{- $result := "" -}}
  {{- range $name, $route := $enabledroutees -}}
    {{- if and (hasKey $route "primary") $route.primary -}}
      {{- $result = $name -}}
    {{- end -}}
  {{- end -}}

  {{- if not $result -}}
    {{- $result = keys $enabledroutees | first -}}
  {{- end -}}
  {{- $result -}}
{{- end -}}
