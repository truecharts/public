{{- define "tc.v1.common.lib.metadata.namespace" -}}
  {{- $caller := .caller -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $namespace := $rootCtx.Release.Namespace -}}

  {{- with $rootCtx.Values.global.namespace -}}
    {{- $namespace = tpl . $rootCtx -}}
  {{- end -}}

  {{- with $rootCtx.Values.namespace -}}
    {{- $namespace = tpl . $rootCtx -}}
  {{- end -}}

  {{- with $objectData.namespace -}}
    {{- $namespace = tpl . $rootCtx -}}
  {{- end -}}

  {{- if not (and (mustRegexMatch "^[a-z0-9]((-?[a-z0-9]-?)*[a-z0-9])?$" $namespace) (le (len $namespace) 63)) -}}
    {{- fail (printf "%s - Namespace [%s] is not valid. Must start and end with an alphanumeric lowercase character. It can contain '-'. And must be at most 63 characters." $caller $namespace) -}}
  {{- end -}}

  {{- if $rootCtx.Values.global.ixChartContext -}}
    {{- if not (hasPrefix "ix-" $namespace) -}}
      {{/* This is only to be used on CI that do not run in SCALE so we can skip the failure */}}
      {{- if not $rootCtx.Values.global.ixChartContext.ci -}}
        {{- fail (printf "%s - Namespace [%v] expected to have [ix-] prefix when installed in TrueNAS SCALE" $caller $namespace) -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- $namespace -}}

{{- end -}}
