{{- define "tc.v1.common.class.traefik.middleware.pluginRewriteResponseHeaders" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $mw := $objectData.data -}}

  {{/* This has to match with the name of the plugin given on the traefik CLI */}}
  {{- $mwName := "rewriteResponseHeaders" -}}
  {{- if $mw.pluginName -}}
    {{- $mwName = $mw.pluginName -}}
  {{- end -}}

  {{- if not $mw.rewrites -}}
    {{- fail "Middleware (rewrite-response-headers) - Expected [rewrites] to be set" -}}
  {{- end }}

  {{- if not (kindIs "slice" $mw.rewrites) -}}
    {{- fail (printf "Middleware (rewrite-response-headers) - Expected [rewrites] to be a list, but got [%s]" (kindOf $mw.rewrites)) -}}
  {{- end }}

  {{- range $index, $config := $mw.rewrites -}}
    {{- if not $config.header -}}
      {{- fail (printf "Middleware (rewrite-response-headers) - Expected [header] to be set for rewrite [%v]" $index) -}}
    {{- end -}}
    {{- if not $config.regex -}}
      {{- fail (printf "Middleware (rewrite-response-headers) - Expected [regex] to be set for rewrite [%v]" $index) -}}
    {{- end -}}
    {{- if not $config.replacement -}}
      {{- fail (printf "Middleware (rewrite-response-headers) - Expected [replacement] to be set for rewrite [%v]" $index) -}}
    {{- end -}}
  {{- end }}
  plugin:
    {{ $mwName }}:
      rewrites:
        {{- range $index, $rewriteResponseHeader := $mw.rewrites }}
        - header: {{ $rewriteResponseHeader.header }}
          regex: {{ $rewriteResponseHeader.regex | quote }}
          replacement: {{ $rewriteResponseHeader.replacement | quote }}
        {{- end }}
{{- end -}}
