{{- define "tc.v1.common.class.traefik.middleware.rateLimit" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $mw := $objectData.data -}}

  {{- if and (not $mw.average) (not $mw.burst) -}}
    {{- fail "Middleware (rate-limit) - Expected either [average] or [burst] to be set" -}}
  {{- end }}
  rateLimit:
    {{- include "tc.v1.common.class.traefik.middleware.helper.int" (dict "key" "average" "value" $mw.average) | nindent 4 }}
    {{- include "tc.v1.common.class.traefik.middleware.helper.int" (dict "key" "burst" "value" $mw.burst) | nindent 4 }}
{{- end -}}
