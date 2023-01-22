{{/* Return the name of the primary metrics object */}}
{{- define "tc.v1.common.lib.util.metrics.primary" -}}
  {{- $enabledIngresses := dict -}}
  {{- range $name, $metrics := .Values.metrics -}}
    {{- if $metrics.enabled -}}
      {{- $_ := set $enabledIngresses $name . -}}
    {{- end -}}
  {{- end -}}

  {{- $result := "" -}}
  {{- range $name, $metrics := $enabledIngresses -}}
    {{- if and (hasKey $metrics "primary") $metrics.primary -}}
      {{- $result = $name -}}
    {{- end -}}
  {{- end -}}

  {{- if not $result -}}
    {{- $result = keys $enabledIngresses | first -}}
  {{- end -}}
  {{- $result -}}
{{- end -}}
