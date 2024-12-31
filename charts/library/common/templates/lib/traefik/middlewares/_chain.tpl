{{- define "tc.v1.common.class.traefik.middleware.chain" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $rootCtx -}}

  {{- $mw := $objectData.data -}}
  {{- if not $mw.middlewares -}}
    {{- fail "Middleware (chain) - Expected [middlewares] to be set" -}}
  {{- end }}
  chain:
    middlewares:
      {{- range $m := $mw.middlewares -}}
        {{- $objectName := $m.name -}}
        {{- $expandName := (include "tc.v1.common.lib.util.expandName" (dict
            "rootCtx" $ "objectData" $m "key" "middlewares"
            "name" $objectName "caller" "Middleware (chain)"
        )) -}}

        {{- if eq $expandName "true" -}}
          {{- $objectName = (printf "%s-%s" $fullname $objectName) -}}
        {{- end }}
        - name: {{ $objectName }}
      {{- end -}}
{{- end -}}
