{{- define "tc.v1.common.class.traefik.middleware.addPrefix" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $mw := $objectData.data -}}

  {{- if not $mw.prefix -}}
    {{- fail "Middleware (add-prefix) - Expected [prefix] to be set" -}}
  {{- end }}
  addPrefix:
    prefix: {{ $mw.prefix }}
{{- end -}}
