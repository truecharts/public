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

  {{- $namespace -}}

{{- end -}}
