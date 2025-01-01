{{- define "tc.v1.common.class.traefik.middleware.stripPrefix" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $mw := $objectData.data -}}
  {{- if not $mw.prefix -}}
    {{- fail "Middleware (strip-prefix) - Expected [prefix] to be set" -}}
  {{- end -}}

  {{- if hasKey $mw "forceSlash" -}}
    {{- if not (kindIs "bool" $mw.forceSlash) -}}
      {{- fail (printf "Middleware (strip-prefix) - Expected [forceSlash] to be a boolean, but got [%s]" (kindOf $mw.forceSlash)) -}}
    {{- end -}}
  {{- end }}
  stripPrefix:
    prefix:
      {{- range $mw.prefix }}
      - {{ . | quote }}
      {{- end -}}
    {{- include "tc.v1.common.class.traefik.middleware.helper.bool" (dict "key" "forceSlash" "value" $mw.forceSlash) | nindent 4 }}
{{- end -}}
