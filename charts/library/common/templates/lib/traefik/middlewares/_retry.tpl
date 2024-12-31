{{- define "tc.v1.common.class.traefik.middleware.retry" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $mw := $objectData.data -}}
  {{- if not $mw.attempts -}}
    {{- fail "Middleware (retry) - Expected [attempts] to be set" -}}
  {{- end }}
  retry:
    attempts: {{ $mw.attempts }}
    {{- if $mw.initialInterval }}
    initialInterval: {{ $mw.initialInterval }}
    {{- end -}}
{{- end -}}
