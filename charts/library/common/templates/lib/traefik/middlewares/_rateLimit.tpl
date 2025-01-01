{{- define "tc.v1.common.class.traefik.middleware.rateLimit" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $mw := $objectData.data -}}

  {{- if and (not $mw.average) (not $mw.burst) -}}
    {{- fail "Middleware (rate-limit) - Expected either [average] or [burst] to be set" -}}
  {{- end }}
  rateLimit:
    {{- if $mw.average }}
    average: {{ $mw.average }}
    {{- end -}}
    {{- if $mw.burst }}
    burst: {{ $mw.burst }}
    {{- end -}}
{{- end -}}
