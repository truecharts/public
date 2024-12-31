{{- define "tc.v1.common.class.traefik.middleware.replacePathRegex" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $mw := $objectData.data -}}
  {{- if not $mw.regex -}}
    {{- fail "Middleware (replace-path-regex) - Expected [regex] to be set" -}}
  {{- end -}}
  {{- if not $mw.replacement -}}
    {{- fail "Middleware (replace-path-regex) - Expected [replacement] to be set" -}}
  {{- end }}
  replacePathRegex:
    regex: {{ $mw.regex }}
    replacement: {{ $mw.replacement }}
{{- end -}}
