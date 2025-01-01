{{- define "tc.v1.common.class.traefik.middleware.retry" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $mw := $objectData.data -}}
  {{- if not $mw.attempts -}}
    {{- fail "Middleware (retry) - Expected [attempts] to be set" -}}
  {{- end }}
  retry:
    attempts: {{ $mw.attempts }}
    {{- include "tc.v1.common.class.traefik.middleware.helper.int" (dict "key" "initialInterval" "value" $mw.initialInterval) | nindent 4 }}
{{- end -}}
