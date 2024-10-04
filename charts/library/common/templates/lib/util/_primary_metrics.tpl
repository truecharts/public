{{/* Return the name of the primary metrics object */}}
{{- define "tc.v1.common.lib.util.metrics.primary" -}}
  {{- $metrics := .Values.metrics -}}

  {{- $enabledMetrics := dict -}}
  {{- range $name, $metrics := $metrics -}}
    {{- if $metrics.enabled -}}
      {{- $_ := set $enabledMetrics $name $metrics -}}
    {{- end -}}
  {{- end -}}

  {{- $result := "" -}}
  {{- range $name, $metrics := $enabledMetrics -}}
    {{- if (hasKey $metrics "primary") -}}
      {{- if $metrics.primary -}}
        {{- if $result -}}
          {{- fail "More than one metrics are set as primary. This is not supported." -}}
        {{- end -}}
        {{- $result = $name -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- if not $result -}}
    {{- if eq (len $enabledMetrics) 1 -}}
      {{- $result = keys $enabledMetrics | mustFirst -}}
    {{- end -}}
  {{- end -}}
  {{- $result -}}
{{- end -}}
