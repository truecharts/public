{{/* Renders the Route objects required by the chart */}}
{{- define "tc.v1.common.spawner.routes" -}}
  {{- /* Generate named routes as required */ -}}
  {{- range $name, $route := .Values.route }}
    {{- if $route.enabled -}}
      {{- $routeValues := $route -}}

      {{/* set defaults */}}
      {{- if and (not $routeValues.nameOverride) (ne $name (include "tc.v1.common.lib.util.route.primary" $)) -}}
        {{- $_ := set $routeValues "nameOverride" $name -}}
      {{- end -}}

      {{- $_ := set $ "ObjectValues" (dict "route" $routeValues) -}}
      {{- include "tc.v1.common.class.route" $ | nindent 0 -}}
      {{- $_ := unset $.ObjectValues "route" -}}
    {{- end }}
  {{- end }}
{{- end }}
