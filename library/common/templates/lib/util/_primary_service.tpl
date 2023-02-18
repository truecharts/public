{{/* Returns the primary service object */}}
{{- define "tc.v1.common.lib.util.service.primary" -}}
  {{- $services := .services -}}

  {{- $enabledServices := dict -}}
  {{- range $name, $service := $services -}}
    {{- if $service.enabled -}}
      {{- $_ := set $enabledServices $name $service -}}
    {{- end -}}
  {{- end -}}

  {{- $result := "" -}}
  {{- range $name, $service := $enabledServices -}}
    {{- if (hasKey $service "primary") -}}
      {{- if $service.primary -}}
        {{- if $result -}}
          {{- fail "More than one services are set as primary. This is not supported." -}}
        {{- end -}}
        {{- $result = $name -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- if not $result -}}
    {{- if eq (len $enabledServices) 1 -}}
      {{- $result = keys $enabledServices | mustFirst -}}
    {{- else -}}
      {{- if $enabledServices -}}
        {{- fail "At least one Service must be set as primary" -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- if $result -}}
  {{- $result -}}
  {{- else -}}
  {{- fail "No primary and enabled service found" -}}
  {{- end -}}
{{- end -}}
