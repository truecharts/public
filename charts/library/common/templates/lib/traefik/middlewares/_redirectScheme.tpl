{{- define "tc.v1.common.class.traefik.middleware.redirectScheme" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $mw := $objectData.data -}}
  {{- if not $mw.scheme -}}
    {{- fail "Middleware (redirect-scheme) - Expected [scheme] to be set" -}}
  {{- end -}}

  {{- if hasKey $mw "permanent" -}}
    {{- if not (kindIs "bool" $mw.permanent) -}}
      {{- fail (printf "Middleware (redirect-scheme) - Expected [permanent] to be a boolean, but got [%s]" (kindOf $mw.permanent)) -}}
    {{- end -}}
  {{- end }}
  redirectScheme:
    scheme: {{ $mw.scheme }}
    {{- include "tc.v1.common.class.traefik.middleware.helper.bool" (dict "key" "permanent" "value" $mw.permanent) | nindent 4 }}
{{- end -}}
