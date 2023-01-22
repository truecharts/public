{{/* Renders the Ingress objects required by the chart */}}
{{- define "tc.v1.common.spawner.metrics" -}}
  {{/* Generate named metricses as required */}}
  {{- range $name, $metrics := .Values.metrics -}}
    {{- if $metrics.enabled -}}
      {{- $metricsValues := $metrics -}}

      {{/* set defaults */}}
      {{- if and (not $metricsValues.nameOverride) (ne $name (include "tc.v1.common.lib.util.metrics.primary" $)) -}}
        {{- $_ := set $metricsValues "nameOverride" $name -}}
      {{- end -}}

      {{- $_ := set $ "ObjectValues" (dict "metrics" $metricsValues) -}}
      {{- if eq $metricsValues.type "podmonitor" -}}
        {{- include "tc.v1.common.class.podmonitor" $ -}}
      {{- else if eq $metricsValues.type "servicemonitor" -}}
        {{- include "tc.v1.common.class.servicemonitor" $ -}}
      {{- else -}}
        {{/* TODO: Add Fail case */}}
      {{- end -}}

      {{- if $metricsValues.PrometheusRule -}}
        {{- include "tc.v1.common.class.prometheusrule" $ -}}
      {{- end -}}

    {{- end -}}
  {{- end -}}
{{- end -}}
