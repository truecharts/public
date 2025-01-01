{{- define "tc.v1.common.class.traefik.middleware.redirectRegex" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $mw := $objectData.data -}}
  {{- if not $mw.regex -}}
    {{- fail "Middleware (redirect-regex) - Expected [regex] to be set" -}}
  {{- end -}}
  {{- if not $mw.replacement -}}
    {{- fail "Middleware (redirect-regex) - Expected [replacement] to be set" -}}
  {{- end -}}

  {{- if hasKey $mw "permanent" -}}
    {{- if not (kindIs "bool" $mw.permanent) -}}
      {{- fail (printf "Middleware (redirect-regex) - Expected [permanent] to be a boolean, but got [%s]" (kindOf $mw.permanent)) -}}
    {{- end -}}
  {{- end }}
  redirectRegex:
    regex: {{ $mw.regex }}
    replacement: {{ $mw.replacement }}
    {{- include "tc.v1.common.class.traefik.middleware.helper.bool" (dict "key" "permanent" "value" $mw.permanent) | nindent 4 }}
{{- end -}}
