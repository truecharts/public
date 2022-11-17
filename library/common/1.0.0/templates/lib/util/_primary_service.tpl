{{/* Returns the primary service object */}}
{{- define "ix.v1.common.lib.util.service.primary" -}}
  {{- $enabledServices := dict -}}
  {{- range $name, $service := .Values.service -}}
    {{- if $service.enabled -}}
      {{- $_ := set $enabledServices $name . -}}
    {{- end -}}
  {{- end -}}

  {{- $result := "" -}}
  {{- range $name, $service := $enabledServices -}}
    {{- if $result -}}
      {{- fail "More than one services are set as primary. This is not supported." -}}
    {{- end -}}
    {{- if (hasKey $service "primary") -}}
      {{- if $service.primary -}}
        {{- $result = $name -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- if not $result -}}
    {{- $result = keys $enabledServices | first -}}
  {{- end -}}

  {{- $result -}}
{{- end -}}
