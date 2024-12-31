{{- define "tc.v1.common.class.traefik.middleware.replacePath" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $mw := $objectData.data -}}
  {{- if not $mw.path -}}
    {{- fail "Middleware (replace-path) - Expected [path] to be set" -}}
  {{- end }}
  replacePath:
    path: {{ $mw.path }}
{{- end -}}
