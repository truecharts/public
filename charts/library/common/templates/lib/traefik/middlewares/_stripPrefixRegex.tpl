{{- define "tc.v1.common.class.traefik.middleware.stripPrefixRegex" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $mw := $objectData.data -}}
  {{- if not $mw.regex -}}
    {{- fail "Middleware (strip-prefix-regex) - Expected [regex] to be set" -}}
  {{- end }}
  stripPrefixRegex:
    regex:
      {{- range $mw.regex }}
      - {{ . | quote }}
      {{- end -}}
{{- end -}}
