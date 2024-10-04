{{/* Contains functions for generating names */}}

{{/* Returns the name of the Chart */}}
{{- define "tc.v1.common.lib.chart.names.name" -}}

  {{- .Chart.Name | lower | trunc 63 | trimSuffix "-" -}}

{{- end -}}

{{/* Returns the fullname of the Chart */}}
{{- define "tc.v1.common.lib.chart.names.fullname" -}}

  {{- $name := include "tc.v1.common.lib.chart.names.name" . -}}

  {{- if contains $name .Release.Name -}}
    {{- $name = .Release.Name -}}
  {{- else -}}
    {{- $name = printf "%s-%s" .Release.Name $name -}}
  {{- end -}}

  {{- $name | lower | trunc 63 | trimSuffix "-" -}}

{{- end -}}

{{/* Returns the fqdn of the Chart */}}
{{- define "tc.v1.common.lib.chart.names.fqdn" -}}

  {{- printf "%s.%s" (include "tc.v1.common.lib.chart.names.fullname" .) .Release.Namespace | replace "+" "_" | trunc 63 | trimSuffix "-" -}}

{{- end -}}

{{/* Validates names */}}
{{- define "tc.v1.common.lib.chart.names.validation" -}}

  {{- $name := .name -}}
  {{- $length := .length -}}
  {{- if not $length -}}
    {{- $length = 63 -}}
  {{- end -}}

  {{- if not (and (mustRegexMatch "^[a-z0-9]((-?[a-z0-9]-?)*[a-z0-9])?$" $name) (le (len $name) $length)) -}}
    {{- fail (printf "Name [%s] is not valid. Must start and end with an alphanumeric lowercase character. It can contain '-'. And must be at most %v characters." $name $length) -}}
  {{- end -}}

{{- end -}}

{{/* Create chart name and version as used by the chart label */}}
{{- define "tc.v1.common.lib.chart.names.chart" -}}

  {{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}

{{- end -}}
