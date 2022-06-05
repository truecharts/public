{{/*
Return the primary service object
*/}}
{{- define "tc.common.lib.util.service.primary" -}}
  {{- $enabledServices := dict -}}
  {{- range $name, $service := .Values.service -}}
    {{- if $service.enabled -}}
      {{- $_ := set $enabledServices $name . -}}
    {{- end -}}
  {{- end -}}

  {{- $result := "" -}}
  {{- range $name, $service := $enabledServices -}}
    {{- if and (hasKey $service "primary") $service.primary -}}
      {{- $result = $name -}}
    {{- end -}}
  {{- end -}}

  {{- if not $result -}}
    {{- $result = keys $enabledServices | first -}}
  {{- end -}}
  {{- $result -}}
{{- end -}}
